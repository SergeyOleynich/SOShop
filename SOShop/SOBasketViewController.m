//
//  SOBasketViewController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOBasketViewController.h"
#import "SOProduct.h"
#import "SOBasketManager.h"
#import "SOBasketProductTableViewCell.h"

@interface SOBasketViewController ()

@property (strong, nonatomic) NSMutableArray *tableData;

@property (strong, nonatomic) UIView *tempView;

- (IBAction)actionCahngeAmountOfProduct:(UIButton *)sender;
- (IBAction)actionDeleteProduct:(UIButton *)sender;

@end

@implementation SOBasketViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:NSLocalizedString(@"MainTabBasket", nil)];

    _tableData = [[SOBasketManager sharedManager] getHoleListOfProduct];
    [self.tableView reloadData];
    if ([self.tableData count] == 0) {
        self.tempView = [[UIView alloc] initWithFrame:self.tableView.bounds];
        [self.tempView setBackgroundColor:[UIColor whiteColor]];
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:self.tempView.bounds];
        tempLabel.numberOfLines = 0;
        tempLabel.text = @"В корзине пусто";
        [tempLabel setTextAlignment:NSTextAlignmentCenter];
        [self.tempView addSubview:tempLabel];
        [self.view addSubview:self.tempView];
    }
    
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.tempView removeFromSuperview];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *const identifier = @"SOBasketProductTableViewCell";
    
    SOBasketProductTableViewCell *cell = (SOBasketProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SOBasketProductTableViewCell alloc] init];
    }
    
    SOProduct *currentProduct = [self.tableData objectAtIndex:indexPath.row];
    
    cell.productName.text = currentProduct.name;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [formatter setCurrencyCode:@"USD"];
    cell.currentPriceLabel.text = [NSNumberFormatter localizedStringFromNumber:currentProduct.cost numberStyle:NSNumberFormatterCurrencyStyle];//[formatter stringFromNumber:currentProduct.cost];
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionCahngeAmountOfProduct:(UIButton *)sender {
}

- (IBAction)actionDeleteProduct:(UIButton *)sender {
}
@end
