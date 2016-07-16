//
//  OLModel.h
//  AlwaysOn
//
//  Created by Kyle Thomas on 6/10/14.
//  Copyright (c) 2014 Onlife Health. All rights reserved.
//

#import <JSONModel/JSONModel.h>

/**
 Base model, providing common convenience method(s).
 */
@interface OLModel : JSONModel

- (instancetype)initWithJsonString:(NSString *)jsonString;

@end
