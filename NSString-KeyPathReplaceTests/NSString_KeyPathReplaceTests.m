//
//  NSString_KeyPathReplaceTests.m
//  NSString-KeyPathReplaceTests
//
//  Created by John McKerrell on 20/09/2015.
//  Copyright © 2015 MKE Computing Ltd. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSString+KeyPathReplace.h"

@interface NSString_KeyPathReplaceTests : XCTestCase

@end

@implementation NSString_KeyPathReplaceTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testVeryBasic {
    NSDictionary *dict = @{
                           @"value": @"World"
                           };
    NSString *result = [@"Hello {value}!" stringByReplacingKeyPathBindingsWithDictionaryValues:dict
                                                                                defaultValues:nil];
    XCTAssertEqualObjects(result, @"Hello World!");
}

- (void)testEscaping {
    NSDictionary *dict = @{
                           @"value": @"Vulcan"
                           };
    NSString *result = [@"Hello \\{value}!" stringByReplacingKeyPathBindingsWithDictionaryValues:dict
                                                                                 defaultValues:nil];
    XCTAssertEqualObjects(result, @"Hello {value}!");
}

- (void)testTwoLevels {
    NSDictionary *dict = @{
                           @"planet": @"World",
                           @"person": @{
                                   @"firstname": @"Joe",
                                   @"lastname": @"Bloggs"
                                   }
                           };
    NSString *result = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    XCTAssertEqualObjects(result, @"Hello World! Welcome Joe Bloggs.");
}

- (void)testVeryBasicDefaults {
    NSDictionary *dict = nil;
    NSDictionary *defaultValues = @{
                                    @"value": @"World"
                                    };
    NSString *result = [@"Hello {value}!" stringByReplacingKeyPathBindingsWithDictionaryValues:dict
                                                                                 defaultValues:defaultValues];
    XCTAssertEqualObjects(result, @"Hello World!");
}

- (void)testInlineDefaults {
    NSString *result = [@"Hello {value:World}!" stringByReplacingKeyPathBindingsWithDictionaryValues:nil
                                                                                 defaultValues:nil];
    XCTAssertEqualObjects(result, @"Hello World!");
}

- (void)testMultipleDefaults {
    NSDictionary *dict = nil;
    NSDictionary *defaultValues = @{
                                    @"value": @"World"
                                    };
    NSString *result = [@"Hello {value}! Welcome {person.name:friend}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict
                                                                                 defaultValues:defaultValues];
    XCTAssertEqualObjects(result, @"Hello World! Welcome friend.");
}

- (void)testTwoLevelsDefaults {
    NSDictionary *dict = @{
                           @"planet": @"World",
                           @"person": @{
                                   @"firstname": @"Joe",
                                   }
                           };
    NSDictionary *defaultValues = @{
                                    @"person": @{
                                            @"lastname": @"Bloggs"
                                            }
                                    };
    NSString *result = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict defaultValues:defaultValues];
    XCTAssertEqualObjects(result, @"Hello World! Welcome Joe Bloggs.");
}

- (void)testThreeLevels {
    NSDictionary *dict = @{
                           @"planet": @"World",
                           @"person": @{
                                   @"firstname": @"Joe",
                                   @"lastname": @"Bloggs",
                                   @"job": @{
                                           @"employer": @"Wayne Enterprises",
                                           @"position": @"Research"
                                           },
                                   @"children": @[
                                           @"Jane Bloggs",
                                           @"Matilda Bloggs",
                                           @"Jimmy Bloggs"
                                           ]
                                   }
                           };
    NSString *result = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}. I hope you enjoy your job at {person.job.employer}." stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    XCTAssertEqualObjects(result, @"Hello World! Welcome Joe Bloggs. I hope you enjoy your job at Wayne Enterprises.");

    // FIXME Array support isn't there yet, switch these tests to test "equal" and then fix them to add it!
    NSString *resultArr = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}. I hope you enjoy your job at {person.job.employer}. You have {person.children.count} children." stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    XCTAssertNotEqualObjects(resultArr, @"Hello World! Welcome Joe Bloggs. I hope you enjoy your job at Wayne Enterprises. You have 3 children, first of which is {person.children[0].");

    NSString *resultArr2 = [@"Hello {planet}! Welcome {person.firstname} {person.lastname}. I hope you enjoy your job at {person.job.employer}. You have {person.children.count} children." stringByReplacingKeyPathBindingsWithDictionaryValues:dict];
    XCTAssertNotEqualObjects(resultArr2, @"Hello World! Welcome Joe Bloggs. I hope you enjoy your job at Wayne Enterprises. You have 3 children, first of which is Jane Bloggs.");
}


