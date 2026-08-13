//
//  App.swift
//  DMCRE-ARC-DEBUGGER
//
//  Created by Lilith on 03.04.26.
//

import AppKit
import SwiftUI
import Network
import Combine

private class ControlWindowDelegate: NSObject, NSWindowDelegate {
	var onWindowWillClose: () -> () = {};

	func windowWillClose(_ notification: Notification) {
		onWindowWillClose();
	}
}

class AppDelegate: NSObject, NSApplicationDelegate, ObservableObject {
	// MARK: runtime executable link
	@AppStorage("runtimeExecutableLinkPath") var runtimeExecutableLinkPath: String = "/usr/local/bin/dmcre";
	@AppStorage("runtimeExecutableAutoLink") var runtimeExecutableAutoLink: Bool = false;
	private func maybeLinkRuntimeExecutable() {
		if(!runtimeExecutableAutoLink) {
			return;
		}

		do {
			if(FileManager.default.fileExists(atPath: runtimeExecutableLinkPath)) {
				try FileManager.default.removeItem(atPath: runtimeExecutableLinkPath);
			}

			try FileManager.default.createSymbolicLink(
				atPath: runtimeExecutableLinkPath,
				withDestinationPath: Bundle.main.bundlePath+"/Contents/MacOS/CLI"
			);
		} catch(let error) {
			NSLog(error.localizedDescription)
		}
	}
	
	// MARK: status bar button
	private var controlWindow: NSWindow?
	private var controlWindowDelegate = ControlWindowDelegate();

	private var statusItem: NSStatusItem?
	
	@objc
	private func statusItemClicked() {
		if(controlWindow != nil) {
			controlWindow?.makeKeyAndOrderFront(nil);
		} else {
			controlWindow = NSWindow(
				contentRect: NSRect(x: 500, y: 500, width: 900, height: 600),
				styleMask: [.closable, .resizable, .miniaturizable, .fullSizeContentView, .titled],
				backing: .buffered,
				defer: false
			);
			
			controlWindow?.titleVisibility = .hidden;
			controlWindow?.titlebarAppearsTransparent = true;
			controlWindow?.toolbarStyle = .unified;
			controlWindow?.backgroundColor = .clear;
			controlWindow?.isOpaque = false;
			controlWindow?.titlebarSeparatorStyle = .none;
			
			controlWindow?.isReleasedWhenClosed = false;
			controlWindow?.delegate = controlWindowDelegate;
			
			controlWindowDelegate.onWindowWillClose = {
				self.controlWindow = nil;
			};
			
			controlWindow?.contentView = NSHostingView(rootView: ControlView(App: self));

			controlWindow?.makeKeyAndOrderFront(nil);
		}
	}
	
	private func installStatusBarItem() {
		let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
		self.statusItem = statusItem
		
		if let button = statusItem.button {
			button.title = "DMCRE";
			button.action = #selector(statusItemClicked);
			button.target = self;
		}
	}
	
	// MARK: Debug server
	private let queue = DispatchQueue(label: "WebSocketServer.queue")
	private var listener: NWListener?
	@Published var Debuggers: [Debugger] = [];
	
	private func startWebSocketServer() {
		do {
			guard let listenerPort = NWEndpoint.Port(rawValue: 10002) else {
				throw POSIXError(.EINVAL)
			}
			
			let websocketOptions = NWProtocolWebSocket.Options()
			websocketOptions.autoReplyPing = true
			websocketOptions.setClientRequestHandler(queue) { subprotocols, _ in
				NWProtocolWebSocket.Response(
					status: .accept,
					subprotocol: subprotocols.first,
					additionalHeaders: nil
				)
			}
			
			let tcpOptions = NWProtocolTCP.Options()
			let parameters = NWParameters(tls: nil, tcp: tcpOptions)
			parameters.allowLocalEndpointReuse = true
			parameters.includePeerToPeer = false
			parameters.defaultProtocolStack.applicationProtocols.insert(websocketOptions, at: 0)
			
			let listener = try NWListener(using: parameters, on: listenerPort)
			listener.stateUpdateHandler = { state in
				if case .failed(let error) = state {
					NSLog("listener failed: \(error.localizedDescription)")
				}
			}
			
			listener.newConnectionHandler = { [weak self] connection in
				guard let self else { return }
				
				DispatchQueue.main.async {
					let debugger = Debugger(with: connection);
					debugger.show();
					self.Debuggers.append(debugger);
				}
			}
			
			self.listener = listener
			listener.start(queue: queue)
		} catch {
			NSLog(error.localizedDescription)
		}
	}
	
	private func closeWebSocketServer() {
		listener?.cancel();
	}
	
	// MARK: launch
    func applicationDidFinishLaunching(_ notification: Notification) {
		maybeLinkRuntimeExecutable();
		installStatusBarItem();
		startWebSocketServer();
    }
	
	func applicationWillTerminate(_ notification: Notification) {
		closeWebSocketServer();
	}
}

@main
struct AppMain {
	static var delegate: AppDelegate = AppDelegate();

    static func main() {
		let application = NSApplication.shared;
		application.delegate = delegate;
		application.run();
    }
}
