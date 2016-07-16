//
//  OLNews.h
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import "OLModel.h"

@interface OLNews : OLModel

@property (nonatomic) NSInteger id;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *date;
@property (nonatomic) NSString *type;
@property (nonatomic) NSString *descript;
@property (nonatomic) NSString *updatedAt;

@end
