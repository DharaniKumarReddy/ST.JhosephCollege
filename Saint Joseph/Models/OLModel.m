//
//  OLModel.m
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import "OLModel.h"

@implementation OLModel

- (instancetype)initWithJsonString:(NSString *)jsonString {
    JSONModelError *error;
    Class actualSubclass = [self class];
    OLModel *model = [[actualSubclass alloc] initWithString:jsonString error:&error];

    if (error) {
        NSAssert(error == nil, @"An error occurred while serializing %@: %@",
                 NSStringFromClass(actualSubclass), error.localizedDescription);
    }

    return model;
}

@end
