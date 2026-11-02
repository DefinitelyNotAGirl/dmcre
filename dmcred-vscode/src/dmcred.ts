import * as child_process from 'child_process';
import * as vscode from 'vscode';

var CallId: bigint = BigInt(0) as bigint;

var dmcred_process: child_process.ChildProcess | undefined = undefined;
var dmcred_output: vscode.OutputChannel | undefined = undefined;

const replyCallbackMap = new Map<bigint,(result: any,status: number) => void>();
const FunctionMap = new Map<string,(data: any,reply: (result: any) => Promise<void>) => void>();

var IpcInputBuffer = Buffer.alloc(0);
var IpcInputWaitLength = 0;
var IpcInputWaitResolve: (() => void) | undefined = undefined;

async function IpcRead(bytes: number): Promise<Buffer> {
	if(IpcInputBuffer.byteLength < bytes) {
		IpcInputWaitLength = bytes;
		await new Promise<void>((resolve,reject) => {
			IpcInputWaitResolve = resolve;
		});
		IpcInputWaitResolve = undefined;
	}

	const res = IpcInputBuffer.subarray(0,bytes);

	IpcInputBuffer = IpcInputBuffer.subarray(bytes);

	return res;
}

export function restart() {
	if(dmcred_output === undefined) {
		dmcred_output = vscode.window.createOutputChannel('dmcred');
		dmcred_output.show(true);
	}
	if(dmcred_process !== undefined) {
		dmcred_process.kill();
	}

	dmcred_process = child_process.spawn('dmcred',{cwd: vscode.workspace.workspaceFolders![0].uri.fsPath});
	if(dmcred_process === undefined) {
		console.error("failed to spawn dmcred!");
		return;
	}

	dmcred_process.stderr?.on('data', chunk => {
	    dmcred_output?.append(chunk.toString());
	});

	dmcred_process.stdout?.on('data', chunk => {
	    IpcInputBuffer = Buffer.concat([IpcInputBuffer,chunk]);
		if(IpcInputWaitResolve && (IpcInputBuffer.byteLength >= IpcInputWaitLength)) {
			IpcInputWaitResolve();
		}
	});
}

export function shutdown() {
	if(dmcred_process !== undefined) {
		dmcred_process.kill();
	}
}


export function RegisterFunction(func: string,callback: (data: any,reply: (result: any) => Promise<void>) => void) {
	FunctionMap.set(func,callback);
}

