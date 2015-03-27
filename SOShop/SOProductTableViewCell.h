//
//  SOProductTableViewCell.h
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *productCostLabel;
@property (weak, nonatomic) IBOutlet UILabel *productDimensionLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleProductLabel;
@property (weak, nonatomic) IBOutlet UILabel *saleProductCost;
@property (weak, nonatomic) IBOutlet UIButton *productAddButton;
@property (weak, nonatomic) IBOutlet UILabel *productInBasketLabel;
@property (weak, nonatomic) IBOutlet UIButton *amountBuyButton;
@property (weak, nonatomic) IBOutlet UILabel *amountBuyStaticLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountBuyDynamicLabel;
@property (weak, nonatomic) IBOutlet UITextField *emptyTextField;

@end
