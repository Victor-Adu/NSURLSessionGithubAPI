//
//  NetworkController.m
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/27/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import "NetworkController.h"
#import "Repository.h"

@interface NetworkController()


@end

@implementation NetworkController

//Make network call to github API
+(void)fetchRepositoriesForSearchTerm:(NSString *)searchterm withCompletion:(void(^)(NSArray *repositories, NSString *errorDescription))completionHandler; {

    NSString *mainURL = (@"https://api.github.com/search/repositories?&sort=stars&order=desc&q=");
    NSString *searchTermURL = (@"%@", searchterm);
    NSString *urlString = [mainURL stringByAppendingString:searchTermURL];
    
    NSLog(@"%@", urlString);
    
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            NSLog(@"General Error");
            NSLog([error localizedDescription]);
        } else {
            if ([response respondsToSelector:@selector(statusCode)]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                NSInteger responseCode = [httpResponse statusCode];
                switch (responseCode) {
                    case 200:
                        NSLog(@"Everything Looks Great");
                        completionHandler([NetworkController parseSuccessfulResponse:data], nil);
                        break;
                    case 400:
                        completionHandler(nil, @"400 Bad Parameters: Error in fetching data");
                        break;
                    case 401:
                        completionHandler(nil, @"401 Unauthorized: Authentication is required");
                        break;
                    case 403:
                        completionHandler(nil, @"403 Forbidden: Request was valid, but server refuses to respond");
                        break;
                    case 404:
                        completionHandler(nil, @"404 Not found: Requested resource not found");
                        break;
                    case 500:
                        completionHandler(nil, @"500: Error in fetching data. Try again next time");
                        break;
                    default:
                        NSLog(@"Request Error. Try again next time");
                        break;
                }
            } else {
                NSLog(@"Invalid Response Object: %@", response);
                completionHandler(nil, @"5xx Unknown Server Error");
            }
        }
    }];
    [dataTask resume];

}

//Parse through the fetched JSON GitHub data
+(NSArray *) parseSuccessfulResponse:(NSData *)responseData {
    NSMutableArray *repositories = [[NSMutableArray alloc]init];
    
    NSError *error = nil;
    NSDictionary *itemDict = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:&error];
    
    if (error != nil) {
        NSLog(@"%@", error.localizedDescription);
    }
    
    NSArray *parseJSONArray = itemDict[@"items"];
    
    for (NSDictionary *repositoryDict in parseJSONArray) {
        
        Repository *repo = [[Repository alloc]initFromDictionary:repositoryDict];
        [repositories addObject:repo];
        
    }
    
    return repositories;
}

@end
