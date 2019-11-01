//
//  AddMyBzViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddBZALlModel;
@class BZModle;
@class BZAddModel;
@class AddBZDataManager;
@class MyimageModel;

typedef void(^LoadBZDetailBlock)(AddBZALlModel *allmodel);
typedef void(^LoadBZDetailFailBlock)(NSString *fail);


typedef void(^OperationBZStartBlock)(void);
typedef void(^OpeartionBZSuccessBlock)(NSString *Str);
typedef void(^OperationBZFailBlock)(NSString *fail);

typedef void(^UpPicSuccess)(NSString *FilID,NSString *picPath);

typedef void(^UpMoreSuccess)(NSArray<MyimageModel *> *array);

@interface AddMyBzViewModel : NSObject

//加载备注信息
- (void)loadBZDataWithaWID:(NSString *)awID
                      view:(UIView *)superView
                   success:(LoadBZDetailBlock)success
                      fail:(LoadBZDetailFailBlock)fail;


//删除备注
- (void)deleteBZWithModel:(BZModle *)model
                    start:(OperationBZStartBlock)start
                  success:(OpeartionBZSuccessBlock)success
                     fail:(OperationBZFailBlock)fail;

//编辑备注
- (void)editBZWithModel:(BZModle *)model
                   text:(NSString *)text
                  start:(OperationBZStartBlock)start
                success:(OpeartionBZSuccessBlock)success
                   fail:(OperationBZFailBlock)fail;

//上传图片
- (void)upPicDataWith:(NSData *)picData
                start:(OperationBZStartBlock)start
              success:(UpPicSuccess)success
                 fail:(OperationBZFailBlock)fail;

//添加备注
- (void)AddBZWithaWID:(NSString *)aWID
               machID:(NSString *)machID
           dataManger:(AddBZDataManager *)DataManger
                start:(OperationBZStartBlock)start
              success:(OpeartionBZSuccessBlock)success
                 fail:(OperationBZFailBlock)fail;


//上传多张照片
- (void)upMorePicDataWithArray:(NSArray *)array
                         start:(OperationBZStartBlock)start
                       success:(UpMoreSuccess)success
                          fail:(OperationBZFailBlock)fail;



@end
