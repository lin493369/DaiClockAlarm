//
//  NotificationModel.m
//  智能牙刷
//
//  Created by wisdom on 15-6-1.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "NotificationModel.h"

#define  ViewHeight [[UIScreen mainScreen] bounds].size.height
#define  ViewWidth [[UIScreen mainScreen] bounds].size.width

@implementation NotificationModel
-(void)setLocatNotfication:(int)weekday setDate:(ClockAlarm *)clockAlarm{
    NSLog(@"设置通知");
    // 初始化本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        
        NSDate *current = [NSDate date];
        NSCalendar *calendar = [NSCalendar currentCalendar];
        NSDateComponents *comps = [calendar components:NSCalendarUnitWeekday|NSCalendarUnitYear|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond fromDate:current];
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        [df setDateFormat:@"MM"];
        [comps setMonth:[[df stringFromDate:current]integerValue]];
        [df setDateFormat:@"yyyy"];
        [comps setYear:[[df stringFromDate:current]integerValue]];
        [df setDateFormat:@"dd"];
        [comps setDay:[[df stringFromDate:current]integerValue]];
        [df setDateFormat:@"HH"];
        [comps setHour:[[df stringFromDate:clockAlarm.time]integerValue]];
        [df setDateFormat:@"mm"];
        [comps setMinute:[[df stringFromDate:clockAlarm.time]integerValue]];
        [comps setSecond:0];

        NSDate *date1 = [calendar dateFromComponents:comps];
        int temp = 0;
        int days = 0;
        
        temp = weekday - (int)comps.weekday;
        
        days = (temp >= 0 ? temp : temp + 7);
        if (weekday==0) {
            days = 0;
        }
        notification.fireDate = [date1 dateByAddingTimeInterval:3600 * 24 * days];
        
        // 设置重复间隔
        if (weekday == 0) {
            notification.repeatCalendar = 0;
        }else
            notification.repeatInterval = kCFCalendarUnitWeek;
        
        // 设置提醒的文字内容
        notification.alertBody   = @"该刷牙啦，宝贝";
        notification.alertAction = NSLocalizedString(@"该刷牙啦，宝贝", nil);
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        NSDictionary *aUserInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId] forKey:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId]];
        notification.userInfo = aUserInfo;
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
    
}
-(void)setUnitDayNotfication:(ClockAlarm *)clockAlarm{
    // 初始化本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification) {
        // 设置通知的提醒时间
        notification.timeZone = [NSTimeZone defaultTimeZone]; // 使用本地时区
        notification.fireDate = [clockAlarm.time dateByAddingTimeInterval:5.0];
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        
        // 设置提醒的文字内容
        notification.alertBody   = @"该刷牙啦，宝贝";
        notification.alertAction = NSLocalizedString(@"该刷牙啦，宝贝", nil);
        
        // 通知提示音 使用默认的
        notification.soundName= UILocalNotificationDefaultSoundName;
        
        // 设置应用程序右上角的提醒个数
        notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        NSDictionary *aUserInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId] forKey:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId]];
        notification.userInfo = aUserInfo;
        
        // 将通知添加到系统中
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
    }
    
}
-(void)cancleNotification:(ClockAlarm *)clockAlarm callBackBlock:(CallBackBlock)block{
    UIApplication *app = [UIApplication sharedApplication];
    //获取本地推送数组
    NSArray *localArray = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //声明本地通知对象
    UILocalNotification *localNotification;
    NSMutableArray *notiArry = [[NSMutableArray alloc]init];
    if (localArray) {
        for (UILocalNotification *noti in localArray) {
            NSDictionary *dict = noti.userInfo;

            if (dict) {
                NSString *inKey = [dict objectForKey:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId]];
                if ([inKey isEqualToString:[NSString stringWithFormat:@"%ld",(long)clockAlarm.clockId]]) {
                    {
                        [notiArry addObject:noti];
                    }
                }
            }
        }
        NSError *e = nil;
        //判断是否找到已经存在的相同key的推送
        if ([notiArry count]==0) {
            //不存在初始化
            localNotification = [[UILocalNotification alloc] init];
            if (block) {
                
            NSDictionary *userInfo = [NSDictionary dictionaryWithObject:@"undefine key"                                                                      forKey:NSLocalizedDescriptionKey];
            e = [[NSError alloc]initWithDomain:@"didn't find the key " code:-1000 userInfo:userInfo];
            block(e);
            }
        }
        else{
            //不推送 取消推送
            for (UILocalNotification *localNotification in notiArry) {
                [app cancelLocalNotification:localNotification];
            }
            block(e);
            return;
        }  
    }

}
@end
