//
//  NSFileManager+MJAdditions.m
//  SSHLauncher
//
//  Created by Martin Jansen on 15.11.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import "NSFileManager+MJAdditions.h"


@implementation NSFileManager (MJAdditions)

// http://cocoawithlove.com/2010/05/finding-or-creating-application-support.html

/* Error handling is embarassingly poor in here. */

- (NSString *)findOrCreateDirectory:(NSSearchPathDirectory)searchPathDirectory
                           inDomain:(NSSearchPathDomainMask)domainMask
                appendPathComponent:(NSString *)appendComponent
                              error:(NSError **)errorOut
{
    // Search for the path
    NSArray* paths = NSSearchPathForDirectoriesInDomains(
                                                         searchPathDirectory,
                                                         domainMask,
                                                         YES);

    if ([paths count] == 0) {
        *errorOut = [NSError errorWithDomain:@"net.divbyzero.sshlauncher" code:-1 userInfo:nil];
        return nil;
    }
    
    // Normally only need the first path
    NSString *resolvedPath = [paths objectAtIndex:0];
    
    if (appendComponent) {
        resolvedPath = [resolvedPath stringByAppendingPathComponent:appendComponent];
    }
    
    // Check if the path exists
    BOOL exists;
    BOOL isDirectory;
    exists = [self fileExistsAtPath:resolvedPath
                        isDirectory:&isDirectory];

    if (!exists || !isDirectory) {
        if (exists) {
            *errorOut = [NSError errorWithDomain:@"net.divbyzero.sshlauncher" code:-1 userInfo:nil];
            return nil;
        }
        
        // Create the path if it doesn't exist
        NSError *error;
        BOOL success = [self createDirectoryAtPath:resolvedPath
                       withIntermediateDirectories:YES
                                        attributes:nil
                                             error:&error];

        if (!success) {
            if (errorOut) {
                *errorOut = error;
            }
            return nil;
        }
    }
    
    if (errorOut) {
        *errorOut = nil;
    }
    
    return resolvedPath;
}

/* Returns the path to the application support directory for the current
 * application.
 */
- (NSString *)applicationSupportDirectory {
    NSString *executableName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleExecutable"];
    NSError *error;

    NSString *result = [self findOrCreateDirectory:NSApplicationSupportDirectory
                                          inDomain:NSUserDomainMask
                               appendPathComponent:executableName
                                             error:&error];

    if (error) {
        NSLog(@"Unable to find or create application support directory:\n%@", error);
    }
    
    return result;
}
@end
