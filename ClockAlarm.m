//
//  ClockAlarm.m
//  智能牙刷
//
//  Created by wisdom on 15-5-28.
//  Copyright (c) 2015年 MY. All rights reserved.
//

#import "ClockAlarm.h"
static NSInteger maxClockId = 0;

@implementation ClockAlarm
@synthesize tag;
@synthesize time;
@synthesize weekReapt;
@synthesize isOn;
@synthesize clockId;
@synthesize weekArray;
- (id)init {
    
    if (self = [super init]) {
        NSLog(@"dfd");
        tag = [[NSString alloc] init];
        weekReapt = [[NSString alloc] init];
        time = [[NSDate alloc] init];
        weekArray = [[NSDictionary alloc]init];
        isOn = YES;
        clockId = maxClockId+1;
        maxClockId++;
        
    }
    
    return self;
}
-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeObject:self.tag forKey:@"tag"];
    [coder encodeObject:self.time forKey:@"time"];
    [coder encodeObject:self.weekReapt forKey:@"weekReapt"];
    [coder encodeBool:self.isOn forKey:@"isOn"];
    [coder encodeInteger:self.clockId forKey:@"clockId"];
    [coder encodeObject:self.weekArray forKey:@"weekArray"];


}
- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init])
    {
        self.tag = [decoder decodeObjectForKey:@"tag"];
        self.time = [decoder decodeObjectForKey:@"time"];
        self.weekReapt = [decoder decodeObjectForKey:@"weekReapt"];
        self.isOn = [decoder decodeBoolForKey:@"isOn"];
        self.clockId = [decoder decodeIntegerForKey:@"clockId"];
        self.weekArray = [decoder decodeObjectForKey:@"weekArray"];

    }
    return self;
}
-(NSString *)description{
    return [NSString stringWithFormat:@"weekarray is %@ week = %@, tag = %@, time = %@ isOn = %hhd maxId is %ld id is %ld",self.weekArray,self.weekReapt,self.tag,self.time,self.isOn,(long)maxClockId,(long)self.clockId];
}
@end
