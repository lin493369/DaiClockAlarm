//
//  ConfigValueViewController.m
//  智能牙刷
//
//  Created by wisdom on 15-6-1.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "ConfigValueViewController.h"

@interface ConfigValueViewController ()
@property (nonatomic,retain)UITextField *label;
@end

@implementation ConfigValueViewController
@synthesize label;
@synthesize strBlock;
@synthesize lastStr;
- (void)viewDidLoad {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
        UIView *modifyNameView = [[UIView alloc]initWithFrame:CGRectMake(0, 70,self.view.frame.size.width, self.view.frame.size.height)];
        self.view.backgroundColor = [UIColor colorWithWhite:.9 alpha:1.0];
         label = [[UITextField alloc]initWithFrame:CGRectMake(0, 10, self.view.frame.size.width,35)];
//        label.placeholder = @"请输入标签";
        label.backgroundColor = [UIColor whiteColor];
        [label setClearButtonMode:UITextFieldViewModeWhileEditing];
        [modifyNameView addSubview:label];
        [self.view addSubview:modifyNameView];
    
    if (lastStr) {
        label.text = lastStr;
    }
    [label becomeFirstResponder];
}
- (IBAction)save:(id)sender {
    if (strBlock) {
        strBlock(label.text);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)cacle:(id)sender {
    if (strBlock) {
        strBlock(lastStr);
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];

}
-(void)returnStr:(StrBlock)block{
    
    self.strBlock = block;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
