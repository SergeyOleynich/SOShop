//
//  SOWebViewController.h
//  SOShop
//
//  Created by Sergey on 01.03.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SOWebViewController : UIViewController

@property (strong, nonatomic) NSString *mainTitle;

@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSData *data;

@end
