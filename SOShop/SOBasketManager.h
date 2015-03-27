//
//  SOBasketManager.h
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SOProduct;

@interface SOBasketManager : NSObject

+ (instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
+ (instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));
- (instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));

+ (SOBasketManager *)sharedManager;

- (void)addProduct:(SOProduct *)product;

- (void)deleteProduct:(SOProduct *)product;

- (NSMutableArray *)getHoleListOfProduct;

@end
