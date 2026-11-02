//
//  AppKit.mm
//  dmcre
//
//  Created by Lilith on 09.08.26.
//

#import <AppKit/AppKit.h>

namespace dmcre {
	void AppKit_Main() {
		@autoreleasepool {
			[NSApplication sharedApplication];
			[NSApp setActivationPolicy:NSApplicationActivationPolicyAccessory];
			[NSApp run];
		}
	}
}
