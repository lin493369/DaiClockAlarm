//
//  ClockAlarmViewController.h
//  智能牙刷
//
//  Created by wisdom on 15-5-27.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddAlarmViewController.h"

@interface ClockAlarmViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)UITableView *clockView;
@end
