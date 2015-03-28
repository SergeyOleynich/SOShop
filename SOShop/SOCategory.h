//
//  SOCategory.h
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOCategory : NSObject <NSCoding, NSCopying>

- (instancetype) init __attribute__((unavailable("init not available, call initWithCategoryName instead")));
+ (instancetype) new __attribute__((unavailable("init not available, call initWithCategoryName instead")));

@property (strong, nonatomic, readonly) NSString *categoryName;
@property (strong, nonatomic) NSMutableArray *subCategories;
@property (strong, nonatomic) NSURL *urlToImage;
//@property (strong, nonatomic) NSMutableArray *subCategoty;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//- (instancetype)initWithCategoryName:(NSDictionary *)dictionary;

@end
