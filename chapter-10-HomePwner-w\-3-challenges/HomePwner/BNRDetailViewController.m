//
//  BNRDetailViewController.m
//  HomePwner
//
//  Created by 史江凯 on 15/4/22.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRDateViewController.h"

@interface BNRDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameFiled;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLable;


@end

@implementation BNRDetailViewController

//- (void)setItem:(BNRItem *)item
//{
//    _item = item;
//    self.navigationItem.title = _item.itemName;
//}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = self.item.itemName;
    BNRItem *item = self.item;
    self.nameFiled.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter){
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    self.dateLable.text = [dateFormatter stringFromDate:item.dateCreated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    BNRItem *item = self.item;
    item.itemName = self.nameFiled.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (IBAction)changeDate:(UIButton *)sender
{
    NSLog(@"Clicked Change Date Button");
    BNRDateViewController *dateViewController = [[BNRDateViewController alloc] init];
    [self.navigationController pushViewController:dateViewController animated:YES];
    
    dateViewController.item = _item;
}

@end
