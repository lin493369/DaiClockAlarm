//
//  weekDayViewController.m
//  智能牙刷
//
//  Created by wisdom on 15-5-28.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "weekDayViewController.h"
#import "AddAlarmViewController.h"
@interface weekDayViewController(){
    
    NSIndexPath *selectedIndexPath;
    NSMutableDictionary *weekSel;
    
}

@property (nonatomic, retain) NSIndexPath *selectedIndexPath;
@property (nonatomic,retain)  NSMutableDictionary *weekSel;

@end
@implementation weekDayViewController
@synthesize weekSel;
@synthesize selectedIndexPath;

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    weekSel = [[NSMutableDictionary alloc]init];
}
- (IBAction)popPreVc:(id)sender {
    AddAlarmViewController *ac = [self.navigationController.viewControllers objectAtIndex:0];
    ac.week = weekSel;
    [self.navigationController popToViewController:ac animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
    
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        NSString *row = [NSString stringWithFormat: @"%ld", (long)indexPath.row];
        [weekSel setValue:row forKey:row];

    }
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *row = [NSString stringWithFormat: @"%ld", (long)indexPath.row];

    [weekSel removeObjectForKey:row];
    cell.accessoryType = UITableViewCellAccessoryNone;

}
@end
