//
//  LeftView.m
//  MyTYT
//
//  Created by Fly on 2018/4/29.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "LeftView.h"
#import "ScanCell.h"
#import "ScanModel.h"
#import "Masonry.h"
#import "ScanHisCell.h"
#import "ScanSectionModel.h"
#import "ScanRowModel.h"

@interface LeftView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign) ScanType vcType;
@end

@implementation LeftView

- (instancetype)initWithFrame:(CGRect)frame
                       vcType:(ScanType)scanVcType
                   Dectection:(DetectionType)detectionType
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vcType = scanVcType;
        self.detectionType = detectionType;
        [self creatUI];
        
        [self layout];
        
    }
    return self;
}

- (void)changDataArray{
    
    NSMutableArray *array = [NSMutableArray array];

    for (ScanSectionModel *sectionModel in self.dataArray) {

//        NSData *data =[NSKeyedArchiver archivedDataWithRootObject:sectionModel.scanModel];
        NSDictionary *dict = sectionModel.scanModel.modelToJsonDictionary;
        [array addObject:dict];
//        [array addObject:data];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:YDArray];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (void)setFreshDataWithRow:(NSInteger)row{
    
    [self.tableview reloadData];
    
    [self selectZeroRowWithSection:row];
   
}

- (void)selectZeroRowWithSection:(NSInteger)section{
    
    [self.tableview selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    [self tableView:self.tableview didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
}



- (void)creatUI{
    
    [self addSubview:self.titlelable];
    [self addSubview:self.saveBtn];
    [self addSubview:self.tableview];
}

- (void)layout{
    
    [_titlelable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.top.equalTo(self).offset(30);
        make.height.height.equalTo(@40);
    }];
    
    [_saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-20);
        make.height.equalTo(@35);
        make.width.equalTo(@100);
        make.bottom.equalTo(self).offset(-20);;
    }];
    
    [_tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlelable.mas_bottom).offset(25);
        make.bottom.equalTo(self.saveBtn.mas_top).offset(-25);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
    
}

- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        _saveBtn.layer.cornerRadius = 17.5;
        _saveBtn.layer.masksToBounds = YES;
        _saveBtn.backgroundColor = NavColor;
        [_saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveBtn.titleLabel setFont:[UIFont boldSystemFontOfSize:18]];
        [_saveBtn addTarget:self action:@selector(saveevent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveBtn;
}

- (UILabel *)titlelable{
    if (!_titlelable) {
        _titlelable =[[UILabel alloc] init];
        _titlelable.text = @"运单状态";
        _titlelable.font = [UIFont boldSystemFontOfSize:25];
        _titlelable.textColor = [UIColor blackColor];
    }
    return _titlelable;
}

- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.estimatedRowHeight = 100;
        _tableview.tableHeaderView = [[UIView alloc] init];
        _tableview.tableFooterView = [[UIView alloc] init];
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableview.backgroundColor = [UIColor whiteColor];
        _tableview.estimatedSectionHeaderHeight = 0;
        _tableview.estimatedSectionFooterHeight = 0;
        
        if (@available(iOS 11.0, *)) {
            _tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
        [_tableview registerNib:[UINib nibWithNibName:@"ScanCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ScanCellID"];
        [_tableview registerNib:[UINib nibWithNibName:@"ScanHisCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"ScanHisCellID"];

    }
    return _tableview;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark------------------------------------------------------------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    
    return model.rowArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];

    return model.sctionHeadHeight;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    
    return model.sctionFootHeight;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    return model.SectionHeadView;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    ScanSectionModel *model = self.dataArray[section];
    return model.SectionFooterView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ScanSectionModel *model = self.dataArray[indexPath.section];

    ScanRowModel *rowModel = model.rowArray[indexPath.row];
    
    switch (rowModel.Type) {
        case ScanStateRowType:
        {
            ScanCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScanCellID" forIndexPath:indexPath];
            [cell loaddatWithMdoel:rowModel.scanModel detectionType:self.detectionType];
            cell.DeleteBtn.tag = indexPath.section+100;
            [cell.DeleteBtn addTarget:self action:@selector(deleteWIthBtn:) forControlEvents:UIControlEventTouchUpInside];
            return cell;

        }
            break;
            
        case ScanHistoryRowType:
        {
            ScanHisCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScanHisCellID" forIndexPath:indexPath];
            [cell loadDataWithModel:rowModel.hisModel];
            return cell;
        }
            break;
    }
    
  
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{    
    
    NSIndexPath *indexrow = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    ScanCell *cell = [tableView cellForRowAtIndexPath:indexrow];
    cell.selected = YES;
    
    if ([_delelgate respondsToSelector:@selector(SelectRowShowModel:)]) {
        
        ScanSectionModel *sectionmodel = self.dataArray[indexPath.section];
        
        [_delelgate SelectRowShowModel:sectionmodel.scanModel];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSIndexPath *indexrow = [NSIndexPath indexPathForRow:0 inSection:indexPath.section];
    ScanCell *cell = [tableView cellForRowAtIndexPath:indexrow];
    cell.selected = NO;
}

#pragma mark------------------------------------------------------------------------------------
//删除
- (void)deleteWIthBtn:(UIButton *)sender{
    
    NSInteger section = sender.tag - 100;
    
    BOOL isDeleteLastOne;
    
    if (section == self.dataArray.count-1) {//删除的是最后一条数据
        
        isDeleteLastOne = YES;
        
    }else{//不是最后一条数据，后面有数据
        isDeleteLastOne = NO;
    }
    
    [self.dataArray removeObjectsAtIndexes:[NSIndexSet indexSetWithIndex:section]];
    [self.tableview reloadData];
    
    [self changDataArray];//改变数据
    

    
    if (isDeleteLastOne == YES) {//删除的是最后一条数据
        
        if (self.dataArray.count>0) {//有数据，展示删除后最后一条数据
            
            ScanSectionModel *sectionModel = [self.dataArray lastObject];
            [_delelgate SelectRowShowModel:sectionModel.scanModel];
            [self selectZeroRowWithSection:self.dataArray.count - 1];
            
            
        }else{//没有数据展示空白
            [_delelgate deleteEvent];
        }
        
    }else{//展示删除后的那一行数据即row
        
        ScanSectionModel *sectionModel = self.dataArray[section];
        [_delelgate SelectRowShowModel:sectionModel.scanModel];
        [self selectZeroRowWithSection:section];
    }
    
    
}

//保存
- (void)saveevent{
    if ([_delelgate respondsToSelector:@selector(saveEventWith:)]) {
        
        [_delelgate saveEventWith:self.dataArray];
    }
}


@end
