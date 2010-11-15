//
//  StringUtilsTest.m
//  SSHLauncher
//
//  Created by Martin Jansen on 13.05.10.
//  Copyright 2010 Martin Jansen. All rights reserved.
//

#import "StringUtilsTestCase.h"
#import "StringUtils.h"

@implementation StringUtilsTestCase

- (void) testRepeat
{
    NSString* result;
    
    result = [StringUtils repeat: @"hello" times: 3];
    STAssertEqualObjects(@"hellohellohello", result, @"String repetition does not work.");
    
    result = [StringUtils repeat: @"hello" times: 0];
    STAssertEqualObjects(@"", result, @"String repetition does not work.");
    
    result = [StringUtils repeat: @"" times: 0];
    STAssertEqualObjects(@"", result, @"String repetition does not work.");

    result = [StringUtils repeat: @"" times: 10];
    STAssertEqualObjects(@"", result, @"String repetition does not work.");

    result = [StringUtils repeat: @"a" times: 2];
    STAssertEqualObjects(@"aa", result, @"String repetition does not work.");

    result = [StringUtils repeat: @"a" times: 1];
    STAssertEqualObjects(@"a", result, @"String repetition does not work.");

    result = [StringUtils repeat: @"a" times: 0];
    STAssertEqualObjects(@"", result, @"String repetition does not work.");
}

- (void) testContainsDigits 
{
    STAssertTrue([StringUtils containsDigits: @"1"], @"");
    STAssertTrue([StringUtils containsDigits: @"a1a"], @"");
    STAssertTrue([StringUtils containsDigits: @"aa1"], @"");
    STAssertTrue([StringUtils containsDigits: @"  1 b 2"], @"");

    STAssertFalse([StringUtils containsDigits: @""], @"");
    STAssertFalse([StringUtils containsDigits: @" "], @"");
    STAssertFalse([StringUtils containsDigits: @"a"], @"");

    STAssertTrue([StringUtils containsDigits: @"0"], @"");
    STAssertTrue([StringUtils containsDigits: @"0123456789"], @"");
    STAssertTrue([StringUtils containsDigits: @"0123456789a"], @"");
}

- (void) testContainsOnlyDigits 
{
    STAssertTrue([StringUtils containsOnlyDigits: @"1"], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @"a1a"], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @"aa1"], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @"  1 b 2"], @"");
    
    STAssertFalse([StringUtils containsOnlyDigits: @""], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @" "], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @"a"], @"");
    
    STAssertTrue([StringUtils containsOnlyDigits: @"0"], @"");
    STAssertTrue([StringUtils containsOnlyDigits: @"0123456789"], @"");
    STAssertFalse([StringUtils containsOnlyDigits: @"0123456789a"], @"");
}
@end
