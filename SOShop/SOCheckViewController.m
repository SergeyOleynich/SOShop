//
//  SOCheckViewController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOCheckViewController.h"

@interface SOCheckViewController ()

@property (weak, nonatomic) IBOutlet UITextView *checkTextView;

@end

@implementation SOCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.checkTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
