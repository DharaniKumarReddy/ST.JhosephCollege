//
//  OLModel.h
//  Saint Joseph
//
//  Created by Dharani on 7/15/16.
//  Copyright © 2016 Dharani. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 Base model, providing common convenience method(s).
 */
@interface OLModel : JSONModel

- (instancetype)initWithJsonString:(NSString *)jsonString;

@end
