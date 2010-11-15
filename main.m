//
//  main.m
//  SSHLauncher
//
//  Created by Martin Jansen on 11.05.10.
//  Copyright Martin Jansen 2010. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TrayMenu.h";

int main(int argc, char *argv[])
{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    [NSApplication sharedApplication];
    
    TrayMenu *app = [[TrayMenu alloc] init];

    [NSApp setDelegate: app];
    [NSApp run];
    
    [pool release];

    return EXIT_SUCCESS;
}
