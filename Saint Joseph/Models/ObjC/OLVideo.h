//
//  OLVideoData.h
//  Saint Joseph
//
//  Created by Dharani on 7/23/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import "OLModel.h"

@protocol OLVideo

@end

@interface OLVideo : OLModel

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *videoID;
@property (nonatomic) NSInteger videoDate;
@property (nonatomic) NSString *videoDescription;
@property (nonatomic) NSString *updatedAt;
@end
