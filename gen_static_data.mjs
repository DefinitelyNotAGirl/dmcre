import * as fs from 'fs';

const MaxBytesPerLine = 24;

let BytesOnLine = 0;
let CurrentPosition = 0;

var code_src = `
#include <dmcre/data.hpp>
const uint8_t StaticData[] = {\n\t`;
var code_header = `
#pragma once
#include <cstddef>
#include <cstdint>
extern const uint8_t StaticData[];
`;

function AddByte(value) {
	if(BytesOnLine == MaxBytesPerLine) {
		code_src += `\n\t`;
		BytesOnLine = 0;
	}
	code_src += `${value},`;
	BytesOnLine++;
	CurrentPosition++;
}

function AddDataVariable(type,name) {
	code_header += `static const ${type}* ${name} = (${type}*)(StaticData + 0x${CurrentPosition.toString(16)});\n`;
}

function MarkSection(title) {
	BytesOnLine = 0;
	code_src += `\n\t//${title}\n\t`;
}

function PadToPosition(position) {
	MarkSection(`pad to 0x${position.toString(16)}, bytes unused: ${position - CurrentPosition}`);
	if(position < CurrentPosition) {
		throw `cannot move backwards to position 0x${position.toString(16)} from current position 0x${CurrentPosition.toString(16)}`
	}
	while(position > CurrentPosition) {
		AddByte(`NULL`);
		CurrentPosition++;
	}
}

(() => {
	PadToPosition(0);
	MarkSection("byte => hex map");
	AddDataVariable("uint16_t","Uint8ToHexAsciiMap");
	const hex_chars = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'];
	hex_chars.forEach((char_front) => {
		hex_chars.forEach((char_back) => {
			AddByte(`'${char_front}'`);
			AddByte(`'${char_back}'`);
		});
	});
})();

(() => {
	PadToPosition(0x3030); // <== ascii "00"
	MarkSection("hex => byte map");
	AddDataVariable("uint8_t","HexAsciiToUint8Map");
	const hex_chars = ['0','1','2','3','4','5','6','7','8','9','a','b','c','d','e','f'];
	hex_chars.forEach((char_front) => {
		hex_chars.forEach((char_back) => {
			const tp = parseInt(`0x${(char_front).charCodeAt(0).toString(16)}${(char_back).charCodeAt(0).toString(16)}`);
			const va = parseInt(`0x${char_front}${char_back}`);
			console.log(`target position: 0x${tp.toString(16)}`);
			if(tp > CurrentPosition) {
				PadToPosition(tp);
			}
			AddByte(va);
		});
	});
})();

// print code_src, this must stay at the end of the script
//console.log(`code_src:\n${code_src}\n};`);

fs.writeFileSync(`src/data.cpp`,`${code_src}\n};`);
fs.writeFileSync(`inc/dmcre/data.hpp`,`${code_header}`);
