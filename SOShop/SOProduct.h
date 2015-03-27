//
//  SOProduct.h
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOProduct : NSObject <NSCoding, NSCopying>

+ (instancetype) new __attribute__((unavailable("new not available, call initWithDictionary instead")));
- (instancetype) init __attribute__((unavailable("init not available, call initWithDictionary instead")));

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *cost;
@property (strong, nonatomic) NSNumber *productId;
@property (strong, nonatomic) NSNumber *barCode;
@property (strong, nonatomic) NSString *dimension;
@property (strong, nonatomic) NSNumber *sale;
@property (strong, nonatomic) NSString *descriptionRus;
@property (strong, nonatomic) NSString *descriptionEng;
@property (strong, nonatomic) NSURL *urlToImage;

-(instancetype)initWithName:(NSString *)name cost:(NSNumber *)cost barCode:(NSNumber *)productBarCode dimension:(NSString *)dimension;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
