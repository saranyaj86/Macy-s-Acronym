//
//  AcronymWebRequestManager.h
//  Acronym
//
//  Created by Saranya's Workstation on 11/6/15.
//  Copyright © 2015 Saranya's Workstation. All rights reserved.


/**
 This is about taking search text as input and communicating with REST API and giving the output results
  */

#import <Foundation/Foundation.h>

typedef void (^AcronymCompletionHandler) (NSArray *responseObject, NSError *error);


@interface AcronymWebRequestManager : NSObject

@property (strong,nonatomic) AFHTTPSessionManager *sessionManager;

+(AcronymWebRequestManager *) sharedManger;

-(void)requestDatawithParams:(NSDictionary *)parameters completion:(AcronymCompletionHandler)completion;

@end
