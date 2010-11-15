//
//  Profile.h
//  SSHLauncher
//
//  Created by Martin Jansen on 11.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Profile : NSObject {
    NSString* section;
    NSString* hostname;
    NSString* username;
    NSString* label;
    int port;
}

@property (retain) NSString* section;
@property (retain) NSString* hostname;
@property int port;
@property (retain) NSString* username;
@property (retain) NSString* label;

@end
