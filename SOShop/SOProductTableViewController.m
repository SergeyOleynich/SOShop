//
//  SOProductViewController.m
//  SOShop
//
//  Created by Sergey on 20.02.15.
//  Copyright (c) 2015 Sergey. All rights reserved.
//

#import "SOProductTableViewController.h"
#import "SOStoreManager.h"
#import "SOProduct.h"
#import "SOProductTableViewCell.h"
#import "SODetailProductViewController.h"
#import "SOBasketManager.h"

#import "UIView+UITableView.h"

@interface SOProductTableViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) NSArray *numbersArray;
@property (strong, nonatomic) NSMutableArray *amountProduct;

- (IBAction)actionAddProduct:(UIButton *)sender;
- (IBAction)actionChooseAmountForProduct:(UIButton *)sender;

@end

@implementation SOProductTableViewController

-(void)setMainTitle:(NSString *)mainTitle {
    _mainTitle = mainTitle;
    [self.navigationItem setTitle:mainTitle];
}

-(void)setTableData:(NSMutableArray *)tableData {
    _tableData = tableData;
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [_tableData sortUsingDescriptors:@[sort]];
    //_tableData = [tableData sortedArrayUsingDescriptors:@[sort]];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.numbersArray = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9];
    self.amountProduct = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [self.amountProduct addObject:@0];
    }
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BackToShop", nil) style:UIBarButtonItemStyleDone target:self action:@selector(backToShop:)];
    
    [self.navigationItem setRightBarButtonItem:leftBarItem];
    
    // Do any additional setup after loading the view.
}

-(void)dealloc {
    NSLog(@"DEALLOC SOPRODUCTVIEWCONTROLLER");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (SOProduct *currentProduct in self.tableData) {
        NSString *res = currentProduct.name;
        res = [res substringToIndex:1];
        [result addObject:res];
    }
    
    return result;
}
/*
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableData count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"SOProductCell";
    
    SOProductTableViewCell *cell = (SOProductTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[SOProductTableViewCell alloc] init];
    }
    
    SOProduct *currentProduct = [self.tableData objectAtIndex:indexPath.row];
    
    cell.amountBuyDynamicLabel.text = @"0.0";
    cell.productNameLabel.text = currentProduct.name;
    cell.productCostLabel.text = [NSString stringWithFormat:@"%.2f", currentProduct.cost.doubleValue];
    cell.saleProductCost.text = [NSString stringWithFormat:@"%.2f", currentProduct.cost.doubleValue * 0.9f];
    cell.productDimensionLabel.text = [NSString stringWithFormat:@"1 %@", currentProduct.dimension];
    cell.saleProductLabel.text = [NSString stringWithFormat:@"%@ 1 %@", NSLocalizedString(@"SaleProductLabel", nil), currentProduct.dimension];
    [cell.productInBasketLabel setHidden:YES];
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
    
}

#pragma mark - UITableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return UITableViewCellEditingStyleDelete;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NSLocalizedString(@"DeleteButton", nil);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SOProductTableViewCell *cell = (SOProductTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    NSString *nextVC = cell.productNameLabel.text;
    
    SODetailProductViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SODetailProductViewController"];
    
    vc.mainTitle = nextVC;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - Actions

- (IBAction)actionAddProduct:(UIButton *)sender {
    
    SOProductTableViewCell *cell = (SOProductTableViewCell *)[sender superCell];
    
    NSIndexPath *path = [self.tableView indexPathForCell:cell];
    
    SOProduct *currentProduct = [self.tableData objectAtIndex:path.row];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [cell.productInBasketLabel setHidden:NO];
    });

    SOBasketManager *basket = [SOBasketManager sharedManager];
    
    [basket addProduct:currentProduct];
    
}

- (IBAction)actionChooseAmountForProduct:(UIButton *)sender {
    
    SOProductTableViewCell *cell = (SOProductTableViewCell *)[sender superCell];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    picker.delegate = self;
    picker.dataSource = self;
    
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([[UIScreen mainScreen] bounds]), 44)];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(hidePickerKeyboardWithSave:)];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(hidePickerKeyboard:)];
    UIBarButtonItem *flex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    toolBar.items = [[NSArray alloc] initWithObjects:leftButton, flex, rightButton, nil];
    
    [cell.emptyTextField setTag:1];
    [cell.emptyTextField setInputAccessoryView:toolBar];
    [cell.emptyTextField setInputView:picker];
    
    [cell.emptyTextField becomeFirstResponder];
    
}

- (void)hidePickerKeyboardWithSave:(UIBarButtonItem *)sender {
    NSArray *cells = [self.tableView visibleCells];
    for (SOProductTableViewCell *cell in cells) {
        if (cell.emptyTextField.tag == 1) {
            NSString *temp = @"";
            for (NSNumber *number in self.amountProduct) {
                temp = [temp stringByAppendingString:[number stringValue]];
            }
            [cell.amountBuyDynamicLabel setText:temp];
            [cell.emptyTextField resignFirstResponder];
            [cell.emptyTextField setTag:0];
            [cell.emptyTextField setInputAccessoryView:nil];
            [cell.emptyTextField setInputView:nil];
        }
    }
    for (int i = 0; i < [self.amountProduct count]; i++) {
        [self.amountProduct replaceObjectAtIndex:i withObject:@0];
    }
    
}

- (void)hidePickerKeyboard:(UIBarButtonItem *)sender {
    NSArray *cells = [self.tableView visibleCells];
    for (SOProductTableViewCell *cell in cells) {
        [cell.emptyTextField resignFirstResponder];
        [cell.emptyTextField setTag:0];
    }
    for (int i = 0; i < [self.amountProduct count]; i++) {
        [self.amountProduct replaceObjectAtIndex:i withObject:@0];
    }
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 8;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 3 || component == 7) {
        return 1;
    }
    return 10;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 3) {
        return @".";
    }
    if (component == 7) {
        return @"kg";
    }
    return [[self.numbersArray objectAtIndex:row] stringValue];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    [self.amountProduct replaceObjectAtIndex:component withObject:[self.numbersArray objectAtIndex:row]];
    
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    textField.tag = 0;
    textField.inputView = nil;
    textField.inputAccessoryView = nil;
}

#pragma mark - Helper methods

- (void)backToShop:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

@end






