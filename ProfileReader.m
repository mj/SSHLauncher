//
//  ProfileReader.m
//  SSHLauncher
//
//  Created by Martin Jansen on 23.09.10.
//  Copyright 2010 Bauer + Kirch GmbH. All rights reserved.
//

#import "ProfileReader.h"
#import "Profile.h"
#import "Section.h"
#import "NSFileManager+MJAdditions.h"

@interface ProfileReader (PRIVATE)

- (Section*) parseProfilesFrom:(NSArray*)anArray;
- (Profile*) parseProfileFrom:(NSDictionary *)aDictionary;

@end


@implementation ProfileReader

- (Section*) getProfiles {
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *path = [fileManager applicationSupportDirectory];    
    NSString* filename = [NSString stringWithFormat:@"%@/Profiles.plist", path];

    if (![fileManager fileExistsAtPath:filename]) {
        return nil;
    }

    NSArray* plist = [NSArray arrayWithContentsOfFile:filename];

    return [self parseProfilesFrom:plist];
}

- (Section*) parseProfilesFrom: (NSArray*) anArray {

    Section* result = [[Section alloc] init];

    result.profiles = [NSMutableArray arrayWithCapacity:0];
    result.subsections = [NSMutableArray arrayWithCapacity:0];
        
    for (int i = 0; i < [anArray count]; i++) {
        id element = [anArray objectAtIndex:i];        
        
        if ([element isKindOfClass: [NSDictionary class]]) {
            Profile* connection = [self parseProfileFrom:element];
            [result.profiles addObject:connection];
            continue;
        }
        
        if ([element isKindOfClass: [NSString class]]) {
            result.title = (NSString*)element;
            continue;
        }

        if ([element isKindOfClass: [NSArray class]]) {
            [result.subsections addObject:[self parseProfilesFrom:element]]; 
        }
    }
    
    return result;
}

- (Profile*) parseProfileFrom: (NSDictionary*) aDictionary {
    Profile* connection = [[Profile alloc] init];
    
    NSString* key;
    NSEnumerator *enumerator = [aDictionary keyEnumerator];
    
    while (key = [enumerator nextObject]) {
        [connection setValue:[aDictionary valueForKey:key] forKey:key];
    }

    return connection;
}


@end
