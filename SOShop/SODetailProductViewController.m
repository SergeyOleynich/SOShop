//
//  SODetailProductViewController.m
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SODetailProductViewController.h"

@interface SODetailProductViewController ()

@end

@implementation SODetailProductViewController

-(void)setMainTitle:(NSString *)mainTitle {
    
    _mainTitle = mainTitle;
    
    [self.navigationItem setTitle:NSLocalizedString(mainTitle, nil)];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    _mainTitle = nil;
    NSLog(@"DEALLOC DETAIL");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
