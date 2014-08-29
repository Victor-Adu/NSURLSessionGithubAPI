//
//  NetworkController.h
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/27/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkController : NSObject

+(void)fetchRepositoriesForSearchTerm:(NSString *)searchterm withCompletion:(void(^)(NSArray *repositories, NSString *errorDescription))completionHandler;


@end
