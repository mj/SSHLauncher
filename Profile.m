//
//  Profile.m
//  SSHLauncher
//
//  Created by Martin Jansen on 11.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import "Profile.h"

@implementation Profile

@synthesize section;
@synthesize hostname;
@synthesize username;
@synthesize label;
@synthesize port;

- (id) init
{
    self = [super init];

    if (self) {
        port = 22;
        hostname = @"";
        username = [NSUserName() copy];
        label = @"";
    }

    return self;
}

//
// The getter method for the label returns the host name in case no label was
// specified.
//
- (NSString*) label
{
    if ([label isEqualToString:@""]) {
        return hostname;
    }
    return label;
}

@end
