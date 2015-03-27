//
//  SOSettingsTableViewController.m
//  SOShop
//
//  Created by Sergey on 01.03.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOSettingsTableViewController.h"
#import "SOWebViewController.h"

@interface SOSettingsTableViewController ()

@end

@implementation SOSettingsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"LinkSegue"]) {
        
        SOWebViewController *vc = segue.destinationViewController;
        vc.mainTitle = NSLocalizedString(@"Link", nil);
        vc.url = [NSURL URLWithString:@"http://www.teslamotors.com"];
        vc.hidesBottomBarWhenPushed = YES;
        
    } else {
        
        SOWebViewController *vc = segue.destinationViewController;
        vc.hidesBottomBarWhenPushed = YES;
        vc.mainTitle = NSLocalizedString(@"File", nil);
        
        NSURL *urlPath = nil;
        
        if ([segue.identifier isEqualToString:@"FileSegue"]) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Diplom" ofType:@"doc"];
            urlPath = [NSURL fileURLWithPath:path];
            //NSData *data = [NSData dataWithContentsOfFile:path];
            //vc.data = data;
        }
        
        if ([segue.identifier isEqualToString:@"ImageSegue"]) {
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"Plakat" ofType:@"jpg"];
            urlPath = [NSURL fileURLWithPath:path];
            
        }
        
        vc.url = urlPath;
        
    }
    
}


@end
