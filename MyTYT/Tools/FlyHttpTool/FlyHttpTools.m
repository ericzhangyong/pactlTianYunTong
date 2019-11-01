//
//  FlyHttpTools.m
//  BagInfomationEDI
//
//  Created by 张飞飞 on 17/3/3.
//  Copyright © 2017年 张飞飞. All rights reserved.
//

#import "FlyHttpTools.h"
#import "NSString+JM.h"
#import "MYTimer.h"
#import "MBProgressHUD+FLyHUD.h"

#define boundary @"----WebKitFormBoundary4zyzhAqcm2XA1lSY"

@interface FlyHttpTools ()<NSURLSessionDelegate>

@property (nonatomic) NSURLSession *sesstion;

@property (nonatomic) NSURLSessionDataTask *task;

@end

@implementation FlyHttpTools

+ (FlyHttpTools *)shareFlyHttp{
    static FlyHttpTools *flyhttp = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        flyhttp = [[self alloc] init];
    });
    return flyhttp;
}

- (NSURLSession *)sesstion{
    if (!_sesstion) {
      _sesstion =  [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return _sesstion;
}

//登录成功后会话失效机制,假设30分钟没走,会话有可能会失效，失效时走退出逻辑，提示失效,触发点在请求网络时会出现


#pragma mark------------------------------------------------------------------------------------
///登录接口
+ (void)postLoginWithjsonDic:(NSDictionary *)jsonDic
                   interface:(NSString *)interface
                     success:(FlySuccessBlock)success
                     failure:(FlyFailureBlock)failure{
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];
    
    request.timeoutInterval = 60;
    
    request.HTTPMethod = @"POST";
    
    NSString *sha1 = [jsonDic[@"password"] sha1];//密码经过SHA1编码
    
    FlyLog(@"%@",sha1);
    
    NSString *upStr = [[NSString alloc] initWithFormat:@"username=%@&password=%@&checkCode=%@",jsonDic[@"username"],sha1,jsonDic[@"checkCode"]];
    
    FlyLog(@"我发出的请求---%@",upStr);

    
    request.HTTPBody = [upStr dataUsingEncoding:NSUTF8StringEncoding];
    
    flyhttp.task = [flyhttp.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                failure([flyhttp MyExplainerror:error]);
            }else{
                
                FlyLog(@"repose---%@",response);

                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                FlyLog(@"服务器返回---%@",str);

                if ([str hasPrefix:@"<html>"]) {
                    failure(@"请求服务器失败,请稍后再试");
                    return ;
                }
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                success(dic);
            }
        });
   
    }];
    
    [flyhttp.task resume];
}

///验证码接口
+ (void)postYZMWithStr:(NSString *)str
             interface:(NSString *)interface
               success:(FlySuccessBlock)success
               failure:(FlyFailureBlock)failure{
    
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];
    
    request.timeoutInterval = 60;
    
    request.HTTPMethod = @"POST";
    
    request.HTTPBody = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    flyhttp.task = [flyhttp.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (error) {
                failure([flyhttp MyExplainerror:error]);
            }else{
                
                FlyLog(@"repose---%@",response);
                FlyLog(@"服务器返回---%@",str);

                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                if ([str hasPrefix:@"<html>"]) {
                    failure(@"请求服务器失败,请稍后再试");
                    return ;
                }else if ([str isEqualToString:@""]){
                    [MBProgressHUD showSuccessView:nil];

                    [[MYTimer shareINstace] endTimeWithType:TokenInValid];
                    return;
                }
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                success(dic);
            }
        });
        
    }];
    
    [flyhttp.task resume];
}


#pragma mark------------------------------------------------------------------------------------

+ (void)postWithJsonDic:(NSDictionary *)jsonDic
              interface:(NSString *)interface
                success:(FlySuccessBlock)success
                failure:(FlyFailureBlock)failure{
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];

    NSData *data = [NSJSONSerialization dataWithJSONObject:jsonDic options:NSJSONWritingPrettyPrinted error:nil];
 
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];

    request.HTTPMethod = @"POST";

    request.timeoutInterval = 60;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:MYCOOKE] forHTTPHeaderField:@"Cookie"];

    request.HTTPBody = data;
    
    NSString *str = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];

    FlyLog(@"我发出的请求---%@",str);
    flyhttp.task = [flyhttp.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
        
        if (error) {
            failure([flyhttp MyExplainerror:error]);
            FlyLog(@"服务器返回错误----%@",error);
        }else{
            
            NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            
            FlyLog(@"服务器返回------%@",str);
            
            if ([str hasPrefix:@"<html>"]) {
                failure(@"请求服务器失败,请稍后再试");
                return ;
            }else if ([str isEqualToString:@""]){
                [MBProgressHUD showSuccessView:nil];

                [[MYTimer shareINstace] endTimeWithType:TokenInValid];
                return;
            }
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];

            success(dic);
            
        }
            
            });
    }];
  
    [flyhttp.task resume];
    
    
}


+ (void)postWithStr:(NSString *)Str
          interface:(NSString *)interface
            success:(FlySuccessBlock)success
            failure:(FlyFailureBlock)failure{
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];
    
    request.HTTPMethod = @"POST";
    
    request.timeoutInterval = 60;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:MYCOOKE] forHTTPHeaderField:@"Cookie"];
    
    request.HTTPBody = [Str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *str = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    
    FlyLog(@"我发出的请求---%@",str);
    flyhttp.task = [flyhttp.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (error) {
                failure([flyhttp MyExplainerror:error]);
                FlyLog(@"服务器返回错误---%@",error);
            }else{
                
                
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                FlyLog(@"服务器返回----%@",str);

                if ([str hasPrefix:@"<html>"]) {
                    failure(@"请求服务器失败,请稍后再试");
                    return ;
                }else if ([str isEqualToString:@""]){
                    [MBProgressHUD showSuccessView:nil];

                    [[MYTimer shareINstace] endTimeWithType:TokenInValid];
                    return;
                }

                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                success(dic);
                
            }
            
        });
    }];
    
    [flyhttp.task resume];
    
}