- (void)testPerformanceLongStringEmptyDict {
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
        NSString *longString = @"next_url=alarm.htm&motion_armed={params.adminparams.alarm_motion_armed}&input_armed={params.adminparams.alarm_input_armed}&motion_sensitivity={params.adminparams.alarm_motion_sensitivity}&iolinkage={params.adminparams.alarm_iolinkage}&mail={params.adminparams.alarm_mail}&upload_interval={params.adminparams.alarm_upload_interval}&ioin_level={params.adminparams.alarm_ioin_level}&ioout_level={params.adminparams.alarm_ioout_level}&schedule_enable={params.adminparams.alarm_schedule_enable}&schedule_sun_0={params.adminparams.alarm_schedule_sun_0}&schedule_sun_1={params.adminparams.alarm_schedule_sun_1}&schedule_sun_2={params.adminparams.alarm_schedule_sun_2}&schedule_mon_0={params.adminparams.alarm_schedule_mon_0}&schedule_mon_1={params.adminparams.alarm_schedule_mon_1}&schedule_mon_2={params.adminparams.alarm_schedule_mon_2}&schedule_tue_0={params.adminparams.alarm_schedule_tue_0}&schedule_tue_1={params.adminparams.alarm_schedule_tue_1}&schedule_tue_2={params.adminparams.alarm_schedule_tue_2}&schedule_wed_0={params.adminparams.alarm_schedule_wed_0}&schedule_wed_1={params.adminparams.alarm_schedule_wed_1}&schedule_wed_2={params.adminparams.alarm_schedule_wed_2}&schedule_thu_0={params.adminparams.alarm_schedule_thu_0}&schedule_thu_1={params.adminparams.alarm_schedule_thu_1}&schedule_thu_2={params.adminparams.alarm_schedule_thu_2}&schedule_fri_0={params.adminparams.alarm_schedule_fri_0}&schedule_fri_1={params.adminparams.alarm_schedule_fri_1}&schedule_fri_2={params.adminparams.alarm_schedule_fri_2}&schedule_sat_0={params.adminparams.alarm_schedule_sat_0}&schedule_sat_1={params.adminparams.alarm_schedule_sat_1}&schedule_sat_2={params.adminparams.alarm_schedule_sat_2}&user={auth.username}&pwd={auth.password}";
        
        NSString *replacedString = [longString stringByReplacingKeyPathBindingsWithDictionaryValues:@{} defaultValues:@{}];
        XCTAssertEqualObjects(replacedString, @"next_url=alarm.htm&motion_armed=&input_armed=&motion_sensitivity=&iolinkage=&mail=&upload_interval=&ioin_level=&ioout_level=&schedule_enable=&schedule_sun_0=&schedule_sun_1=&schedule_sun_2=&schedule_mon_0=&schedule_mon_1=&schedule_mon_2=&schedule_tue_0=&schedule_tue_1=&schedule_tue_2=&schedule_wed_0=&schedule_wed_1=&schedule_wed_2=&schedule_thu_0=&schedule_thu_1=&schedule_thu_2=&schedule_fri_0=&schedule_fri_1=&schedule_fri_2=&schedule_sat_0=&schedule_sat_1=&schedule_sat_2=&user=&pwd=");
    }];
}

