//
//  DeatilCheckCell.m
//  MyTYT
//
//  Created by Fly on 2018/5/16.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "DeatilCheckCell.h"
#import "CheckModel.h"

@implementation DeatilCheckCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)loadDataWithModel:(CheckModel *)model{
    
//    '101' : '首检通过',
//    '102' : '首检待定',
//    '200' : '安检中',
//    '201' : '安检通过',
//    '202' : '安检扣押',

    if ([model.a_status isEqualToString:@"101"]) {
        self.CheckStatus.text = @"首检通过";
    }else if ([model.a_status isEqualToString:@"102"]){
        self.CheckStatus.text = @"首检待定";

    }else if ([model.a_status isEqualToString:@"200"]){
        self.CheckStatus.text = @"安检中";

    }else if ([model.a_status isEqualToString:@"201"]){
        self.CheckStatus.text = @"安检通过";

    }else if ([model.a_status isEqualToString:@"202"]){
        self.CheckStatus.text = @"安检扣押";

    }else {
         self.CheckStatus.text = @"";
    }
    
    
    self.operatime.text = model.operatdate;
    
    
//    if ([model.a_status isEqualToString:@"101"] || [model.a_status isEqualToString:@"102"] || [model.a_status isEqualToString:@"200"]) {
//        self.opearMan.text = [NSString stringWithFormat:@"%@号安检机",model
//                              .machine];
//    }else{
//        self.opearMan.text = [NSString stringWithFormat:@"%@安检人员",model
//                              .personid];
//    }
    

    if (![model.machine isEqualToString:@""] && ![model.personid isEqualToString:@""]) {//安检机安检人员都有
        self.opearMan.text = [NSString stringWithFormat:@"%@号安检机/%@",model
                              .machine,model.personid];
    }else if (![model.machine isEqualToString:@""]){//有安检机
        self.opearMan.text = [NSString stringWithFormat:@"%@号安检机",model
                              .machine];
    }else if (![model.personid isEqualToString:@""]){//有安检人员
        self.opearMan.text = [NSString stringWithFormat:@"%@",model
                              .personid];
    }else{//都没有
        self.opearMan.text = [NSString stringWithFormat:@"%@号安检机/%@",model
                              .machine,model.personid];
    }
    
   

 
    

   
}

@end
