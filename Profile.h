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
    NSString* command;
    NSString* label;
    int port;
}

@property (retain, nonatomic) NSString* section;
@property (retain, nonatomic) NSString* hostname;
@property int port;
@property (retain, nonatomic) NSString* username;
@property (retain, nonatomic) NSString* command;
@property (retain, nonatomic) NSString* label;

@end
