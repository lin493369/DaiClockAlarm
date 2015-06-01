//
//  ClockAlarmViewController.m
//  智能牙刷
//
//  Created by wisdom on 15-5-27.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "ClockAlarmViewController.h"
#include "NotificationModel.h"
@interface ClockAlarmViewController(){
}
@property NSMutableArray *arry;
@property(nonatomic,retain) UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addBtn;
@property (nonatomic,retain) ClockAlarm *clockAlarm;
@property (weak, nonatomic) IBOutlet UISwitch *isStartAlarm;
@end
@implementation ClockAlarmViewController
@synthesize clockView;
@synthesize rightButton;
-(void)viewDidLoad{
    rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlarm:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    clockView = [[UITableView alloc]initWithFrame:CGRectMake(0, 150, ViewWidth, ViewHeight-150)];
    clockView.backgroundColor = [UIColor colorWithRed:245.0/255.0f green:245.0/255.0f blue:245.0/255.0f alpha:1.0];
    clockView.delegate = self;
    clockView.dataSource = self;
    clockView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];//删除多余的cell
    _arry = [[NSMutableArray alloc]init];
    [self.view addSubview:clockView];
}

- (IBAction)didStartAlarm:(id)sender {

    if (_isStartAlarm.isOn) {
        self.navigationItem.rightBarButtonItem = rightButton;
        _arry = nil;
        NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *path = [documents stringByAppendingPathComponent:@"clock.archiver"];
        [NSKeyedArchiver archiveRootObject:_arry toFile:path];
        [clockView setHidden:NO];
        [clockView reloadData];
    }else
    {
        self.navigationItem.rightBarButtonItem = nil;

        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [clockView setHidden:YES];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_arry count]==0) {
        return 0;
    }
    return [_arry count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    for(UIView *view in cell.contentView.subviews){
        [view removeFromSuperview];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([_arry count]>0) {
        ClockAlarm *clock = [_arry objectAtIndex:indexPath.row];
        UILabel *time = [[UILabel alloc]initWithFrame:CGRectMake(14, 21, 46, 27)];
        time.text = @"下午";
        UILabel *tagName = [[UILabel alloc]initWithFrame:CGRectMake(14, 43, ViewWidth-80, 27)];
        UILabel *week = [[UILabel alloc]initWithFrame:CGRectMake(68, 43, ViewWidth, 27)];
//        week.text = clock.weekReapt;
        tagName.text = [NSString stringWithFormat:@"%@,%@",clock.tag,clock.weekReapt];

        UILabel *t = [[UILabel alloc]initWithFrame:CGRectMake(68, 0, 81, 45)];
        t.font = [UIFont fontWithName:@"Helvetica Neue" size:31.f];
        time.font = [UIFont fontWithName:@"Helvetica Neue" size:20.f];
        tagName.font = [UIFont fontWithName:@"Helvetica Neue" size:15.f];
        week.font = [UIFont fontWithName:@"Helvetica Neue" size:15.f];
        NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"HH:mm"];
        t.text = [dateformatter stringFromDate:clock.time];
        [dateformatter setDateFormat:@"aa"];
        time.text = [dateformatter stringFromDate:clock.time] ;
        
        UISwitch *s = [[UISwitch alloc]init];
        s.center = CGPointMake(ViewWidth-40, 40);
        [s addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];

        s.tag = indexPath.row;
        [s setOn:clock.isOn];
        [cell.contentView addSubview:s];
        [cell.contentView addSubview:t];
        [cell.contentView addSubview:tagName];
        [cell.contentView addSubview:time];
        [cell.contentView addSubview:week];
        cell.accessoryType = UITableViewCellAccessoryNone;
        
    }
    if ([_arry count]==0) {
//        cell.textLabel.textColor = [UIColor colorWithRed:113.0/255 green:112.0/255 blue:113.0/255 alpha:1];
//        cell.textLabel.text = @"暂无数据";
//        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}
-(void)switchAction:(id)sender
{
    UISwitch *sBtn = (UISwitch *)sender;
    ClockAlarm *c = [_arry objectAtIndex:sBtn.tag];
    [c setIsOn:sBtn.isOn];
    NotificationModel *notification = [NotificationModel new];
    if (sBtn.isOn) {
        NSLog(@"%@",c.weekArray);
        if ([c.weekArray count]==0) {//永不重复
            [notification setLocatNotfication:0 setDate:c];
        }
        if ([c.weekArray count]==7) {
            [notification setUnitDayNotfication:c];
        }
        else
            for (int i = 0 ; i<7; i++)
                if ([c.weekArray objectForKey:[NSString stringWithFormat:@"%d",i]]!=nil)
                    
                    [notification setLocatNotfication:i+1 setDate:c];
    }else {
        [notification cancleNotification:c callBackBlock:^(NSError *e){
            if (e)
                NSLog(@"%@",e);
            else NSLog(@"删除成功");
        }];
        
    
    }
    [_arry replaceObjectAtIndex:sBtn.tag withObject:c];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TRUE;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    ClockAlarm *c = [_arry objectAtIndex:indexPath.row];
    NotificationModel *notification = [NotificationModel new];

    [notification cancleNotification:c callBackBlock:^(NSError *e){
        if (e) {
            NSLog(@"%@",e);
        }
        else
            NSLog(@"删除成功");

    }];
    [_arry removeObjectAtIndex:indexPath.row];
    [self.clockView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    [clockView reloadData];
}
//进入页面 隐藏自定义tabbar
-(void)viewWillAppear:(BOOL)animated{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"clock.archiver"];
    NSMutableArray *a = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if ([a count]!=0) {
        _arry = a;
    }
    NSLog(@"%@",a);
    [clockView reloadData];
}
- (IBAction)addAlarm:(id)sender {
    AddAlarmViewController *aC = [self.storyboard instantiateViewControllerWithIdentifier:@"addAlarm"];
    UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:aC];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
}

//跳转页面 显示自定义tabbar

-(void)viewWillDisappear:(BOOL)animated{
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *path = [documents stringByAppendingPathComponent:@"clock.archiver"];
   [NSKeyedArchiver archiveRootObject:_arry toFile:path];
    
        
}

@end
