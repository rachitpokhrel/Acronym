//
//  Acronym.m
//  Acronym
//
//  Created by Rachit on 8/28/15.
//  Copyright (c) 2015 Rachit. All rights reserved.
//

#import "Acronym.h"
#import <AFNetworking/AFNetworking.h>

@implementation Acronym

+(void)search:(NSString*)acronym result:(void(^)(NSArray *fullForms, NSError *error))block
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
    [securityPolicy setAllowInvalidCertificates:YES];
    [manager setSecurityPolicy:securityPolicy];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:@"http://www.nactem.ac.uk/software/acromine/dictionary.py?%@=%@",@"sf",acronym];
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *error = nil;
        id JSON = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:&error];
        if ([(NSArray*)JSON count] > 0){
            NSArray *lfs = [JSON[0] objectForKey:@"lfs"];
            block(lfs, nil);
        }
        else
            block(nil, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        block(nil, error);
    }];
    
}

@end
