//
//  JCSLocationController.m
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

#import "JCSLocationController.h"
#import "JCSLocation.h"


@interface JCSLocationController()

@property (nonatomic, copy) NSMutableArray<JCSLocation *> *internalLocations;

@end

@implementation JCSLocationController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internalLocations = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)fetchAllLocations:(NSString *)baseURLString completion:(JCSLocationControllerCompletionBlock)completion {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    
    NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:baseURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error fetching locations: %@", error);
            completion(nil, error);
            return;
        }
        
        NSError *jsonError;
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        if (!dictionary) {
            NSLog(@"Error decoding: %@", error);
            completion(nil, error);
            return;
        }
        
        NSArray *locationsArray = dictionary[@"zip_codes"];
        
        NSMutableArray *locations = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in locationsArray) {
            JCSLocation *location = [[JCSLocation alloc] initWithDictionary:dict];
            [locations addObject:location];
        }
        
        self.internalLocations = locations;
        NSLog(@"Successfully fetched all locations in radius! count = %lu", (unsigned long)self.internalLocations.count);
        completion(locations, nil);
        
    }];
    [task resume];
    
}

- (NSArray<JCSLocation *> *)locations {
    return self.internalLocations;
}

@end
