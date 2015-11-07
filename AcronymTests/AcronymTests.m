//
//  AcronymTests.m
//  AcronymTests
//
//  Created by Saranya's Workstation on 11/6/15.
//  Copyright (c) 2015 Saranya's Workstation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AFNetworking.h"

@interface AcronymTests : XCTestCase

@end

@implementation AcronymTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
   // XCTAssert(YES, @"Pass");
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"Testing async method"];
    
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [sessionManager GET:@MAINURL parameters:@{ @"sf" : @"HMM"} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error;
        
        //JSONSearlization with NSData
        NSArray *jsonSerializer = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:&error];
        
        //Validating the data exists or not
        if(jsonSerializer.count){
            [expectation fulfill];
        }else{
            XCTFail(@"FAIL");
        }
        
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        XCTFail(@"Expectation failed with error:%@",error);
    }];
    
    [self waitForExpectationsWithTimeout:1
                                 handler:^(NSError *error) {
        if(error){
            XCTFail(@"Expectation failed with error:%@",error);
        }
    }];

}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
