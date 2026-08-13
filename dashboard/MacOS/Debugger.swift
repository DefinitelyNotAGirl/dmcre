//
//  Debugger.swift
//  DMCRE-ARC-DEBUGGER
//
//  Created by Lilith on 03.04.26.
//

import SwiftUI
import Combine
import Network

private class DebuggerWindowDelegate: NSObject, NSWindowDelegate {
	var onWindowWillClose: () -> () = {};
	
	func windowWillClose(_ notification: Notification) {
		onWindowWillClose();
	}
}

class Debugger: ObservableObject, Identifiable {
	let id = UUID();
	
	// MARK: debugger sections
	@Published var moduleData: ModuleData = ModuleData();
	@Published var arcData: ARCData = ARCData();
	
	// MARK: window management
	private var window: NSWindow?
	private var windowDelegate = DebuggerWindowDelegate();
	
	func show() {
		if(window != nil) {
			window?.makeKeyAndOrderFront(nil);
		} else {
			window = NSWindow(
				contentRect: NSRect(x: 500, y: 500, width: 900, height: 600),
				styleMask: [.closable, .resizable, .miniaturizable, .fullSizeContentView, .titled],
				backing: .buffered,
				defer: false
			);
			
			window?.titleVisibility = .hidden;
			window?.titlebarAppearsTransparent = true;
			window?.toolbarStyle = .unified;
			window?.backgroundColor = .clear;
			window?.isOpaque = false;
			window?.titlebarSeparatorStyle = .none;
			
			window?.isReleasedWhenClosed = false;
			window?.delegate = windowDelegate;
			
			window?.contentView = NSHostingView(rootView: DebuggerView(debugger: self));
			
			window?.makeKeyAndOrderFront(nil);
		}
	}
	
	// MARK: network
	private let queue = DispatchQueue(label: "debugger.queue")
	let connection: NWConnection;
	@Published var connectionError: String?;
	@Published var isDisconnected = false;
	
	init(with: NWConnection) {
		connection = with;
		
		windowDelegate.onWindowWillClose = {
			self.window = nil;
		};
		
		connection.stateUpdateHandler = { state in
			Task { @MainActor in
				switch state {
					case .failed(let error):
						self.connectionError = error.localizedDescription;
						self.isDisconnected = true;
					case .cancelled:
						self.isDisconnected = true;
					default:
						break
				}
			}
		}
		
		connection.start(queue: queue);
		receiveNextMessage();
	}
	
	deinit {
		connection.stateUpdateHandler = nil
		connection.cancel()
	}
	
	func onReceive(data: Data?, context: NWConnection.ContentContext?, isComplete: Bool, error: NWError?) {
		if let error {
			connectionError = error.localizedDescription
			isDisconnected = true
			connection.cancel()
			return
		}
		
		guard let data else {
			if isComplete {
				isDisconnected = true
				connection.cancel()
			}
			return
		}
		
		guard let string = String(data: data, encoding: .utf8) else {
			receiveNextMessage()
			return
		}
		
		//NSLog(string)
		
		do {
			guard let message = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
				receiveNextMessage()
				return
			}
			
			moduleData.onMessage(message: message)
			arcData.onMessage(message: message)
		} catch let error {
			NSLog(error.localizedDescription)
		}
		
		receiveNextMessage()
	}
	
	func receiveNextMessage() {
		guard !isDisconnected else { return }
		
		connection.receiveMessage { data, context, isComplete, error in
			Task { @MainActor in
				self.onReceive(data: data, context: context, isComplete: isComplete, error: error)
			}
		}
	}
};
