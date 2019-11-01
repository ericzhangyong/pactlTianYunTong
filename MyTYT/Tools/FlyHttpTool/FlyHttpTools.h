//
//  FlyHttpTools.h
//  BagInfomationEDI
//
//  Created by 张飞飞 on 17/3/3.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^FlySuccessBlock)(NSDictionary *dic);

typedef void(^FlyFailureBlock)(NSString *NetFailReason);

@interface FlyHttpTools : NSObject

/*
登录接口
*/

+ (void)postLoginWithjsonDic:(NSDictionary *)jsonDic
                   interface:(NSString *)interface
                     success:(FlySuccessBlock)success
                     failure:(FlyFailureBlock)failure;

/*
 获取最新验证码
 */
+ (void)postYZMWithStr:(NSString *)str
             interface:(NSString *)interface
                   success:(FlySuccessBlock)success
                   failure:(FlyFailureBlock)failure;


/*
 接口
 1 json格式
 2 字符串格式
 3 数组格式
 4以下接口均需要cooke
 */

+ (void)postWithJsonDic:(NSDictionary *)jsonDic
              interface:(NSString *)interface
                success:(FlySuccessBlock)success
                failure:(FlyFailureBlock)failure;

+ (void)postWithStr:(NSString *)Str
              interface:(NSString *)interface
                success:(FlySuccessBlock)success
                failure:(FlyFailureBlock)failure;


+ (void)postWithArray:(NSArray *)array
          interface:(NSString *)interface
            success:(FlySuccessBlock)success
            failure:(FlyFailureBlock)failure;



//上传一张图片数据
+ (void)postWithPicData:(NSData *)picData
              interface:(NSString *)interface
                success:(FlySuccessBlock)success
                failure:(FlyFailureBlock)failure;


+ (void)canceltask;



@end
