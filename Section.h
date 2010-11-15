//
//  Section.h
//  SSHLauncher
//
//  Created by Martin Jansen on 23.09.10.
//  Copyright 2010 Bauer + Kirch GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Section : NSObject {
    NSString* title;
    NSMutableArray* profiles;
    NSMutableArray* subsections;
}

@property (assign) NSString* title;
@property (assign) NSMutableArray* profiles;
@property (assign) NSMutableArray* subsections;

@end
