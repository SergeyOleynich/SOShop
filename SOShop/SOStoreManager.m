//
//  SOStore.m
//  SOShop
//
//  Created by Sergey on 21.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOStoreManager.h"
#import "SOProduct.h"
#import "Constans.h"
#import "SOCategory.h"
#import "SOSubCategory.h"

#import "XMLDictionary.h"

@interface SOStoreManager ()

@property (strong, nonatomic) NSNumber *currentProductId;

@property (strong, nonatomic) NSMutableArray *store;

@end

@implementation SOStoreManager

#pragma mark - Inizialization

+ (SOStoreManager *)sharedManager {
    
    static SOStoreManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super alloc] initUniqueInstance];
    });
    
    return manager;
}

- (instancetype) initUniqueInstance {
    
    _store = [[NSMutableArray alloc] init];
    _currentProductId = [NSNumber numberWithLongLong:0];
    
    
    //[self initializeCategory];
    
    return [super init];
}

- (void)initializeCategory {
    /*
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryAllProductsCatalog] forKey:kCategoryAllProductsCatalog];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryFruitsVegetables] forKey:kCategoryFruitsVegetables];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryMeatFishBird] forKey:kCategoryMeatFishBird];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryConfectionery] forKey:kCategoryConfectionery];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryMilkCheeseEggs] forKey:kCategoryMilkCheeseEggs];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryGrocery] forKey:kCategoryGrocery];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryDrinks] forKey:kCategoryDrinks];
    [self.store setObject:[[SOCategory alloc] initWithCategoryName:kCategoryTobaccoProducts] forKey:kCategoryTobaccoProducts];
    */
}

#pragma mark - Setters
#pragma mark - JSON

- (void)parseProductsFromJSON:(id)json {
    
    NSDictionary *dictionary;
    
    if ([json isKindOfClass:[NSDictionary class]]) {
        
        dictionary = json;
        
    } else if ([json isKindOfClass:[NSString class]]) {
        
        NSString *temp = [json lastPathComponent];
        NSData *data = [NSData dataWithContentsOfFile:[self searchForFile:temp inDirectory:@"SergeyDoc/JSON"]];
        dictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
    } else {
        NSLog(@"Unrecognizer parametr send for parse");
        return ;
    }
#ifdef PARSEDownloading
    NSArray *categoryNames = [dictionary objectForKey:@"results"];
    for (int i = 0; i < [categoryNames count]; i++) {
        SOCategory *category = [[SOCategory alloc] initWithDictionary:[categoryNames objectAtIndex:i]];
        [self.store addObject:category];
    }
#else
    NSArray *categoryNames = [dictionary objectForKey:@"category"];
    for (int i = 0; i < [categoryNames count]; i++) {
        SOCategory *category = [[SOCategory alloc] initWithDictionary:[categoryNames objectAtIndex:i]];
        [self.store addObject:category];
    }
#endif
    //[self writeMySerializedObjectsToFilePath:@"/SerializedData"];
    //[self printAll];
}

#pragma mark - XML

- (void)parseProductsFromXML:(id)xml {
    NSDictionary *dictionary;
    
    if ([xml isKindOfClass:[NSDictionary class]]) {
        
        dictionary = xml;
        
    } else if ([xml isKindOfClass:[NSString class]]) {
        
        NSString *temp = [xml lastPathComponent];
        NSData *data = [NSData dataWithContentsOfFile:[self searchForFile:temp inDirectory:@"SergeyDoc/XML"]];
        dictionary = [NSDictionary dictionaryWithXMLData:data];
        NSLog(@"%@", NSStringFromClass([[dictionary objectForKey:@"category"] class]));
    } else {
        NSLog(@"Unrecognizer parametr send for parse");
        return ;
    }
    
    NSArray *categoryNames = [dictionary objectForKey:@"category"];
    for (int i = 0; i < [categoryNames count]; i++) {
        SOCategory *category = [[SOCategory alloc] initWithDictionary:[categoryNames objectAtIndex:i]];
        [self.store addObject:category];
    }
}

#pragma mark - manually

- (void)addProduct:(SOProduct *)product forProductSubCategory:(NSString *)key
                                                  withFailure:(void(^)(NSDictionary *error))failure {
    /*
    for (SOCategory *currentCategory in [self.store allValues]) {
        for (SOSubCategory *currentSubCategory in [currentCategory.subCategoty allValues]) {
            if ([currentSubCategory.subCategoryName isEqualToString:key]) {
                for (SOProduct *currentProduct in currentSubCategory.product) {
                    if ([currentProduct.productName isEqualToString:product.productName]) {
                        NSString *error = [NSString stringWithFormat:@"Such product as \"%@\" is already in use. Please try to rename product and save one more time", product.productName];
                        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:error, kErrorDescription, @"Error: can't save product", kError, nil];
                        failure (dict);
                        return ;
                    }
                }
                self.currentProductId = @([self.currentProductId integerValue] + 1);
                product.productId = self.currentProductId;
                [currentSubCategory.product addObject:product];
            }
        }
    }
    */
}

