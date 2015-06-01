//
//  ConfigValueViewController.h
//  智能牙刷
//
//  Created by wisdom on 15-6-1.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef  void (^StrBlock)(NSString *str);
@interface ConfigValueViewController : UIViewController

@property (nonatomic, copy) StrBlock strBlock;
@property (nonatomic,retain)NSString *lastStr;
-(void)returnStr:(StrBlock)block;
@end
