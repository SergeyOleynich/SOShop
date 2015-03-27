//
//  SOProductTableViewCell.m
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOProductTableViewCell.h"

@implementation SOProductTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [self.productAddButton setTitle:NSLocalizedString(@"AddButton", nil) forState:UIControlStateNormal];
    self.productAddButton.titleLabel.numberOfLines = 3;
    self.productAddButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.productAddButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.productInBasketLabel.layer.cornerRadius = 4.f;
    self.productInBasketLabel.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.productInBasketLabel.layer.borderWidth = 1.f;
    self.productInBasketLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2f];

    [self.amountBuyButton setTitle:NSLocalizedString(@"AmountBuyButton", nil) forState:UIControlStateNormal];
    self.amountBuyButton.titleLabel.numberOfLines = 3;
    self.amountBuyButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.amountBuyButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
