//
//  SOSubCategory.m
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOSubCategory.h"
#import "SOProduct.h"

#define kSubCategoryNameKey   @"subCategoryName"
#define kProductsKey   @"productsArray"

@implementation SOSubCategory

- (instancetype)initWithCategoryName:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        _subCategoryName = [dictionary objectForKey:@"SubCategoryName"];
        NSArray *temp = [dictionary objectForKey:@"data"];
        _products = [[NSMutableArray alloc] init];
        for (int i = 0; i < [temp count]; i++) {
            SOProduct *product = [[SOProduct alloc] initWithDictionary:[temp objectAtIndex:i]];
            [self.products addObject:product];
        }
    }
    
    return self;
}

#pragma mark - NSCoping

-(id)copyWithZone:(NSZone *)zone {
    SOSubCategory *subCategory = [[[self class] allocWithZone:zone] init];
    subCategory -> _subCategoryName = [_subCategoryName copyWithZone:zone];
    subCategory -> _products = [[NSMutableArray alloc] initWithArray:_products copyItems:YES];
    /*
    subCategory -> _products = [[NSMutableArray alloc] init];//[_products copyWithZone:zone];
    for (SOProduct *temp in self.products) {
        [subCategory -> _products addObject:[temp copyWithZone:zone]];
    }*/
    return subCategory;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_subCategoryName forKey:kSubCategoryNameKey];
    [aCoder encodeObject:_products forKey:kProductsKey];

}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _subCategoryName = [aDecoder decodeObjectForKey:kSubCategoryNameKey];
        _products = [aDecoder decodeObjectForKey:kProductsKey];
    }
    return self;
}

@end
