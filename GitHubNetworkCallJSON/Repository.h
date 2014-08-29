//
//  Repository.h
//  GitHubNetworkCallJSON
//
//  Created by Victor  Adu on 8/25/14.
//  Copyright (c) 2014 Victor  Adu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Repository : NSObject

@property(nonatomic,retain) NSString * url;
@property(nonatomic,retain) NSString * htmlURL;
@property(nonatomic,retain) NSString * myDescription;

@property(nonatomic,retain) NSString * login;
@property(nonatomic,retain) NSString * name;

-(Repository*)initFromDictionary:(NSDictionary*)dictionary;

@end
