//
//  NotificationModel.h
//  智能牙刷
//
//  Created by wisdom on 15-6-1.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ClockAlarm.h"

#define  ViewHeight [[UIScreen mainScreen] bounds].size.height
#define  ViewWidth [[UIScreen mainScreen] bounds].size.width

typedef void (^CallBackBlock) (NSError *error);
@interface NotificationModel : NSObject{
    CallBackBlock callBackBlock;

}
-(void)setLocatNotfication:(int)weekday setDate:(ClockAlarm *)clockAlarm;
-(void)setUnitDayNotfication:(ClockAlarm *)clockAlarm;
-(void)cancleNotification:(ClockAlarm *)clockAlarm callBackBlock:(CallBackBlock)block;
@end
