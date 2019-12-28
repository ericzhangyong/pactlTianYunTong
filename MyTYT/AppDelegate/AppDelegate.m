//
//  AppDelegate.m
//  MyTYT
//
//  Created by Fly on 2018/4/23.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginVC.h"
#import "IQKeyboardManager.h"
#import "GSKeyChainDataManager.h"
#import "MyNeedInfo.h"
#import "MBProgressHUD+FLyHUD.h"
#import "Reachability.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "NSString+Helper.h"


@interface AppDelegate ()

@property (nonatomic) Reachability *reachablity;

@end

@implementation AppDelegate

//设置根控制器
- (void)setRootVC{
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    LoginVC *vc = [[LoginVC alloc] init];
    
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

//统一设置键盘
- (void)setKeyboard{
    //第三方键盘
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    [IQKeyboardManager sharedManager].toolbarDoneBarButtonItemText = @"完成";
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 50;
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
}

//保存uuid到keychain,即使删除app下次还会获取到UUID<注意换开发者账号,便取不到了>
- (void)setUUID{
    
    if ([[GSKeyChainDataManager readUUID] isEqualToString:@""] || [GSKeyChainDataManager readUUID] == nil) {
        [GSKeyChainDataManager saveUUID:[[MyNeedInfo shareInstace] getUUID]];
    }
}

//设置最大磁盘缓存<程序退出后台,或者从后台推出会触发缓存清除机制,如果时间超过一周,清理过期文件,容量超过50M清理最早存入数据>
- (void)setMaxCache{
    
    NSString *filepath = [NSString stringWithDocumentsPath:@""];
    FlyLog(@"---%@",filepath);
    
    //不解码，不缓存内存，防止加载大量图片，内存突然增大，导致内存不足，崩溃
    [SDImageCache sharedImageCache].config.shouldDecompressImages = NO;
    [[SDWebImageDownloader sharedDownloader] setShouldDecompressImages:NO];
    [SDImageCache sharedImageCache].config.shouldCacheImagesInMemory = NO;
    
    
    [[SDImageCache sharedImageCache].config setMaxCacheSize:1024 *1024 *50];
}

//设置访问url
- (void)setRequestURL{
    
    NSString *BaseUrl;
    
    if (testInteacher == 1) {
//        BaseUrl = @"http://chendejun00.gicp.net";
        BaseUrl = @"http://172.16.1.203:8080";
    }else{
        BaseUrl = @"http://10.10.9.160";
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:BaseUrl forKey:BaseUrlPath];

    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark------------------------------------------------------------------------------------
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setRequestURL];
    
    [self setMaxCache];
    
    [self setKeyboard];

    [self setUUID];
    
    [self setRootVC];

    return YES;
}


//#pragma mark------------------------------------------------------------------------------------
- (void)netChange:(NSNotification *)notification{

    Reachability *reachability = [notification object];

    switch ([reachability currentReachabilityStatus]) {
        case NotReachable:
        {
            [MBProgressHUD showImageView:self.window.subviews.lastObject textTitle:@"网络似乎断开连接了" imagename:@"net"];

        }
            break;

        case ReachableViaWiFi:
        {
        }
            break;
        case ReachableViaWWAN:
        {

        }
            break;
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins th2e transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //退出app取消监听网络
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];

    [self.reachablity stopNotifier];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //进入app监听网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netChange:) name:kReachabilityChangedNotification object:nil];
    self.reachablity = [Reachability reachabilityForInternetConnection];
    [self.reachablity startNotifier];

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
