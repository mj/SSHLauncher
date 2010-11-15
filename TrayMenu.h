//
//  TrayMenu.h
//  SSHLauncher
//
//  Created by Martin Jansen on 15.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "UKFileWatcher.h"

@interface TrayMenu : NSObject
{
    @private
    NSStatusItem* statusItem;
}

- (NSMenu*) createMenu;

@end
