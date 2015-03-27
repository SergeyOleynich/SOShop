//
//  SOStore.h
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOProduct;

@interface SOStoreManager : NSObject

+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

+ (SOStoreManager *)sharedManager;

//add from json

- (void)parseProductsFromJSON:(id)json;

//add from xml

- (void)parseProductsFromXML:(id)xml;

//add manually

- (void)addProduct:(SOProduct *)product forProductSubCategory:(NSString *)key withFailure:(void(^)(NSDictionary *error))failure;
- (void)addProductsFromArray:(NSArray *) productsArray forProductCategory:(NSString *) key;

// getters

- (NSArray *)getCategories;
- (NSArray *)getAllSubCategoryNamesByCategoryName:(NSString *)categoryName;
- (NSSet *)getAllProductsBySubCategoryName:(NSString *)subCategoryName andCategoryName:(NSString *)categoryName;

- (NSNumber *)getAllProductsCost;
- (NSArray *)getAllProductsBarCode;
- (NSArray *)getAllProductsId;
- (NSArray *)getAllProductsName;

- (NSArray *)getAllProductCostByCategory:(NSString *)category;
- (NSArray *)getAllProductBarCodeByCategory:(NSString *)category;
- (NSArray *)getAllProductIdByCategory:(NSString *)category;



- (NSArray *)getAllProductNames;

- (NSArray *)getAllProductId;

@end
