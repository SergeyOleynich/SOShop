//
//  SOStoreViewController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOCategoryViewController.h"
#import "SOStoreManager.h"
#import "SOSubCategoryProductTableViewController.h"
#import "Constans.h"
#import "SOCategory.h"
#import "SOSubCategory.h"

@interface SOCategoryViewController () <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) SOStoreManager *store;
@property (strong, nonatomic) NSArray *allCategory;
@property (strong, nonatomic) NSString *nextView;

@property (strong, nonatomic) NSFileManager *manager;

@end

@implementation SOCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    _manager = [NSFileManager defaultManager];
    
    _store = [SOStoreManager sharedManager];
    
    _allCategory = [self.store getCategories];
    /*
    NSArray *array = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *fullPath = [array firstObject];
    fullPath = [fullPath stringByAppendingPathComponent:@"/SerializedData"];
    
    NSData *myObjects = [NSData dataWithContentsOfFile:fullPath];
    
    NSMutableArray *ar = [NSKeyedUnarchiver unarchiveObjectWithData:myObjects];
    
    NSLog(@"%@", ar);
    for (SOCategory *currentCategory in ar) {
        NSLog(@"%@", currentCategory.categoryName);
        for (SOSubCategory *currentSubCategory in currentCategory.subCategories) {
            NSLog(@"%@", currentSubCategory.subCategoryName);
            for (SOProduct *currentProduct in currentSubCategory.products) {
                NSLog(@"%@", currentProduct);
            }
        }
    }
    */
    /*
    SOCategory *cat = [self.allCategory objectAtIndex:0];
    SOCategory *another = [cat copy];//cat;//[cat copy];
    int i = 0;
    for (SOSubCategory *temp in cat.subCategories) {
        NSLog(@"%i: %p name: %@", i, temp, temp.subCategoryName);
        i += 1;
    }
    SOSubCategory *tempic = [cat.subCategories objectAtIndex:0];
    tempic.subCategoryName = nil;
    [cat.subCategories replaceObjectAtIndex:0 withObject:tempic];
    
    int j = 0;
    for (SOSubCategory *tempicc in another.subCategories) {
        NSLog(@"%i: %p name: %@", j, tempicc, tempicc.subCategoryName);
        j += 1;
    }
    cat.subCategories = nil;
    NSLog(@"%@", cat.subCategories);
    NSLog(@"%@", another.subCategories);
    */
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    self.allCategory = [self.allCategory sortedArrayUsingDescriptors:@[sort]];
        
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationItem setTitle:NSLocalizedString(@"MainTabShop", nil)];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.allCategory count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    SOCategory *category = [self.allCategory objectAtIndex:indexPath.section];
    cell.textLabel.text = category.categoryName;
    
    cell.imageView.image = nil;
    
    //__weak UITableViewCell *weakCell = cell;
    NSString *key = @"/PicturesForCategory";
    key = [key stringByAppendingString:[[category.urlToImage URLByDeletingPathExtension] relativePath]];
    
    NSString *fullPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    fullPath = [fullPath stringByAppendingPathComponent:key];
    
    if ([self.manager fileExistsAtPath:[fullPath stringByAppendingPathComponent:[category.urlToImage lastPathComponent]]]) {
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:[fullPath stringByAppendingPathComponent:[category.urlToImage lastPathComponent]]]];
        [cell layoutSubviews];
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            BOOL isDirectory;
            NSError *error;
            [[NSFileManager defaultManager] fileExistsAtPath:fullPath isDirectory:&isDirectory];
            if (!isDirectory) {
                if (![[NSFileManager defaultManager] createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:&error]) {
                    NSLog(@"ERROR create the directory in Category view controller: %@", error.localizedDescription);
                }
            }
            NSData *tempData = [NSData dataWithContentsOfURL:category.urlToImage];
            if (![[NSFileManager defaultManager] createFileAtPath:[fullPath stringByAppendingPathComponent:[category.urlToImage lastPathComponent]] contents:tempData attributes:nil]) {
                NSLog(@"ERROR create file: %@ - %@", error.localizedDescription, [category.urlToImage lastPathComponent]);
            }
            //[tempData writeToFile:fullPath atomically:YES];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *visibleCells = [tableView visibleCells];
                
                [visibleCells enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    UITableViewCell *currentCell = obj;
                    if ([tableView indexPathForCell:currentCell].row == indexPath.row) {
                        cell.imageView.image = [UIImage imageWithData:tempData];
                        [cell layoutSubviews];
                        *stop = YES;
                    }
                }];
                /*
                weakCell.imageView.image = [UIImage imageWithData:tempData];
                [weakCell setNeedsLayout];
                 */
            });
        });
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    dispatch_group_notify(self.myDispatchGroup, dispatch_get_main_queue(), ^{
        NSLog(@"NOTIFY");
        NSArray *array = [tableView visibleCells];
        for (UITableViewCell *cell in array) {
            [cell setNeedsLayout];
        }
    });*/
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SOCategory *category = [self.allCategory objectAtIndex:indexPath.section];
    SOSubCategoryProductTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SOSubCategoryProductTableViewController"];
    vc.mainTitle = category.categoryName;
    vc.tableData = category.subCategories;
    [self.navigationController pushViewController:vc animated:YES];
    /*
    NSArray *kCategoryArray = @[kCategoryAllProductsCatalog, kCategoryFruitsVegetables, kCategoryMeatFishBird, kCategoryConfectionery, kCategoryMilkCheeseEggs, kCategoryGrocery, kCategoryDrinks, kCategoryTobaccoProducts];
    
    NSString *temp = [self.allCategory objectAtIndex:indexPath.row];
    
    BOOL tempBOOL = YES;
    
    for (int i = 0; i < [self.allCategory count]; i ++) {
        if ([temp isEqualToString:NSLocalizedString(kCategoryArray [i], nil)]) {
            self.nextView = kCategoryArray [i];
            tempBOOL = NO;
        }
    }
    
    if (tempBOOL == YES) {
        self.nextView = kCategoryArray [0];
    }
        
    SOSubCategoryProductTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SOSubCategoryProductTableViewController"];
    
    vc.mainTitle = self.nextView;
    
    [self.navigationController pushViewController:vc animated:YES];
    */
}

#pragma mark - DEALLOC

- (void) dealloc {
    
    NSLog(@"DEALLOC SOSTOREVIEWCONTROLLER");
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
