//
//  FlyPhotoNav.m
//  FlyPhotoKitManger
//
//  Created by Fly on 2017/11/30.
//  Copyright © 2017年 上海易迪爱信息技术有限公司. All rights reserved.
//

#import "FlyPhotoNav.h"

@interface FlyPhotoNav ()

@end

@implementation FlyPhotoNav


- (void)viewDidLoad {
    [super viewDidLoad];

//
    self.navigationBar.titleTextAttributes = @{
                                               NSForegroundColorAttributeName:[UIColor whiteColor]
                                               };

    self.navigationBar.tintColor = [UIColor whiteColor];
    
    self.navigationBar.barTintColor = [UIColor colorWithRed:(34/255.0) green:(34/255.0)  blue:(34/255.0) alpha:1.0];
    
    self.navigationBar.translucent = YES;
    
    self.navigationBar.barStyle = UIBarStyleBlack;
    
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{

    [super pushViewController:viewController animated:animated];

    if ([self.childViewControllers.firstObject isEqual:viewController]) {
        UIBarButtonItem *backitem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backEvent)];
        viewController.navigationItem.backBarButtonItem = backitem;
    }else{
        
    }
}

- (void)backEvent{
    [self popViewControllerAnimated:YES];
}
@end
