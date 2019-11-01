//
//  PreSentScanVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/27.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "PreSentScanVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ScanTopView.h"
#import "ScanBotoomView.h"
#import "InputYDVC.h"
#import "WriteScanYDVC.h"

@interface PreSentScanVC ()<AVCaptureMetadataOutputObjectsDelegate>

@property (nonatomic) ScanTopView *topView;

@property (nonatomic) ScanBotoomView *bottomVIew;

//预览涂层
@property (nonatomic) AVCaptureVideoPreviewLayer *previewlayer;
//会话
@property (nonatomic) AVCaptureSession *sesstion;
//设备
@property (nonatomic) AVCaptureDevice *device;


@end

@implementation PreSentScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.translucent = NO;

    [self startWork];
  
}
- (void)dealloc{
    FlyLog(@"调用扫描delloloc");
}

// 这个方法是 UIViewController 自带的
- (void)viewWillTransitionToSize:(CGSize)size
       withTransitionCoordinator:(id <UIViewControllerTransitionCoordinator>)coordinator {
    
    // 翻转的时间
    NSTimeInterval duration = [coordinator transitionDuration];
    
    // 当翻转完成后，触发
    [UIView animateWithDuration:duration animations:^{
        
        UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
        
        if (orientation == UIDeviceOrientationLandscapeLeft){
            [self.previewlayer connection].videoOrientation = AVCaptureVideoOrientationLandscapeRight;
        }else{
            [self.previewlayer connection].videoOrientation = AVCaptureVideoOrientationLandscapeLeft;
            
        }
        
        
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    FlyLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:Oration]);
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:Oration] isEqualToString:@"left"]) {
        [self.previewlayer connection].videoOrientation = AVCaptureVideoOrientationLandscapeRight;
    }else{
        [self.previewlayer connection].videoOrientation = AVCaptureVideoOrientationLandscapeLeft;

    }

    
    [self.topView.layer insertSublayer:self.previewlayer atIndex:0];
    [self.sesstion startRunning];

}

- (void)viewDidLayoutSubviews{

    [super viewDidLayoutSubviews];

    self.topView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height *0.68);

    self.bottomVIew.frame = CGRectMake(0, CGRectGetMaxY(self.topView.frame), self.view.bounds.size.width, self.view.bounds.size.height *0.32);

    self.previewlayer.frame = self.topView.bounds;

    
    FlyLog(@"111");
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self setScanRect];

}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.previewlayer removeFromSuperlayer];
    if ([self.sesstion isRunning]) {
        [self.sesstion stopRunning];
    }
}

//设置扫描区域
- (void)setScanRect{
    
    AVCaptureMetadataOutput *output = [self.sesstion.outputs firstObject];
    
    //具体的扫描位置
    CGRect rect = self.topView.ImageRect;
    
    //转换坐标，必需在run之后执行
    CGRect interrect = [self.previewlayer metadataOutputRectOfInterestForRect:rect];
    
    //看到具体的坐标
    CGRect layerrect = [self.previewlayer rectForMetadataOutputRectOfInterest:interrect];
    
    FlyLog(@"%@",NSStringFromCGRect(layerrect));
    
    //设置扫描区域
    output.rectOfInterest = interrect;
    
    FlyLog(@"%@",self.sesstion.outputs);
}


#pragma mark------------------------------------------------------------------------------------

- (void)inputVC{
 
    switch (self.type) {
        case SCANYGD:
        {

            WriteScanYDVC *vc = [[WriteScanYDVC alloc] init];
            
            vc.machID = self.MachID;
            
            
            
            switch (self.fromType) {
                    
                case FromFirstCome:
                {
                    vc.type = FirstScanYDType;
                }
                    break;
                case FromTwentyCome:
                {
                    vc.type = TwentyScanYDType;

                }
                    break;
            }
            
            [self.navigationController pushViewController:vc animated:YES];

            
        }
            break;
            
        case SCANYCER:
        {
            InputYDVC *vc = [[InputYDVC alloc] init];

            vc.inputStr = @"证书号";
            
            vc.block = ^(NSString *Str) {
                
                [self.navigationController dismissViewControllerAnimated:YES completion:nil];
                
                self.block(Str);
                
            };
            
            [self.navigationController pushViewController:vc animated:YES];

        }
            break;
            
    }
    
 
}

