//
//  AddAlarmViewController.h
//  智能牙刷
//
//  Created by wisdom on 15-5-28.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddAlarmViewController : UITableViewController{

}
@property (weak, nonatomic) IBOutlet UIView *ClockView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (strong,nonatomic) NSMutableDictionary *week;

@end
