//
//  SOBasketProductTableViewCell.h
//  SOShop
//
//  Created by Sergey on 22.03.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOBasketProductTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@end
