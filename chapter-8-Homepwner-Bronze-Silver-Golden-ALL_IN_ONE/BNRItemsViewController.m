//
//  BNRItemsViewController.m
//  chapter-8-Homepwner
//
//  Created by 史江凯 on 15/4/21.
//  Copyright (c) 2015年 Big Nerd Ranch. All rights reserved.
//
#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemsViewController ()

@end

@implementation BNRItemsViewController


// initializer for table view controller
-(instancetype)init
{
    // Call superclass's designated initilizer
    self = [super initWithStyle:UITableViewStylePlain];
    
    // creates an array of 5 random items
    if (self) {
        for (int i = 0; i < 5; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
        
    }
    return self;
}

// set the style of the table view
-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}


// method to load the view and sets the origin of table in window
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"logo"]];//设置背景图片
    
    self.tableView.contentInset = UIEdgeInsetsMake(20.0f, 0.0f, 0.0f, 0.0f);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}


// returns the number of rows in each section
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    NSMutableArray *itemsOver50 = [self itemsOver50:items];
    NSMutableArray *itemsUnder50 = [self itemsUnder50:items];
    
    if (section == 0){
        return  [itemsUnder50 count];
    }
    else {
        return [itemsOver50  count];
    }
}


// gets a mutable array of items that have a value over 50
// also adds another item to be used for  no more items
-(NSMutableArray *)itemsOver50: (NSArray *)allItems
{
    NSMutableArray *over50Items = [[NSMutableArray alloc] init];
    
    // searches store items for items over $50
    for (BNRItem *item in allItems) {
        if (item.valueInDollars >= 50){
            [over50Items addObject:item];
        }
    }
    
    // adds dummy item to mutable array
    BNRItem *lastItem = [[BNRItem alloc] init];
    [over50Items addObject: lastItem];
    
    return over50Items;
}


// gets a mutable array of items that have a value under 50
// also adds another item to be used for  no more items
-(NSMutableArray *)itemsUnder50: (NSArray *)allItems
{
    NSMutableArray *itemsUnder50 = [[NSMutableArray alloc] init];
    
    // searches store items for items over $50
    for (BNRItem *item in allItems) {
        if (item.valueInDollars < 50){
            [itemsUnder50 addObject:item];
        }
    }
    
    // adds dummy item to mutable array
    BNRItem *lastItem = [[BNRItem alloc] init];
    [itemsUnder50 addObject: lastItem];
    
    return itemsUnder50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // Get a new or recycled cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    
    
    NSMutableArray *itemsOver50 = [self itemsOver50:items];
    NSMutableArray *itemsUnder50 = [self itemsUnder50:items];
    
    
    if (indexPath.section == 0) {
        if (indexPath.row == ([itemsUnder50 count] - 1)) {
            cell.textLabel.font = [UIFont systemFontOfSize: 15];
            cell.textLabel.text = @"No More items!";
        } else {
            cell.textLabel.font = [UIFont systemFontOfSize: 18];
            cell.textLabel.text = [itemsUnder50[indexPath.row] description];
        }
    } else if (indexPath.section == 1){
        if (indexPath.row == ([itemsOver50 count] - 1 )) {
            cell.textLabel.font = [UIFont systemFontOfSize: 15];
            cell.textLabel.text = @"No More items!";
        } else {
            cell.textLabel.font = [UIFont systemFontOfSize: 18];
            cell.textLabel.text = [itemsOver50[indexPath.row] description];
        }
    }
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

// sets the height of rows  设置每个row的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat rowHeight;
    
    NSArray *items = [[BNRItemStore sharedStore]allItems];
    
    
    NSMutableArray *itemsOver50 = [self itemsOver50:items];
    NSMutableArray *itemsUnder50 = [self itemsUnder50:items];
    
    if (indexPath.section == 0) {
        if (indexPath.row == ([itemsUnder50 count] - 1)) {
            rowHeight = 44;
        } else {
            rowHeight = 60;
        }
    } else if (indexPath.section == 1){
        if (indexPath.row == ([itemsOver50 count] - 1 )) {
            rowHeight = 44;
        } else {
            rowHeight = 60;
        }
    }
    
    return  rowHeight;
}


// sets the title for the section headers  设置每个section的header的title
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        return @"Items Under $50";
    }  else {
        return @"Items $50 and Over";
    }
}


// sets the number of sections in table view 直接返回sections的数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

@end


