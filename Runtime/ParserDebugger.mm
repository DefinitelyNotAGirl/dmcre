//
//  ParserDebugger.mm
//  dmcre
//
//  Created by Lilith on 09.08.26.
//

#include <dmcre/ParserDebugger.hpp>

#import <AppKit/AppKit.h>
#import <CoreText/CoreText.h>
#import <CoreGraphics/CoreGraphics.h>
#include <dispatch/dispatch.h>
#include <pthread.h>

#include "Runtime-Swift.h"

namespace dmcre {
	class ParserDebugger::Impl_T {
	public:
		__strong NSWindow* window = nil;
	
		__strong NSView* view = nil;
		
		__strong ParserDebuggerViewController* controller = nil;
	
		void performOnMainSync(dispatch_block_t block) {
			// dispatch_sync(main) from the main queue would deadlock.
			if(pthread_main_np()) {
				block();
			} else {
				dispatch_sync(
					dispatch_get_main_queue(),
					block
				);
			}
		}
	};

	ParserDebugger::ParserDebugger(uint32_t* characters,uint64_t count) {
		impl = new Impl_T;

		impl->performOnMainSync(^{
			NSRect frame = NSMakeRect(100.0,100.0,600.0,400.0);
			
			impl->window = [
				[NSWindow alloc]
				initWithContentRect:frame
				styleMask:
					NSWindowStyleMaskTitled |
					NSWindowStyleMaskClosable |
			 		NSWindowStyleMaskResizable
				backing:NSBackingStoreBuffered
			 	defer:NO
			];
			
			[impl->window setTitle:@"Parser Debugger"];
			
			impl->controller = [[ParserDebuggerViewController alloc] init];
			[impl->controller setTextWithCharacters:characters count:count];
			
			impl->view = [impl->controller getView];

			[impl->window setContentView:impl->view];
			[impl->window makeKeyAndOrderFront:nil];
			[impl->window orderFrontRegardless];
		});
	}
	
	ParserDebugger::~ParserDebugger() {
		impl->performOnMainSync(^{
			[impl->window orderOut:nil];
			impl->view = nil;
			impl->window = nil;
			impl->controller = nil;
		});
		
		delete impl;
	}
	
	
	
	void ParserDebugger::setCharacterState(uint64_t n,CharacterState state) {
		impl->performOnMainSync(^{
			if(state == CharacterState::unseen) {
				[impl->controller setCharacterColorWithIndex:n color:[NSColor colorWithHue:0/360 saturation:0.0 brightness:1.0 alpha:1.0]];
			}
			else if(state == CharacterState::skipped) {
				[impl->controller setCharacterColorWithIndex:n color:[NSColor colorWithHue:20/360 saturation:0.75 brightness:0.75 alpha:1.0]];
			}
			else if(state == CharacterState::consumed) {
				[impl->controller setCharacterColorWithIndex:n color:[NSColor colorWithHue:150/360 saturation:0.75 brightness:0.75 alpha:1.0]];
			}
		});
		if(sleep_us > 0) {
			usleep(sleep_us);
		}
	}
	
	void ParserDebugger::setPosition(uint64_t n) {
		impl->performOnMainSync(^{
			[impl->controller setCharacterColorWithIndex:n color:[NSColor colorWithHue:270.00/360.00 saturation:1.0 brightness:1.0 alpha:1.0]];
		});
		if(sleep_us > 0) {
			usleep(sleep_us);
		}
	}
}
