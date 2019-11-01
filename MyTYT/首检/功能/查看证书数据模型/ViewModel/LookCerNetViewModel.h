//
//  LookCerNetViewModel.h
//  MyTYT
//
//  Created by Fly on 2018/5/12.
//  Copyright © 2018年 上海易迪爱网络工程有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PDFImageModel;

typedef void(^getPdfStartBlock)(void);
typedef void(^GetPDFSuccessBlodk)(PDFImageModel *Pdfmodel);
typedef void(^GetPDFFailBlock)(NSString *failStr);

@interface LookCerNetViewModel : NSObject

//查看证书
- (void)RequestCerImageArrayWithBookID:(NSString *)BookID
                                start:(getPdfStartBlock)start
                              Success:(GetPDFSuccessBlodk)success
                                 fail:(GetPDFFailBlock)fail;

@end
