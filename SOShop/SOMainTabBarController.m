//
//  MainTabBarController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOMainTabBarController.h"

@interface SOMainTabBarController ()

@end

@implementation SOMainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self.tabBar.items objectAtIndex:0] setTitle:NSLocalizedString(@"MainTabShop", nil)];
    [[self.tabBar.items objectAtIndex:1] setTitle:NSLocalizedString(@"MainTabBasket", nil)];
    [[self.tabBar.items objectAtIndex:2] setTitle:NSLocalizedString(@"MainTabOptions", nil)];

}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

@end