+ (void)postWithArray:(NSArray *)array
            interface:(NSString *)interface
              success:(FlySuccessBlock)success
              failure:(FlyFailureBlock)failure{
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];
    
    request.HTTPMethod = @"POST";
    
    request.timeoutInterval = 60;
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:MYCOOKE] forHTTPHeaderField:@"Cookie"];
    
   NSData *data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPBody = data;
    
    NSString *str = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];
    
    FlyLog(@"我发出的请求---%@",str);
    flyhttp.task = [flyhttp.sesstion dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            if (error) {
                failure([flyhttp MyExplainerror:error]);
                FlyLog(@"服务器返回错误---%@",error);
            }else{
                
                
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                FlyLog(@"服务器返回----%@",str);

                if ([str hasPrefix:@"<html>"]) {
                    failure(@"请求服务器失败,请稍后再试");
                    return ;
                }else if ([str isEqualToString:@""]){
                    [MBProgressHUD showSuccessView:nil];

                    [[MYTimer shareINstace] endTimeWithType:TokenInValid];
                    return;
                }

                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                success(dic);
                
            }
            
        });
    }];
    
    [flyhttp.task resume];
}

//上传一张图片数据
+ (void)postWithPicData:(NSData *)picData
              interface:(NSString *)interface
                success:(FlySuccessBlock)success
                failure:(FlyFailureBlock)failure{
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] objectForKey:BaseUrlPath],interface]]];
    
    request.HTTPMethod = @"POST";
    
    request.timeoutInterval = 60;
    
    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:MYCOOKE] forHTTPHeaderField:@"Cookie"];
    
    NSString *ContentType = [NSString stringWithFormat:@"multipart/form-data; charest=utf-8;boundary=%@",boundary];
    
    [request setValue:ContentType forHTTPHeaderField:@"Content-Type"];
    
    NSData *mydata = [flyhttp bulidUpDataWithData:picData];
    
    [request setValue:[NSString stringWithFormat:@"%ld",(unsigned long)[mydata length]] forHTTPHeaderField:@"Content-Length"];
    
  NSURLSessionUploadTask *uptask = [flyhttp.sesstion uploadTaskWithRequest:request fromData:mydata completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
          
          
          if (error) {
              failure([flyhttp MyExplainerror:error]);
              FlyLog(@"服务器返回错误---%@",error);
          }else{
              
              NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
              FlyLog(@"服务器返回----%@",str);

              if ([str hasPrefix:@"<html>"]) {
                  failure(@"请求服务器失败,请稍后再试");
                  return ;
              }else if ([str isEqualToString:@""]){
                  [MBProgressHUD showSuccessView:nil];
                  [[MYTimer shareINstace] endTimeWithType:TokenInValid];
                  return;
              }
              NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
              
              success(dic);
              
          }
          
      });
    }];
    
    [uptask resume];


}
//构建上传图片数据
- (NSData *)bulidUpDataWithData:(NSData*)data{
    
    NSMutableString *bodystr = [NSMutableString string];
    
    [bodystr appendFormat:@"--%@\r\n",boundary];
    [bodystr appendFormat:@"Content-disposition: form-data; name=\"file\"; filename=\"file.jpeg\"\r\n"];
    [bodystr appendFormat:@"Content-Type: application/octet-stream"];
    [bodystr appendFormat:@"\r\n\r\n"];
    
    
    NSMutableData *mydata = [NSMutableData data];
    
    [mydata appendData:[bodystr dataUsingEncoding:NSUTF8StringEncoding]];
    
    [mydata appendData:data];
    
    NSString *endstr = [NSString stringWithFormat:@"\r\n--%@--\r\n",boundary];

    [mydata appendData:[endstr dataUsingEncoding:NSUTF8StringEncoding]];
    
    return mydata;

}

#pragma mark------------------------------------------------------------------------------------
+ (void)canceltask{
    
    FlyHttpTools *flyhttp = [FlyHttpTools shareFlyHttp];
    [flyhttp.task cancel];
}



- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    //    NSLog(@"didReceiveChallenge");
    //    NSLog(@"%@", challenge.protectionSpace.authenticationMethod);
    
    // 1.从服务器返回的受保护空间中拿到证书的类型
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"是服务器信任的证书");
        // 3.根据服务器返回的受保护空间创建一个证书
        //         void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *)
        //         代理方法的completionHandler block接收两个参数:
        //         第一个参数: 代表如何处理证书
        //         第二个参数: 代表需要处理哪个证书
        //创建证书
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //4.安装证书
        completionHandler(NSURLSessionAuthChallengeUseCredential , credential);
    }
}

#pragma mark------------------------------------------------------------------------------------

- (NSString *)MyExplainerror:(NSError *)error{
    
    if (error.code == NSURLErrorNotConnectedToInternet) {
        return @"请检查网络设置";
    }else if (error.code == NSURLErrorTimedOut){
        return @"当前网络不佳,请稍后再试";
    }else{
        return @"未知错误";
    }
}



@end
