//
//  ClockAlarm.h
//  智能牙刷
//
//  Created by wisdom on 15-5-28.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClockAlarm : NSObject
@property(nonatomic,retain) NSDate *time;
@property(nonatomic,retain) NSString *weekReapt;
@property(nonatomic,retain) NSString *tag;
@property BOOL isOn;
@property NSInteger clockId;
@property (nonatomic,retain)NSDictionary *weekArray;
@end