- (void)startWork{
    //设置视图布局
    [self setUI];

    [self setFLyQrCode];

}



- (void)BackEvent{
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark------------------------------------------------------------------------------------

//设置扫描
- (void)setFLyQrCode{
    
    //获取媒体设备
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //创建输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    //创建输出流
    AVCaptureMetadataOutput *dataOutput = [[AVCaptureMetadataOutput alloc] init];
    //输出代理执行在主线程
    [dataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    //创建视频会话
    self.sesstion = [[AVCaptureSession alloc] init];
    //高采样率
    [self.sesstion setSessionPreset:AVCaptureSessionPresetHigh];
    
 
    //添加输入流
    [self.sesstion addInput:deviceInput];
    //添加输出流
    [self.sesstion addOutput:dataOutput];
    
    //设置扫码格式，输出元数据类型必须在添加到回话后设置格式
    if (self.type == SCANYGD) {
        
        dataOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeQRCode];

        self.bottomVIew.ScanLable.text = @"扫描运单号条码";
        self.bottomVIew.alertTitle.text = @"将运单号条码放入方框内";
        [self.bottomVIew.writBtn setTitle:@"手动输入运单号" forState:UIControlStateNormal];
        
        
    }else if (self.type == SCANYCER){
        
        dataOutput.metadataObjectTypes = @[AVMetadataObjectTypeCode128Code];
        
        self.bottomVIew.ScanLable.text = @"扫描证书号条码";
        self.bottomVIew.alertTitle.text = @"将证书号条码放入方框内";
        [self.bottomVIew.writBtn setTitle:@"手动输入证书号" forState:UIControlStateNormal];
    }
}

- (AVCaptureVideoPreviewLayer *)previewlayer{
    if (!_previewlayer) {
        _previewlayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.sesstion];
        _previewlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
       
    }
    return _previewlayer;
}

//输出代理，获取扫描结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count>0) {
        
        FlyLog(@"%@",metadataObjects);
        //获取字符串跳转
        AVMetadataMachineReadableCodeObject *medataObject = metadataObjects[0];
        
        FlyLog(@"%@",medataObject);
        
        NSString *str = medataObject.stringValue;
        
//        FlyLog(@"%@",str);
        
        //停止捕捉（捕捉到立即结束捕捉，要不会捕捉多次声音会出问题）
        [self.sesstion stopRunning];
        
        //播放提示音
        [self playSucessMusic];
        
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        
        self.block(str);

        
    }else{
        
    }
    
}
//播放扫描成功音乐
- (void)playSucessMusic{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"sound.caf" ofType:nil];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:filePath];
    //获得系统声音ID
    SystemSoundID soundID = 0;
    //创建系统音频
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    //添加到系统音频
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL,PlayComPlete, NULL);
    
    //播放音频
    AudioServicesPlaySystemSound(soundID);
    
}

void PlayComPlete(SystemSoundID soundID,void * clientData){
    
}


#pragma mark---------------------------------UI---------------------------------------------------

- (void)setUI{
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStyleDone target:self action:@selector(BackEvent)];
    
    self.navigationItem.leftBarButtonItem = left;
    [self.view addSubview:self.topView];
    self.topView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.bottomVIew];

    
    
}


- (ScanTopView *)topView{
    if (!_topView) {
        _topView = [[ScanTopView alloc] init];
        
    }
    return _topView;
}

- (ScanBotoomView *)bottomVIew{
    if (!_bottomVIew) {
        
        _bottomVIew = [[ScanBotoomView alloc] init];
        
        [_bottomVIew.writBtn addTarget:self action:@selector(inputVC) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomVIew;
}

@end
