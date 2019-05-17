//
//  JCSLocationController.h
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JCSLocationControllerCompletionBlock)(NSArray  * _Nullable locations, NSError  * _Nullable error);

@class JCSLocation;

NS_SWIFT_NAME(LocationController)
NS_ASSUME_NONNULL_BEGIN

@interface JCSLocationController : NSObject

- (instancetype)init;

@property (nonatomic, readonly) NSArray<JCSLocation *> *locations;

- (void)fetchAllLocations:(NSString *)baseURLString completion: (JCSLocationControllerCompletionBlock)completion;

@end

NS_ASSUME_NONNULL_END
