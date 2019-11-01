//
//  AddMyBzViewModel.m
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import "AddMyBzViewModel.h"
#import "FlyHttpTools.h"
#import "FlyView.h"
#import "AddBZALlModel.h"
#import "BZModle.h"
#import "BZAddModel.h"
#import "AddBZDataManager.h"
#import "AddBZImageModel.h"
#import "MyimageModel.h"
#import "MyimageModel.h"

@implementation AddMyBzViewModel


- (void)loadBZDataWithaWID:(NSString *)awID view:(UIView *)superView success:(LoadBZDetailBlock)success fail:(LoadBZDetailFailBlock)fail{
    
    [FlyView showFlyViewFromSuperView:superView];
    
    NSDictionary *updic = @{
                            @"awId":awID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/getRemraks" success:^(NSDictionary *dic) {
        
        [FlyView removeFlyViewFromSuperView:superView];

        AddBZALlModel *allmodel = [[AddBZALlModel alloc] initWithDic:dic];
        success(allmodel);
        FlyLog(@"%@",dic);
        
    } failure:^(NSString *NetFailReason) {
        
        [FlyView removeFlyViewFromSuperView:superView];
        fail(NetFailReason);

    }];
    
}



- (NSString *)MyExplainerror:(NSError *)error{
    
    if (error.code == NSURLErrorNotConnectedToInternet) {
        return @"请检查网络设置";
    }else if (error.code == NSURLErrorTimedOut){
        return @"请求超时";
    }else{
        return @"未知错误";
    }
    return nil;
}


#pragma mark------------------------------------------------------------------------------------
//删除备注
- (void)deleteBZWithModel:(BZModle *)model
                    start:(OperationBZStartBlock)start
                  success:(OpeartionBZSuccessBlock)success
                     fail:(OperationBZFailBlock)fail{
    
    start();
    
    NSString *interface = [@"/api/pactl/scheck/delRemark" stringByAppendingPathComponent:model.ID];
    
    NSDictionary *updic = @{
                            
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:interface success:^(NSDictionary *dic) {
        
        [self OperationResultWithDic:dic success:success fail:fail];
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
        
    }];
}


#pragma mark------------------------------------------------------------------------------------
//编辑备注
- (void)editBZWithModel:(BZModle *)model
                   text:(NSString *)text
                  start:(OperationBZStartBlock)start
                success:(OpeartionBZSuccessBlock)success
                   fail:(OperationBZFailBlock)fail{
 
    start();
    
    NSDictionary *updic = @{
                            @"id":model.ID,
                            @"awId":model.awID,
                            @"remark":text,
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/updateRemrak" success:^(NSDictionary *dic) {
        
        [self OperationResultWithDic:dic success:success fail:fail];
        
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);

    }];
}

//操作处理
- (void)OperationResultWithDic:(NSDictionary *)dic success:(OpeartionBZSuccessBlock)success
                          fail:(OperationBZFailBlock)fail{
    
    if ([dic[@"ok"] intValue] == 1) {
        success(dic[@"data"]);
    }else{
        fail(dic[@"msg"]);
    }
    FlyLog(@"%@",dic);
}

#pragma mark------------------------------------------------------------------------------------
//上传图片
- (void)upPicDataWith:(NSData *)picData
                start:(OperationBZStartBlock)start
              success:(UpPicSuccess)success
                 fail:(OperationBZFailBlock)fail{
    
    start();
    
    [FlyHttpTools postWithPicData:picData interface:@"/api/pactl/uploadfile" success:^(NSDictionary *dic) {
        
        [self dealUpPicresultWithDic:dic success:success fail:fail];
        
        FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}

//处理上传图片返回结果
- (void)dealUpPicresultWithDic:(NSDictionary *)dic  success:(UpPicSuccess)success
                          fail:(OperationBZFailBlock)fail{
    
    if ([dic[@"ok"] integerValue] == 1) {
        
        NSDictionary *temdic = dic[@"data"];
        NSString *FileID = temdic[@"fileId"];
        NSString *picpath = [[NSString alloc] initWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],temdic[@"fileHttpPath"]];
        success(FileID,picpath);
        
        
    }else{
        fail(dic[@"msg"]);
    }
}

#pragma mark------------------------------------------------------------------------------------
//添加备注
- (void)AddBZWithaWID:(NSString *)aWID
               machID:(NSString *)machID
           dataManger:(AddBZDataManager *)DataManger
                start:(OperationBZStartBlock)start
              success:(OpeartionBZSuccessBlock)success
                 fail:(OperationBZFailBlock)fail{
    
    start();
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (MyimageModel *mdoel in DataManger.imageModel.dataarray) {
        
        [array addObject:mdoel.FileID];
    }
    
   NSString *fileID = [array componentsJoinedByString:@";"];
    
    NSDictionary *updic = @{
                            @"awId":aWID,
                            @"remark":DataManger.addmodel.content,
                            @"fileId":fileID,
                            @"mcid":machID
                            };
    
    [FlyHttpTools postWithJsonDic:updic interface:@"/api/pactl/check/addRemrak" success:^(NSDictionary *dic) {
        [self OperationResultWithDic:dic success:success fail:fail];
        FlyLog(@"%@",dic);
    } failure:^(NSString *NetFailReason) {
        fail(NetFailReason);
    }];
}

//上传多张照片
- (void)upMorePicDataWithArray:(NSArray *)array
                         start:(OperationBZStartBlock)start
                       success:(UpMoreSuccess)success
                          fail:(OperationBZFailBlock)fail{
    
    start();
    
    dispatch_group_t group = dispatch_group_create();
    
   __block NSMutableArray *dataArray = [NSMutableArray array];

   __block NSString *errroStr = @"";
    
    for (int i=0; i<array.count; i++) {

        dispatch_group_enter(group);
        FlyLog(@"发出请求---%d",i);
        [FlyHttpTools postWithPicData:array[i] interface:@"/api/pactl/uploadfile" success:^(NSDictionary *dic) {
            
            
            if ([dic[@"ok"] integerValue] == 1) {
                
                NSDictionary *temdic = dic[@"data"];
                NSString *FileID = temdic[@"fileId"];
                NSString *picpath = [[NSString alloc] initWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],temdic[@"fileHttpPath"]];
                
                MyimageModel *model = [[MyimageModel alloc] initWithFildID:FileID filePath:picpath data:array[i]];
                [dataArray addObject:model];
                
                FlyLog(@"i=%d \n %@",i,model);
                
            }else{
                errroStr = dic[@"msg"];
            }
            
            dispatch_group_leave(group);

            
        } failure:^(NSString *NetFailReason) {
            
            errroStr = NetFailReason;
            dispatch_group_leave(group);

        }];
        
    }
    
    
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        if ([errroStr isEqualToString:@""]) {//没有错误
            
            success(dataArray);
            
        }else{
            fail(errroStr);
        }
        
    });

    
}

@end