- (void)testPerformanceLongStringLargeDict {
    NSData *testData = [NSData dataWithContentsOfURL:[[NSBundle bundleForClass:[self class]] URLForResource:@"LargeTestDictionary" withExtension:@"json"]];
    XCTAssertNotNil(testData);
    NSDictionary *largeTestDictionary = @{@"params":[NSJSONSerialization JSONObjectWithData:testData options:0 error:nil]};
    [self measureBlock:^{
        NSString *longString = @"next_url=alarm.htm&motion_armed={params.adminparams.alarm_motion_armed}&input_armed={params.adminparams.alarm_input_armed}&motion_sensitivity={params.adminparams.alarm_motion_sensitivity}&iolinkage={params.adminparams.alarm_iolinkage}&mail={params.adminparams.alarm_mail}&upload_interval={params.adminparams.alarm_upload_interval}&ioin_level={params.adminparams.alarm_ioin_level}&ioout_level={params.adminparams.alarm_ioout_level}&schedule_enable={params.adminparams.alarm_schedule_enable}&schedule_sun_0={params.adminparams.alarm_schedule_sun_0}&schedule_sun_1={params.adminparams.alarm_schedule_sun_1}&schedule_sun_2={params.adminparams.alarm_schedule_sun_2}&schedule_mon_0={params.adminparams.alarm_schedule_mon_0}&schedule_mon_1={params.adminparams.alarm_schedule_mon_1}&schedule_mon_2={params.adminparams.alarm_schedule_mon_2}&schedule_tue_0={params.adminparams.alarm_schedule_tue_0}&schedule_tue_1={params.adminparams.alarm_schedule_tue_1}&schedule_tue_2={params.adminparams.alarm_schedule_tue_2}&schedule_wed_0={params.adminparams.alarm_schedule_wed_0}&schedule_wed_1={params.adminparams.alarm_schedule_wed_1}&schedule_wed_2={params.adminparams.alarm_schedule_wed_2}&schedule_thu_0={params.adminparams.alarm_schedule_thu_0}&schedule_thu_1={params.adminparams.alarm_schedule_thu_1}&schedule_thu_2={params.adminparams.alarm_schedule_thu_2}&schedule_fri_0={params.adminparams.alarm_schedule_fri_0}&schedule_fri_1={params.adminparams.alarm_schedule_fri_1}&schedule_fri_2={params.adminparams.alarm_schedule_fri_2}&schedule_sat_0={params.adminparams.alarm_schedule_sat_0}&schedule_sat_1={params.adminparams.alarm_schedule_sat_1}&schedule_sat_2={params.adminparams.alarm_schedule_sat_2}&user={auth.username}&pwd={auth.password}";
        
        NSString *replacedString = [longString stringByReplacingKeyPathBindingsWithDictionaryValues:largeTestDictionary defaultValues:@{}];
        XCTAssertEqualObjects(replacedString, @"next_url=alarm.htm&motion_armed=1&input_armed=0&motion_sensitivity=5&iolinkage=0&mail=1&upload_interval=0&ioin_level=0&ioout_level=0&schedule_enable=0&schedule_sun_0=0&schedule_sun_1=0&schedule_sun_2=0&schedule_mon_0=0&schedule_mon_1=0&schedule_mon_2=0&schedule_tue_0=0&schedule_tue_1=0&schedule_tue_2=0&schedule_wed_0=0&schedule_wed_1=0&schedule_wed_2=0&schedule_thu_0=0&schedule_thu_1=1152&schedule_thu_2=0&schedule_fri_0=0&schedule_fri_1=0&schedule_fri_2=0&schedule_sat_0=0&schedule_sat_1=0&schedule_sat_2=0&user=&pwd=");
    }];
}

@end
