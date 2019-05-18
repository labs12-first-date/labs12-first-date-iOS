//
//  JCSLocation.h
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JCSLocation : NSObject

- (instancetype)initWithZipcode:(NSString *)zipcode distance:(double)distance city:(NSString *)city state:(NSString *)state;
- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

// zipcode and radius: int and unit (25 mile)

// within dictionary - zip_codes: array of dictionaries
@property (nonatomic, copy) NSString *zipcode; //zip_code
@property (nonatomic) double distance;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;


@end

NS_ASSUME_NONNULL_END
