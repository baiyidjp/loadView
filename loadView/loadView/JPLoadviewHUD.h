//
//  JPLoadview.h
//  loadView
//
//  Created by Keep丶Dream on 17/1/10.
//  Copyright © 2017年 dong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JPLoadviewHUD : UIVisualEffectView

/**
 显示load

 @param backView 传入一个要显示load的View 传入nil 显示在window上
 */
+(void)showLoadHUDWithView:(UIView *)backView;

/**
 隐藏load
 */
+(void)dismissLoadHUD;


@end
