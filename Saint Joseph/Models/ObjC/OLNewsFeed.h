//
//  OLNewsFeed.h
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import "OLModel.h"

@interface OLNewsFeed : OLModel

@property (nonatomic) NSArray *sjpu_news;
@property (nonatomic) NSString *message;
@property (nonatomic) NSInteger success;

@end