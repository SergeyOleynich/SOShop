//
//  SOSubCategory.h
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOSubCategory : NSObject <NSCoding, NSCopying>

@property (strong, nonatomic) NSString *subCategoryName;
@property (strong, nonatomic) NSMutableArray *products;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
//- (instancetype)initWithCategoryName:(NSDictionary *)dictionary;

@end
