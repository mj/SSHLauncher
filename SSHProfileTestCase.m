//
//  SSHProfileTest.m
//  SSHLauncher
//
//  Created by Martin Jansen on 11.05.10.
//  Copyright 2010 Bauer + Kirch GmbH. All rights reserved.
//

#import "SSHProfileTestCase.h"
#import "Profile.h"

@implementation SSHProfileTestCase

- (void) testInitialPortIs22
{
    Profile *p = [[Profile alloc] init];
    STAssertEquals(22, p.port, @"Port must be 22 initially.");
}

- (void) testInitialHostnameIsEmpty
{
    Profile *p = [[Profile alloc] init];
    STAssertEqualObjects(@"", p.hostname, @"Hostname must be empty initially.");
}

@end