- (void)addProductsFromArray:(NSArray *) productsArray forProductCategory:(NSString *) key {
#warning empty method
}

#pragma mark - Getters

- (NSArray *)getCategories {
    
    return self.store;
    
}
/*
- (NSArray *)getAllSubCategoryNamesByCategoryName:(NSString *)categoryName {
    
    SOCategory *currentCategory = [self.store objectForKey:categoryName];
    
    NSDictionary *result = [currentCategory subCategoty];
    
    return [result allKeys];
    
}

- (NSSet *)getAllProductsBySubCategoryName:(NSString *)subCategoryName andCategoryName:(NSString *)categoryName {
    
    SOCategory *currentCategory = [self.store objectForKey:categoryName];
    
    NSDictionary *result1 = [currentCategory subCategoty];
    
    SOSubCategory *result = [result1 objectForKey:subCategoryName];
    
    return result.product;
}

- (NSNumber *)getAllProductsCost {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *tempArray = [self.store allValues];
    
    for (SOProduct *currentProduct in [tempArray firstObject]) {
        [result addObject:currentProduct.productCost];
    }
    
    NSNumber *holeCost = [NSNumber numberWithDouble:0.f];
    
    for (int i = 0; i < [result count]; i++) {
        
        holeCost = @([holeCost doubleValue] + [[result objectAtIndex:i] doubleValue]);
        
    }
    
    return holeCost;
}

- (NSArray *)getAllProductsBarCode {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in [self.store allValues]) {
        [result addObject:currentProduct.productBarCode];
    }
    
    return result;
}

- (NSArray *)getAllProductsId {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in [self.store allValues]) {
        [result addObject:currentProduct.productId];
    }
    
    return result;
}

- (NSArray *)getAllProductsName {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in [self.store allValues]) {
        [result addObject:currentProduct.productName];
    }
    
    return result;
}

- (NSArray *)getAllProductCostByCategory:(NSString *)category {
    
    NSArray *categoryArray = [self.store objectForKey:category];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in categoryArray) {
        [result addObject:currentProduct.productCost];
    }
    
    return result;
    
}

- (NSArray *)getAllProductBarCodeByCategory:(NSString *)category {
    
    NSArray *categoryArray = [self.store objectForKey:category];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in categoryArray) {
        [result addObject:currentProduct.productBarCode];
    }
    
    return result;
    
}

- (NSArray *)getAllProductIdByCategory:(NSString *)category {
    
    NSArray *categoryArray = [self.store objectForKey:category];
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in categoryArray) {
        [result addObject:currentProduct.productId];
    }
    
    return result;
    
}

- (NSArray *)getAllProductNames {
    return nil;
}

- (NSArray *)getAllProductId {
    return nil;
}
*/

#pragma mark - Helper methods

- (NSString *)searchForFile:(NSString *)fileName inDirectory:(NSString *)directory {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *myDirectory = directory;
    
    myDirectory = [documentDirectory stringByAppendingPathComponent:myDirectory];
    NSLog(@"Documents Directory: %@", [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);
    NSError *error = nil;
    
    BOOL isDir;
    [fileManager fileExistsAtPath:myDirectory isDirectory:&isDir];
    
    if (!isDir) {
        if (![fileManager createDirectoryAtPath:myDirectory withIntermediateDirectories:YES attributes:nil error:&error]) {
            NSLog(@"ERROR create the directory: %@", error.localizedDescription);
        }
    }
    
    myDirectory = [myDirectory stringByAppendingString:@"/"];
    myDirectory = [myDirectory stringByAppendingString:fileName];
    
    BOOL fileExists = [fileManager fileExistsAtPath:myDirectory];
    
    if (!fileExists) {
        
        NSString *fullPath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        NSData *responseData = [NSData dataWithContentsOfFile:fullPath];
        if (![fileManager createFileAtPath:myDirectory contents:responseData attributes:nil]) {
            NSLog(@"ERROR create file: %@", error.localizedDescription);
        }
    }
    
    return myDirectory;
    
}

- (void)printAll {
    NSLog(@"%@", self.store);
    for (SOCategory *category in self.store) {
        NSLog(@"%@", category.categoryName);
        NSLog(@"%@", category.subCategories);
        for (SOSubCategory *subcategory in category.subCategories) {
            NSLog(@"%@", subcategory.subCategoryName);
            for (SOProduct *product in subcategory.products) {
                NSLog(@"%@", product.description);
            }
        }
    }
}

- (void)writeMySerializedObjectsToFilePath:(NSString *)filePath {
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *temp = [array firstObject];
    filePath = [temp stringByAppendingPathComponent:filePath];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.store];
    [data writeToFile:filePath atomically:YES];
}

@end






