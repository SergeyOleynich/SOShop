//
//  SOCategoryProductTableViewController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOSubCategoryProductTableViewController.h"
#import "SOStoreManager.h"
#import "SOProductTableViewController.h"
#import "SOSubCategory.h"
@interface SOSubCategoryProductTableViewController ()

//@property (strong, nonatomic) NSArray *tableData;
@property (strong, nonatomic) SOStoreManager *store;

@end

@implementation SOSubCategoryProductTableViewController

#pragma mark - DEALLOC

-(void)dealloc {
    NSLog(@"SOSubCategoryProductTableViewController deallocated");
}

#pragma mark - Setters

-(void)setMainTitle:(NSString *)mainTitle {
    
    _mainTitle = mainTitle;
    
    [self.navigationItem setTitle:mainTitle];

    /*
    [self.navigationItem setTitle:NSLocalizedString(mainTitle, nil)];
    
    _tableData = [self.store getAllSubCategoryNamesByCategoryName:self.mainTitle];
    
    [self.tableView reloadData];
     */
}

-(void)setTableData:(NSArray *)tableData {
    //_tableData = tableData;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"subCategoryName" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    _tableData = [tableData sortedArrayUsingDescriptors:@[sort]];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _store = [SOStoreManager sharedManager];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    /*
    if (!self.tableData) {
#warning необходимо инициализировать стандартным путем
        _tableData = [self.store getAllSubCategoryNamesByCategoryName:self.mainTitle];
    }*/
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
    
    static NSString *identifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [(SOSubCategory *)[self.tableData objectAtIndex:indexPath.row] subCategoryName];
    
    //cell.textLabel.text = NSLocalizedString([self.tableData objectAtIndex:indexPath.row], nil);
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SOSubCategory *subcategory = [self.tableData objectAtIndex:indexPath.row];
    
    SOProductTableViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SOProductViewController"];
    
    vc.mainTitle = subcategory.subCategoryName;
    vc.tableData = subcategory.products;
    
    [self.navigationController pushViewController:vc animated:YES];
    /*
    SOProductViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SOProductViewController"];
    
    NSLog(@"%@", self.tableData);
    
    vc.categoryAndSubcategoryName = [NSDictionary dictionaryWithObjectsAndKeys:[self.tableData objectAtIndex:indexPath.row], @"subCategory", self.mainTitle, @"category", nil];
    
    [self.navigationController pushViewController:vc animated:YES];
    */
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
