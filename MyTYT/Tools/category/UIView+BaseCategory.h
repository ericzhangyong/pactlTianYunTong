//
//  UIView+BaseCategory.h
//  FireStore
//
//  Created by eric on 2019/8/29.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, ExtendRegionType) {
    DefaultExtendRegion             =   0,
    ClickExtendRegion               =   1
};

@interface UIView (BaseCategory)




@property (nullable, nonatomic, readonly) UIViewController *base_viewController;


@property (nullable, nonatomic, readonly) UINavigationController *base_navViewController;



@property (nonatomic,retain) CALayer *zy_shadowLayer;


-(void)zy_setShadowColor:(UIColor *)shadowColor
            shadowOffset:(CGSize)shadowOffset
            shadowRadius:(CGFloat)shadowRadius
           shadowOpacity:(CGFloat)shadowOpacity;


//切某角
-(void)zy_adRectCorner:(UIRectCorner)rectCorner
           cornerRadii:(CGSize)cornerRadii;



@property (nonatomic, assign) ExtendRegionType extendRegionType;

@end

NS_ASSUME_NONNULL_END
