//
//  AppDelegate.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "AppDelegate.h"
#import "SOStoreManager.h"
#import "SOProduct.h"
#import "Constans.h"
#import "SOCategory.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
        
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"productId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    dispatch_queue_t myQueue = dispatch_queue_create("Load data", NULL);
    
    dispatch_async(myQueue, ^{
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"];
        
        NSData *responseData = [NSData dataWithContentsOfFile:path];
        
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:responseData
                              options:kNilOptions
                              error:nil];
        
        //SOParser *parser = [[SOParser alloc] init];
        //[parser parseAllObjectToDataBase:json];
        //NSLog(@"%@", parser.category);
    });

    
    
    /*
    NSURL *bundleURL = [NSURL URLWithString:myDirectory];
    NSArray *contents = [fileManager contentsOfDirectoryAtURL:bundleURL
                                   includingPropertiesForKeys:@[]
                                                      options:NSDirectoryEnumerationSkipsHiddenFiles
                                                        error:nil];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pathExtension == 'png'"];
    for (NSURL *fileURL in [contents filteredArrayUsingPredicate:predicate]) {
        NSLog(@"%@", fileURL.absoluteString);
    }
    */
    
    SOStoreManager *store = [SOStoreManager sharedManager];
    
#ifdef JSON
    [store parseProductsFromJSON:[[NSBundle mainBundle] pathForResource:@"document" ofType:@"json"]];
#elif XML
    [store parseProductsFromXML:[[NSBundle mainBundle] pathForResource:@"xmlFormatter" ofType:@"xml"]];
#elif MANUAL
    SOProduct *apple = [[SOProduct alloc] initWithName:kApple cost:@25.55 barCode:@1 dimension:kKG];
    SOProduct *cherry = [[SOProduct alloc] initWithName:kCherry cost:@20.0 barCode:@2 dimension:kKG];
    SOProduct *banana = [[SOProduct alloc] initWithName:kBanana cost:@30.0f barCode:@3 dimension:kKG];
    
    [store addProduct:apple forProductSubCategory:kSubCategoryFruit withFailure:^(NSDictionary *error) {
        NSLog(@"%@", error);
    }];
    
    /*
     [store addProduct:apple forProductSubCategory:kSubCategoryFruit withFailure:^(NSDictionary *error) {
     NSLog(@"%@", error);
     }];
     */
    
    [store addProduct:cherry forProductSubCategory:kSubCategoryFruit withFailure:^(NSDictionary *error) {
        NSLog(@"%@", error);
    }];
    
    [store addProduct:banana forProductSubCategory:kSubCategoryFruit withFailure:^(NSDictionary *error) {
        NSLog(@"%@", error);
    }];
#endif

    //NSLog(@"%@", [store getAllSubCategoryNamesByCategoryName:kCategoryFruitsVegetables]);
    //NSLog(@"%@", [store getAllCategory]);
    //NSLog(@"%@", [store getAllProductNamesByCategory:kCategoryFruitsVegetables]);
    //NSLog(@"%@", [store getAllProductIdByCategory:kCategoryFruitsVegetables]);
    //NSLog(@"%@", [store getAllProductsCost]);
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@1, @2, nil];
    NSLog(@"1 - %p", array);
    NSLog(@"%@", array);
    /*
    [self changeArray:array];
    NSLog(@"3 - %p", array);
    NSLog(@"%@", array);
    */
    void(^block)(int);
    int fff = 2;
    block = ^(int vb){
        NSLog(@"2 - %p", array);
        //array = [NSMutableArray arrayWithObjects:@4, @2, nil];
        NSLog(@"2.1 - %p", array);
        [array removeLastObject];
        [array addObject:@3];
        NSLog(@"BLOCK");
        vb = 4;
    };
    
    NSLog(@"BEFORE BLOCK");
    block (fff);
    NSLog(@"AFTER BLOCK");
    NSLog(@"3 - %p", array);
    NSLog(@"%@", array);
    return YES;
}

- (void)changeArray:(NSMutableArray *)array {
    NSLog(@"2 - %p", array);
    //array = [NSMutableArray arrayWithObjects:@4, @2, nil];
    NSLog(@"2.1 - %p", array);
    [array removeLastObject];
    [array addObject:@3];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
