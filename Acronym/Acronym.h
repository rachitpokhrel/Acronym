//
//  Acronym.h
//  Acronym
//
//  Created by Rachit on 8/28/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Acronym : NSObject
+(void)search:(NSString*)acronym result:(void(^)(NSArray *fullForms, NSError *error))block;
@end
