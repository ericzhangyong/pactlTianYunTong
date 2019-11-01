//
//  MYTimer.m
//  MyTYT
//
//  Created by Fly on 2018/5/9.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "MYTimer.h"
#import "LoginVC.h"
#import "MBProgressHUD+FLyHUD.h"
#import "FlyHttpTools.h"
#import "DeviceModel.h"
#import "FLyAleartView.h"

@interface MYTimer ()

@property (nonatomic) NSTimer *timer;

@property (nonatomic,assign) NSInteger time;

@property (nonatomic) NSDate *Fdate;

@property (nonatomic,assign) ComingType type;

@end

@implementation MYTimer

- (void)dealloc{
    FlyLog(@"timerDelloc");
}

+ (instancetype)shareINstace{
    static MYTimer *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

//登录进去，开始计时
- (void)startTimerWithType:(ComingType)type{
    
    self.type = type;
    
    [self setNotification];
    
    //设置消息默认已读
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isReadMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    switch (self.type) {
            
        case FirstNeedNotificationType:
        {
              self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(FirstEvent) userInfo:nil repeats:YES];
        }
            break;
            
        case TwentyType:
        {
            self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(twentyEvent) userInfo:nil repeats:YES];
            
        }
            break;
    }
    
  
    
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}

//登录
- (void)endTimeWithType:(LeaveType)type{
    
    [self.timer invalidate];
    
    self.timer = nil;
    
    [self setMessageStart];
    
    [self removeYDArray];
    
    [self endNotiFication];
    
    [self removeCookie];
    
    [self backEventWithType:type];
    
}



- (void)setNotification{
    
    self.time = LeavTime;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterBG) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterFG) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)endNotiFication{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];

}

//进入后台记下时间
- (void)enterBG{
    self.Fdate = [NSDate date];
    FlyLog(@"%@",self.Fdate);
}

//回到前台对比时间差
- (void)enterFG{
    
    NSTimeInterval time =  [[NSDate date] timeIntervalSinceDate:self.Fdate];
    
    self.time -= time;
}


//首检
- (void)FirstEvent{
    
    [self BaseEvent];
    
    [self messageEvent];
}

//24小时
- (void)twentyEvent{
    
    [self BaseEvent];
}

//基础定时任务
- (void)BaseEvent{
    
    self.time--;
    
//    FlyLog(@"%ld",self.time);
    
    if (self.time <= 0) {
        
        [self endTimeWithType:DeadTimeLine];

    }
}

//处理消息
- (void)messageEvent{
 
    if (self.time>30 && self.time % 30 == 0) {
        [self dealTimeMessage];
    }
}

- (NSString *)NowTime{
    
    NSDate *date = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
   return [dateFormatter stringFromDate:date];
}

//设置消息
- (void)setMessageStart{
    //设置消息默认
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isReadMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//重新设置cooki
- (void)removeCookie{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:MYCOOKE];//移除保存的cooken
}

//设置扫描数据为空
- (void)removeYDArray{
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:YDArray];
}

//退回登录页面
- (void)backEventWithType:(LeaveType)type{
    
    UIWindow *keyeindow = [UIApplication sharedApplication].keyWindow;
    
    LoginVC *vc = [[LoginVC alloc] init];
    
    
    [UIView transitionFromView:keyeindow.rootViewController.view toView:vc.view duration:0.3 options:UIViewAnimationOptionCurveEaseInOut completion:^(BOOL finished) {
        keyeindow.rootViewController = vc;
        
        if (type == DeadTimeLine) {
            [MBProgressHUD showTextView:vc.view textTitle:@"登录时间超过30分钟,已自动退出"];
        }else if (type == TokenInValid){
            [MBProgressHUD showTextView:vc.view textTitle:@"登录失效已自动退出,请重新登录"];
        }
        
    }];
}


#pragma mark------------------------------------------------------------------------------------
//定时消息
- (void)dealTimeMessage{
  
    NSDictionary *updic = @{
                            @"dateTime":[self NowTime],
                            @"machineId":self.deviceModel.machinID,
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/queryNewNotesByMachineId" success:^(NSDictionary *dic) {

        FlyLog(@"%@",dic);
        if ([dic[@"ok"] intValue] == 1) {

            if (dic[@"data"] !=Nil && [dic[@"data"] isKindOfClass:[NSDictionary class] ]) {
                NSDictionary *temdic = dic[@"data"];


                if (temdic[@"num"]!=Nil && [temdic[@"num"] integerValue]>0) {

                    if ([[NSUserDefaults standardUserDefaults] boolForKey:isReadMessage] == NO) {//消息未读不推出
                        
                        
                    }else{
                        
                        [self presetVCWithStr:[[NSString alloc] initWithFormat:@"您有%@条消息未读,请点击首页保存按钮刷新您的最新消息",temdic[@"num"]]];
                    }
                    
                }

            }

        }else{
            [MBProgressHUD showTextView:nil textTitle:dic[@"msg"]];
        }

    } failure:^(NSString *NetFailReason) {
        [MBProgressHUD showTextView:nil textTitle:NetFailReason];
    }];

    FlyLog(@"-----30的倍数------");
}

- (void)presetVCWithStr:(NSString *)str{
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:isReadMessage];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [FLyAleartView showAleartViewWithtitle:@"-消息提示-" subtitle:str imageName:@"loginimage" suretitle:@"好的" sure:^{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:isReadMessage];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
}

@end
