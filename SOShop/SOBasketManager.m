//
//  SOBasketManager.m
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOBasketManager.h"
#import "SOProduct.h"

@interface SOBasketManager ()

@property (strong, nonatomic) NSMutableArray *store;

@end

@implementation SOBasketManager

#pragma mark - Inizialization

+ (SOBasketManager *)sharedManager {
    
    static SOBasketManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[super alloc] initUniqueInstance];
    });
    
    return manager;
}

- (instancetype) initUniqueInstance {
    
    _store = [[NSMutableArray alloc] init];
    
    return [super init];
}

- (void)addProduct:(SOProduct *)product {
    
    [self.store addObject:product];
    
}

- (void)deleteProduct:(SOProduct *)product {
    
    for (SOProduct *currentProduct in self.store) {
        if ([currentProduct.productId longLongValue] == [product.productId longLongValue]) {
            [self.store removeObject:currentProduct];
        }
    }
    
}

- (NSMutableArray *)getHoleListOfProduct {
    
    return self.store;
    
}

@end





