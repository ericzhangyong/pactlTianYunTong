//
//  InputYDVC.m
//  MyTYT
//
//  Created by Fly on 2018/4/28.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "InputYDVC.h"
#import "InputCell.h"
#import "InputHeadView.h"
#import "UIImage+UIImage_FLyColor.h"
#import "IQKeyboardManager.h"

@interface InputYDVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (nonatomic) UITableView *tableview;

@end

@implementation InputYDVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.navigationController.navigationBar.translucent = NO;
    [self cretUI];

    [self settype];
    

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)viewDidLayoutSubviews{
    
    [super viewDidLayoutSubviews];
    
    self.tableview.frame =  self.view.bounds;
   
}

//保存
- (void)saveEvent{
    
    InputCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
  NSString *str = cell.textfiled.text;
    
    [self.navigationController popViewControllerAnimated:NO];
    
    self.block(str);
}

- (void)dealloc{
    FlyLog(@"手写delloc");
}

#pragma mark------------------------------------------------------------------------------------
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if ([string isEqualToString:@" "]) {//空格
        
        return NO;
        
    }
    
    

    if  ([string isEqualToString:@""]) {
       
        
        if (textField.text.length == 1) {
            self.navigationItem.rightBarButtonItem.enabled = NO;

        }else{
            
            self.navigationItem.rightBarButtonItem.enabled = YES;
        }
        
    }else{
        self.navigationItem.rightBarButtonItem.enabled = YES;

    }
    
    return YES;
}
#pragma mark------------------------------------------------------------------------------------
- (UITableView *)tableview{
    
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAlways;
        } else {
            // Fallback on earlier versions
        }
        _tableview.allowsSelection = NO;
        _tableview.backgroundColor = [UIColor whiteColor];
        InputHeadView *headview = [[InputHeadView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 90)];
        _tableview.tableHeaderView = headview;
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.estimatedRowHeight = 80;
        [_tableview registerNib:[UINib nibWithNibName:@"InputCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"InputCellID"];
    }
    return _tableview;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    InputCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InputCellID" forIndexPath:indexPath];
    cell.textfiled.delegate = self;

    [cell loadtitle:self.inputStr];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    InputCell *inputcell = (InputCell *)cell;
    [inputcell.textfiled becomeFirstResponder];

}

#pragma mark------------------------------------------------------------------------------------

- (void)cretUI{
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveEvent)];
    self.navigationItem.rightBarButtonItem = right;
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableview];
    
    [self settype];
    
   
}


- (void)settype{
  InputHeadView *headview =  (InputHeadView *)self.tableview.tableHeaderView;
        headview.titlelable.text = [NSString stringWithFormat:@"手动输入%@",self.inputStr];
        headview.subtitlelable.text =[NSString stringWithFormat:@"输入%@信息",self.inputStr];
    
}


@end
