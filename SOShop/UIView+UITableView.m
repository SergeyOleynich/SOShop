//
//  UIView+UITableView.m
//  SOShop
//
//  Created by Sergey on 22.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "UIView+UITableView.h"

@implementation UIView (UITableView)

- (UITableViewCell *)superCell {
    
    if (!self.superview) {
        return nil;
    }
    
    if ([self.superview isKindOfClass:[UITableViewCell class]]) {
        return (UITableViewCell *)self.superview;
    }
    
    return [self.superview superCell];
    
}

@end
