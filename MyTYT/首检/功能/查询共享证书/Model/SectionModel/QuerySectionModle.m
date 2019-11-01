//
//  QuerySectionModle.m
//  MyTYT
//
//  Created by Fly on 2018/5/30.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "QuerySectionModle.h"
#import "QuerybaseModel.h"
#import "QueryRowModel.h"

@implementation QuerySectionModle


- (instancetype)initWithcellType:(QuerySectionCellType)type rowArray:(NSArray <NSArray *> *)rowArray{
    
    if (self = [super init]) {
     
        self.cellType = type;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSArray *temArray in rowArray) {
            
            for (int i = 0; i<temArray.count; i++) {

                QuerybaseModel *basemodel = temArray[i];
                
                QueryRowModel *model = [[QueryRowModel alloc] initWithModel:basemodel];
                
                model.dataRow = i;
                
                [array addObject:model];
            }
            
        }
        
        self.rowArray = [NSArray arrayWithArray:array];
        
        [self setdata];
        
    }
    
    return self;
}

- (void)setdata{
    
    switch (self.cellType) {
        case SectionCerStateType:
        {
            self.sectionInset=  UIEdgeInsetsMake(0, 0, 0, 0);
            self.SectionheadSize = CGSizeMake(kuan, 0);
            self.SectionfootSize = CGSizeMake(kuan, 0);
            self.minlineSpace = 0;
            self.minInterSpace = 0;
            self.Sectiontitle = @"证书信息";
        }
            break;
            
        case SectionAgentType:
        {
            self.sectionInset=  UIEdgeInsetsMake(0, 20, 20, 20);
            
            self.SectionheadSize = CGSizeMake(kuan, 0);
            self.SectionfootSize = CGSizeMake(kuan, 0);
//            self.SectionheadSize = self.rowArray.count > 0 ? CGSizeMake(kuan, 50) : CGSizeMake(kuan, 0);

//            self.SectionfootSize = self.rowArray.count > 0 ? CGSizeMake(kuan, 35) : CGSizeMake(kuan, 0);
            
            self.minlineSpace = 20;
            self.minInterSpace = 20;
            self.Sectiontitle = @"授权代理";
        }
            break;
            
        case SectionImageType:
        {
            self.sectionInset=  UIEdgeInsetsMake(20, 20, 20, 20);
            
            self.SectionheadSize = CGSizeMake(kuan, 0);
            self.SectionfootSize = CGSizeMake(kuan, 0);
//            self.SectionheadSize = self.rowArray.count > 0 ? CGSizeMake(kuan, 50) : CGSizeMake(kuan, 0);
//            
//            self.SectionfootSize = self.rowArray.count > 0 ? CGSizeMake(kuan, 35) : CGSizeMake(kuan, 0);
//            
            self.minlineSpace = 20;
            self.minInterSpace = 20;
            self.Sectiontitle = @"证书图片";

        }
            break;
            
        default:
        {
           

        }
            break;
    }
}


@end
