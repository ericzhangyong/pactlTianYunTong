//
//  WriteScanhistoryCell.h
//  MyTYT
//
//  Created by Fly on 2018/9/11.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ScanHisToryModel;

@interface WriteScanhistoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *operationMachine;
@property (weak, nonatomic) IBOutlet UILabel *operationMan;
@property (weak, nonatomic) IBOutlet UILabel *operationState;
@property (weak, nonatomic) IBOutlet UILabel *operationtime;
- (void)loadDataWithModel:(ScanHisToryModel *)model ScanType:(ScanType)scanVCType;




@end
