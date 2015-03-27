//
//  SOCategory.m
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOCategory.h"
#import "Constans.h"
#import "SOSubCategory.h"

#define kCategoryNameKey        @"categoryName"
#define kSubCategoryArrrayKey   @"subCategoryArray"
#define kUrlTOImage             @"urlToImage"

@interface SOCategory ()

@property (strong, nonatomic) NSString *categoryName;

@end

@implementation SOCategory

- (instancetype)initWithCategoryName:(NSDictionary *)dictionary {
    
    self = [super init];
    
    if (self) {
        _categoryName = [dictionary objectForKey:@"CategoryName"];
        _urlToImage = [NSURL URLWithString:[dictionary objectForKey:@"image"]];
        NSArray *temp = [dictionary objectForKey:@"data"];
        _subCategories = [[NSMutableArray alloc] init];
        for (int i = 0; i < [temp count]; i++) {
            SOSubCategory *subCategory = [[SOSubCategory alloc] initWithCategoryName:[temp objectAtIndex:i]];
            [self.subCategories addObject:subCategory];
        }
        //[self createCategory];
    }
    
    return self;
    
}

#pragma mark - NSCoping

-(id)copyWithZone:(NSZone *)zone {
    SOCategory *category = [[[self class] allocWithZone:zone] init];
    category -> _categoryName = [_categoryName copyWithZone:zone];
    category -> _urlToImage = [_urlToImage copyWithZone:zone];
    category -> _subCategories = [[NSMutableArray alloc] initWithArray:_subCategories copyItems:YES];
    /*
    category -> _subCategories = [[NSMutableArray alloc] init];//[_subCategories copyWithZone:zone];
    for (SOSubCategory *temp in self.subCategories) {
        [category -> _subCategories addObject:[temp copyWithZone:zone]];
    }*/
    //category -> _subCategories = [_subCategories copyWithZone:zone];
    return category;
}

#pragma mark - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
    [aCoder encodeObject:_categoryName forKey:kCategoryNameKey];
    [aCoder encodeObject:_subCategories forKey:kSubCategoryArrrayKey];
    [aCoder encodeObject:_urlToImage forKey:kUrlTOImage];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _categoryName = [aDecoder decodeObjectForKey:kCategoryNameKey];
        _subCategories = [aDecoder decodeObjectForKey:kSubCategoryArrrayKey];
        _urlToImage = [aDecoder decodeObjectForKey:kUrlTOImage];
    }
    return self;
}

- (void)createCategory {
    /*
    if ([self.categoryName isEqualToString:kCategoryFruitsVegetables]) {
        
        NSArray *tempArray = @[kSubCategoryFruit, kSubCategoryVegetables, kSubCategoryMushrooms, kSubCategoryNuts,  kSubCategorySalad, kSubCategoryDriedFruits];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryMeatFishBird]) {
        
        NSArray *tempArray = @[kSubCategoryBeef, kSubCategoryPork, kSubCategoryLamb, kSubCategoryShrimp,  kSubCategoryFish, kSubCategoryChicken];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryConfectionery]) {
        
        NSArray *tempArray = @[kSubCategoryCandy, kSubCategoryChocolate, kSubCategoryCookies, kSubCategoryCakes,  kSubCategoryCud];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }

    } else if ([self.categoryName isEqualToString:kCategoryMilkCheeseEggs]) {
        
        NSArray *tempArray = @[kSubCategoryMilk, kSubCategoryCheese, kSubCategoryEggs];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryGrocery]) {
        
        NSArray *tempArray = @[kSubCategoryCereals, kSubCategoryFlour, kSubCategoryPasta];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryDrinks]) {
        
        NSArray *tempArray = @[kSubCategoryWater, kSubCategoryJuice, kSubCategoryStrongDrinks,
                               kSubCategoryLowAlcholDrinks,  kSubCategoryWine];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryTobaccoProducts]) {
        
        NSArray *tempArray = @[kSubCategoryCigarettes, kSubCategoryCigars];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    } else if ([self.categoryName isEqualToString:kCategoryAllProductsCatalog]) {
        
        NSArray *tempArray = @[kSubCategoryFruit, kSubCategoryVegetables, kSubCategoryMushrooms, kSubCategoryNuts,  kSubCategorySalad, kSubCategoryDriedFruits];
        
        for (NSString *str in tempArray) {
            [self setSubCtegoryWithName:str];
        }
        
    }
    */
}

- (void)setSubCtegoryWithName:(NSString *)subCategoryName {
    
    //[self.subCategory setObject:[[SOSubCategory alloc] initWithCategoryName:subCategoryName] forKey:subCategoryName];
    
}

@end
