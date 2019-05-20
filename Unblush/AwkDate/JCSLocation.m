//
//  JCSLocation.m
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSLocation.h"

@implementation JCSLocation

- (instancetype)initWithZipcode:(NSString *)zipcode distance:(double)distance city:(NSString *)city state:(NSString *)state {
    self = [super init];
    if (self) {
        _zipcode = zipcode;
        _distance = distance;
        _city = city;
        _state = state;
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    NSString *zipcode = dictionary[@"zip_code"];
    double distance = [dictionary[@"distance"] doubleValue];
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    
    return [self initWithZipcode:zipcode distance:distance city:city state:state];
    
}

@end
