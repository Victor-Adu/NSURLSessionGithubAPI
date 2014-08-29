//
//  Repository.m
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/25/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import "Repository.h"

@implementation Repository

-(Repository*)initFromDictionary:(NSDictionary*)dictionary;
{
    self = [super init];
    
    if (self){
    
        self.name = dictionary[@"name"];
        self.htmlURL = dictionary[@"html_url"];
        self.myDescription = @"Test";
        
        NSDictionary *owner = dictionary[@"owner"];
        self.login = owner[@"login"];
        self.url = owner[@"url"];
        
    }

    return self;
}

@end
