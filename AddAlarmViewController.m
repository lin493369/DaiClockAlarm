//
//  AddAlarmViewController.m
//  智能牙刷
//
//  Created by wisdom on 15-5-28.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "AddAlarmViewController.h"
#import "ClockAlarm.h"
#import "NotificationModel.h"
#import "ConfigValueViewController.h"
@interface AddAlarmViewController(){
}
@property (nonatomic,retain)UIView * modifyNameView;
@property (nonatomic,retain)UITextField *label;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITableViewCell *tagCell;
@property (weak, nonatomic) IBOutlet UILabel *reCount;
@end
@implementation AddAlarmViewController
@synthesize datePicker;
@synthesize week;
@synthesize label;
-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:245/255.0f green:245/255.0f blue:245/255.0f alpha:1.0]];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    datePicker = [[UIDatePicker alloc]init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    NSLocale *locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    datePicker.locale = locale;
    datePicker.center = CGPointMake(_ClockView.frame.size.width/2,_ClockView.frame.size.height/2);
    [_ClockView addSubview:datePicker];
    [datePicker addTarget:self action:@selector(dateSelect:) forControlEvents:UIControlEventValueChanged];
    week = [[NSMutableDictionary alloc]init];
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeTag:)];
    [_tagCell addGestureRecognizer:gesture];
    
}
//选择标签
-(void)changeTag:(id)sender{
    ConfigValueViewController *cV = [self.storyboard  instantiateViewControllerWithIdentifier:@"cv"];
    cV.lastStr = _tagLabel.text;
        UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:cV];
    [self.navigationController presentViewController:navi animated:YES completion:nil];
    [cV returnStr:^(NSString *str){
        _tagLabel.text = str;
    }];

}


-(void)dateSelect:(id)sender{
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    [dateformatter setDateFormat:@"HH:mm tt"];
    NSString *clockTime = [dateformatter stringFromDate:[datePicker date]];
    
    NSLog(@"clocktime is %@",clockTime);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                
                break;
                
            default:
                break;
        }
    }

}

- (IBAction)cancleAdd:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)addAlarm:(id)sender {
    
    ClockAlarm  *clockAlarm = [[ClockAlarm alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NotificationModel *nM = [NotificationModel new];
    clockAlarm.time = [datePicker date];
    clockAlarm.weekReapt = _reCount.text;
    clockAlarm.tag = _tagLabel.text;
    clockAlarm.weekArray = [[NSDictionary alloc]initWithDictionary:week];
    if ([week count]==0) {//永不重复
        [nM setLocatNotfication:0 setDate:clockAlarm];
    }
    if ([week count]==7) {
        [nM setUnitDayNotfication:clockAlarm];
    }
    else
        for (int i = 0 ; i<7; i++)
            if ([week objectForKey:[NSString stringWithFormat:@"%d",i]]!=nil)
                
                [nM setLocatNotfication:i+1 setDate:clockAlarm];
    
//    [self.delegate getAlarmData:@"fd"];
    NSString *documents = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    NSString *path = [documents stringByAppendingPathComponent:@"clock.archiver"];
    if ([NSKeyedUnarchiver unarchiveObjectWithFile:path]==nil) {
        [NSKeyedArchiver archiveRootObject:array toFile:path];
    }else {
        array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    [array addObject:clockAlarm];
    [NSKeyedArchiver archiveRootObject:array toFile:path];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
//进入页面 隐藏自定义tabbar
-(void)viewWillAppear:(BOOL)animated{
    if([week count]==7){
        _reCount.text = @"每天";
        
    }else
    if ([week count]!=0) {
        
        NSLog(@"%@ %lu",week,(unsigned long)[week count]);
        NSMutableArray *repArry =[[NSMutableArray alloc]init];
        for (int i = 0; i<7; i++) {
            if ([week objectForKey:[NSString stringWithFormat:@"%d",i]]!=nil) {
                switch (i) {
                    case 1:
                        [repArry addObject:@"周一"];
                        break;
                    case 2:
                        [repArry addObject:@"周二"];
                        break;
                    case 3:
                        [repArry addObject:@"周三"];
                        break;
                    case 4:
                        [repArry addObject:@"周四"];
                        break;
                    case 5:
                        [repArry addObject:@"周五"];
                        break;
                    case 6:
                        [repArry addObject:@"周六"];
                        break;
                    case 0:
                        [repArry addObject:@"周日"];
                        break;

                    default:
                        break;
                }
            }
        }
        _reCount.text = @"";
        for (NSString *w in repArry) {
            _reCount.text = [NSString stringWithFormat:@"%@ %@",_reCount.text,w];
        }
    }else if([week count]==0)
        _reCount.text = @"永不";
   
}

@end
