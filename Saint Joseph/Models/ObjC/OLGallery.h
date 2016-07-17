//
//  OLGallery.h
//  Saint Joseph
//
//  Created by Dharani on 7/16/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import "OLModel.h"
#import "OLImageItem.h"

@interface OLGallery : OLModel

@property (nonatomic) NSArray<OLImageItem *> *gallery;
@property (nonatomic) NSString *message;

@end