export async function run() {
	while(true) {
		if(!dmcred_process || !dmcred_process.stdout) {
			return;
		}

		const type = (await IpcRead(4)).readUint32LE();

		async function ReadIpcString(): Promise<string> {
			const length = (await IpcRead(8)).readBigUInt64LE();
			let string = '';
			for(let i = 0;i<length;i++) {
				string += String.fromCodePoint((await IpcRead(4)).readUint32LE());
			}
			return string;
		}

		async function ReadIpcObject(): Promise<any> {
			const type = (await IpcRead(2)).readUInt16LE();
			if(type === 0x0001) {
				const obj = [];
				const count = (await IpcRead(4)).readUint32LE();
				for(let i = 0;i<count;i++) {
					obj.push(await ReadIpcObject());
				}
				return obj;
			}
			else if(type === 0x0002) {
				const obj = {} as {[s: string]: any};
				const count = (await IpcRead(4)).readUint32LE();
				for(let i = 0;i<count;i++) {
					const name = await ReadIpcString();
					obj[name] = await ReadIpcObject();
				}
				return obj;
			}
			else if(type === 0x0003) {
				return await ReadIpcString();
			}
			else if(type === 0x0004) {
				return (await IpcRead(8)).readDoubleLE();
			}
			else if(type === 0x0005) {
				return (await IpcRead(1)).readUInt8() === 0 ? false : true;
			}
		}
		
		if(type === 0x00000002) {
			const callId = (await IpcRead(8)).readBigInt64LE();
			const status = (await IpcRead(4)).readUint32LE();
			const result = status === 0 ? await ReadIpcObject() : undefined;
			if(replyCallbackMap.has(callId)) {
				replyCallbackMap.get(callId)!(result,status);
			}
		}
		else if(type === 0x00000001) {
			const callId = (await IpcRead(8)).readBigInt64LE();
			const func = await ReadIpcString();
			const data = await ReadIpcObject();
			if(FunctionMap.has(func)) {
				FunctionMap.get(func)!(data,async (result: any) => {
					let bufferSize = 16;

					let processEntry = (entry: any) => {
						bufferSize += 2;
						if(typeof(entry) === 'object') {
							bufferSize += 4;
							if(Object.prototype.toString.call(entry) === '[object Array]') {
								Object.entries(entry).forEach(([name,value]) => {
									processEntry(value);
								});
							} else {
								Object.entries(entry).forEach(([name,value]) => {
									bufferSize += 8;
									bufferSize += name.length * 4;
									processEntry(value);
								});
							}
						}
						else if(typeof(entry) === 'string') {
							bufferSize += 8;
							bufferSize += entry.length * 4;
						}
						else if(typeof(entry) === 'number') {
							bufferSize += 8;
						}
						else if(typeof(entry) === 'boolean') {
							bufferSize += 1;
						}
					};
					processEntry(result);
				
					const buffer = Buffer.alloc(bufferSize);
					let offset = 0;
				
					buffer.writeUInt32LE(0x00000002,offset);
					offset+=4;
				
					buffer.writeBigUInt64LE(callId,offset);
					offset+=8;

					buffer.writeUInt32LE(0x00000000,offset);
					offset+=4;
				
					processEntry = (entry: any) => {
						if(typeof(entry) === 'object') {
							if(Object.prototype.toString.call(entry) === '[object Array]') {
								buffer.writeUInt16LE(0x0001,offset);
								offset+=2;
								buffer.writeUInt32LE(Object.entries(entry).length,offset);
								offset+=4;
								Object.entries(entry).forEach(([name,value]) => {
									processEntry(value);
								});
							} else {
								buffer.writeUInt16LE(0x0002,offset);
								offset+=2;
								buffer.writeUInt32LE(Object.entries(entry).length,offset);
								offset+=4;
								Object.entries(entry).forEach(([name,value]) => {
									buffer.writeBigInt64LE(BigInt(name.length),offset);
									offset+=8;
									for(let i = 0;i<name.length;i++) {
										buffer.writeUInt32LE(name.charCodeAt(i),offset);
										offset+=4;
									}
									processEntry(value);
								});
							}
						}
						else if(typeof(entry) === 'string') {
							buffer.writeUInt16LE(0x0003,offset);
							offset+=2;
							buffer.writeBigInt64LE(BigInt(entry.length),offset);
							offset+=8;
							for(let i = 0;i<entry.length;i++) {
								buffer.writeUInt32LE(entry.charCodeAt(i),offset);
								offset+=4;
							}
						}
						else if(typeof(entry) === 'number') {
							buffer.writeUInt16LE(0x0004,offset);
							offset+=2;
							buffer.writeDoubleLE(entry,offset);
							offset+=8;
						}
						else if(typeof(entry) === 'boolean') {
							buffer.writeUInt16LE(0x0005,offset);
							offset+=2;
							buffer.writeUInt8(entry ? 1 : 0);
							offset+=1;
						}
					};
					processEntry(result);
					if(offset !== buffer.length) {
						throw new Error(`IPC reply size mismatch: wrote ${offset} bytes into ${buffer.length}-byte buffer`);
					}
					buffer.writeUInt32LE(0x00000002,0);
				
					dmcred_process!.stdin?.write(buffer);
				});
			}
		}
	}
}

