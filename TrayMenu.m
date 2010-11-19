//
//  TrayMenu.m
//  SSHLauncher
//
//  Created by Martin Jansen on 15.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import "TrayMenu.h"
#import "SSHProfileMenuItem.h"
#import "Profile.h"
#import "ProfileReader.h"
#import "Section.h"
#import "UKKQueue.h"
#import "NSFileManager+MJAdditions.h";

#pragma mark private method definitions

@interface TrayMenu (PRIVATE)

- (void) setupFileObservers;
- (void) configurationDidChange:(id) sender;

@end

#pragma mark -
#pragma mark Class implementation

@implementation TrayMenu

- (void) applicationDidFinishLaunching:(NSNotification*) notification
{
    statusItem = [[[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength] retain];
    
    [statusItem setMenu:[self createMenu]];
    [statusItem setHighlightMode:YES];
    [statusItem setImage:[NSImage imageNamed:@"application_osx_terminal.png"]];

    [self setupFileObservers];
}

- (void) actionQuit:(id) sender
{
    [NSApp terminate:sender];
}

- (void) actionSSH:(SSHProfileMenuItem*) sender
{
    Profile* profile = [sender profile];

    NSString *ssh = [NSString stringWithFormat:@"ssh -p %d %@@%@", profile.port, profile.username, profile.hostname];

    NSString* command = [NSString stringWithFormat:@"activate application \"Terminal\"\n"
                        "tell application \"System Events\"\n"
                        "    tell process \"Terminal\"\n"
                        "        keystroke \"t\" using command down\n"
                        "    end tell\n"
                        "end tell\n"
                        "tell application \"Terminal\" to do script \"%@\" in the last tab of window 1\n", ssh];

    NSAppleScript *script = [[NSAppleScript alloc] initWithSource:command];
    [script executeAndReturnError:nil];
}

- (NSMenu*) createMenuFromSection:(Section*) aSection withZone:(NSZone*) aMenuZone
{
    NSMenu *menu = [NSMenu allocWithZone:aMenuZone];

    NSImage* connectionImage = [NSImage imageNamed:@"application_osx_terminal.png"];

    for (int z = 0; z < [aSection.subsections count]; z++) {
        Section* section = [aSection.subsections objectAtIndex:z];
        
        NSMenu* submenu = [self createMenuFromSection:section withZone:aMenuZone];
        
        NSMenuItem* submenuItem = [[NSMenuItem alloc] init];
        submenuItem.title = section.title;
        [submenuItem setSubmenu:submenu];
        
        [menu addItem:submenuItem];
        [submenuItem release];
    }
     
    if ([aSection.subsections count] > 0 && [aSection.profiles count] > 0) {
        [menu addItem:[NSMenuItem separatorItem]];
    }
    
    for (int i = 0; i < [aSection.profiles count]; i++) {
        Profile* connection = [aSection.profiles objectAtIndex:i];
        
        SSHProfileMenuItem* menuitem = [[SSHProfileMenuItem allocWithZone:aMenuZone] init];
        
        [menuitem setProfile:connection];
        [menuitem setTitle:connection.label];
        [menuitem setTarget:self];
        [menuitem setAction:@selector(actionSSH:)];
        [menuitem setImage:connectionImage];
        
        [menu addItem:menuitem];
        [menuitem release];
    }

    return [menu autorelease];
}

- (NSMenu*) createMenu
{
    NSZone *menuZone = [NSMenu menuZone];

    ProfileReader* reader = [[ProfileReader alloc] init];
    Section* root = [reader getProfiles];
    [reader release];

    NSMenu* menu = [self createMenuFromSection:root withZone:menuZone];

    [menu addItem: [NSMenuItem separatorItem]];
    
    NSMenuItem* quitMenuItem = [menu addItemWithTitle:@"Quit" 
                                               action:@selector(actionQuit:) 
                                        keyEquivalent:@"q"];
    [quitMenuItem setToolTip:@"Quit application"];
    [quitMenuItem setTarget:self];

    return menu;
}

- (void) setupFileObservers
{
    UKKQueue* queue = [UKKQueue sharedFileWatcher];
    
    [queue addPathToQueue:[[NSFileManager defaultManager] applicationSupportDirectory]];
    
    NSWorkspace* workspace = [NSWorkspace sharedWorkspace];
    NSNotificationCenter* notificationCenter = [workspace notificationCenter];

    [notificationCenter addObserver:self 
                           selector:@selector(configurationDidChange:) 
                               name:UKFileWatcherWriteNotification
                             object:nil];
}

- (void) configurationDidChange: (id) sender
{
    NSMenu* newMenu = [self createMenu];    
    [statusItem setMenu:newMenu];
}

@end
