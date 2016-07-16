//
//  OLModel.m
//  AlwaysOn
//
//  Created by Kyle Thomas on 6/10/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
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