export async function call(func: string,data: any): Promise<any> {
	return new Promise((resolve,reject) => {
		const process = dmcred_process;
		if(process === undefined || process.stdin === null) {
			console.error(call,'(',func,',',data,')','failed, no dmcred process');
			reject('no dmcred process');
			return;
		}

		let bufferSize = 12;

		let processEntry = (entry: any) => {
			bufferSize += 2;
			if(typeof(entry) === 'object') {
				bufferSize += 4;
				if(Object.prototype.toString.call(entry) === '[object Array]') {
					Object.entries(entry).forEach(([name,value]) => {
						processEntry(value);
					});
				} else {
					Object.entries(entry).forEach(([name,value]) => {
						bufferSize += 8;
						bufferSize += name.length * 4;
						processEntry(value);
					});
				}
			}
			else if(typeof(entry) === 'string') {
				bufferSize += 8;
				bufferSize += entry.length * 4;
			}
			else if(typeof(entry) === 'number') {
				bufferSize += 8;
			}
			else if(typeof(entry) === 'boolean') {
				bufferSize += 1;
			}
		};
		processEntry(data);
		bufferSize += 8;
		bufferSize += func.length * 4;

		const buffer = Buffer.alloc(bufferSize);
		let offset = 0;

		const callId = CallId++;

		buffer.writeUInt32LE(0x00000001,offset);
		offset+=4;

		buffer.writeBigUInt64LE(callId,offset);
		offset+=8;

		buffer.writeBigUInt64LE(BigInt(func.length),offset);
		offset+=8;

		for(let i = 0;i<func.length;i++) {
			buffer.writeUInt32LE(func.charCodeAt(i),offset);
			offset+=4;
		}

		processEntry = (entry: any) => {
			if(typeof(entry) === 'object') {
				if(Object.prototype.toString.call(entry) === '[object Array]') {
					buffer.writeUInt16LE(0x0001,offset);
					offset+=2;
					buffer.writeUInt32LE(Object.entries(entry).length,offset);
					offset+=4;
					Object.entries(entry).forEach(([name,value]) => {
						processEntry(value);
					});
				} else {
					buffer.writeUInt16LE(0x0002,offset);
					offset+=2;
					buffer.writeUInt32LE(Object.entries(entry).length,offset);
					offset+=4;
					Object.entries(entry).forEach(([name,value]) => {
						buffer.writeBigInt64LE(BigInt(name.length),offset);
						offset+=8;
						for(let i = 0;i<name.length;i++) {
							buffer.writeUInt32LE(name.charCodeAt(i),offset);
							offset+=4;
						}
						processEntry(value);
					});
				}
			}
			else if(typeof(entry) === 'string') {
				buffer.writeUInt16LE(0x0003,offset);
				offset+=2;
				buffer.writeBigInt64LE(BigInt(entry.length),offset);
				offset+=8;
				for(let i = 0;i<entry.length;i++) {
					buffer.writeUInt32LE(entry.charCodeAt(i),offset);
					offset+=4;
				}
			}
			else if(typeof(entry) === 'number') {
				buffer.writeUInt16LE(0x0004,offset);
				offset+=2;
				buffer.writeDoubleLE(entry,offset);
				offset+=8;
			}
			else if(typeof(entry) === 'boolean') {
				buffer.writeUInt16LE(0x0005,offset);
				offset+=2;
				buffer.writeUInt8(entry ? 1 : 0);
				offset+=1;
			}
		};
		processEntry(data);

		replyCallbackMap.set(callId,(result,status) => {
			replyCallbackMap.delete(callId);
			if(status === 0) {
				resolve(result);
			}
			else {
				reject();
			}
		});
		if(offset !== buffer.length) {
			replyCallbackMap.delete(callId);
			reject(new Error(`IPC call size mismatch for ${func}: wrote ${offset} bytes into ${buffer.length}-byte buffer`));
			return;
		}

		try {
			process.stdin.write(buffer);
		} catch(error) {
			replyCallbackMap.delete(callId);
			reject(error);
		}
	});
}
