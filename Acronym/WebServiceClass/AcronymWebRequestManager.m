//
//  AcronymWebRequestManager.m
//  Acronym
//
//  Created by Saranya's Workstation on 11/6/15.
//  Copyright © 2015 Saranya's Workstation. All rights reserved.
//

#import "AcronymWebRequestManager.h"


@implementation AcronymWebRequestManager


+(AcronymWebRequestManager *) sharedManger{
    
    static AcronymWebRequestManager *sharedManger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken,^{
        sharedManger = [[self alloc] init];
    });
    
    return sharedManger;
}

-(id) init{
   
    if(self = [super init]){
        
        _sessionManager = [AFHTTPSessionManager manager];
        _sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    
    return self;
}

/**
 requestDatawithParams - This  method is about taking search text as input and communicating with REST API and giving the output results
 */

-(void)requestDatawithParams:(NSDictionary *)parameters completion:(AcronymCompletionHandler)completion{
  
    // GET Method with inputs
    [_sessionManager GET:@MAINURL parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error;
        
        //JSONSearlization with NSData
        NSArray *jsonSerializer = [NSJSONSerialization JSONObjectWithData:responseObject options:1 error:&error];
        
        //Validating the data exists or not
        if(jsonSerializer.count){
            completion(jsonSerializer,nil);

        }else{
            completion(nil,nil);

        }
        

        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        completion(nil,error);

    }];
}


@end
