//
//  SSHProfileMenuItem.h
//  SSHLauncher
//
//  Created by Martin Jansen on 15.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Profile;

@interface SSHProfileMenuItem : NSMenuItem {
    Profile *profile;
}

@property (retain) Profile *profile;

@end
