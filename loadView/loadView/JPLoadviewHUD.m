//
//  JPLoadview.m
//  loadView
//
//  Created by Keep丶Dream on 17/1/10.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "JPLoadviewHUD.h"

static CGFloat imageW = 200;

@interface JPLoadviewHUD ()
/** timer */
@property(nonatomic,strong) NSTimer *timer;
/** count */
@property(nonatomic,assign) NSInteger timeCount;
/** topview */
@property(nonatomic,strong) UIView *topImage;
@end

@implementation JPLoadviewHUD
{
    UIView *_backImage;
}
+ (JPLoadviewHUD*)sharedHUD {
    static dispatch_once_t once;
    static JPLoadviewHUD *sharedHUD;
    dispatch_once(&once, ^{
        sharedHUD = [[self alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular]];
    });
    return sharedHUD;
}

- (instancetype)initWithEffect:(UIVisualEffect *)effect {
    
    self = [super initWithEffect:effect];
    if (self) {
        
        _backImage = [self createStarViewWithImage:@"hello"];
        self.topImage = [self createStarViewWithImage:@"hello1"];
        [self addSubview:_backImage];
        [self addSubview:_topImage];
    }
    return self;
}

- (UIView *)createStarViewWithImage:(NSString *)imageName {
    
    UIView *view = [[UIView alloc] init];
    view.clipsToBounds = YES;
    view.backgroundColor = [UIColor clearColor];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:imageName]];
    imageView.frame = CGRectMake(0,0, imageW, imageW);
    [view addSubview:imageView];
    return view;
}

+ (void)showLoadHUDWithView:(UIView *)backView {
    
    JPLoadviewHUD *hud = [JPLoadviewHUD sharedHUD];
    if (backView) {
        [backView addSubview:hud];
        hud.frame = backView.bounds;
    }else {
        UIWindow *window = UIApplication.sharedApplication.keyWindow;
        [window addSubview:hud];
        hud.frame = UIScreen.mainScreen.bounds;
    }
    
    hud.alpha = 0.0;
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 1.0;
    } completion:^(BOOL finished) {
        [hud startAnimation];
    }];
    
}

+ (void)dismissLoadHUD {

    JPLoadviewHUD *hud = [JPLoadviewHUD sharedHUD];
    
    [hud.timer invalidate];
    hud.timeCount = 0;
    hud.topImage.frame = CGRectMake(hud.bounds.size.width/2.0-imageW/2.0, hud.bounds.size.height/2.0-imageW/2.0, 0, imageW);
    [UIView animateWithDuration:0.3 animations:^{
        hud.alpha = 0;
    } completion:^(BOOL finished) {
        [hud removeFromSuperview];
    }];

}

- (void)startAnimation {
    
    self.topImage.frame = CGRectMake(self.bounds.size.width/2.0-imageW/2.0, self.bounds.size.height/2.0-imageW/2.0, imageW, 0);
    _backImage.frame = CGRectMake(self.bounds.size.width/2.0-imageW/2.0, self.bounds.size.height/2.0-imageW/2.0, imageW, imageW);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (void)changeImage {
    
    NSInteger count = self.timeCount % 8;
    CGFloat count1 = count / 8.0 + 1/8.0;
    NSLog(@"%f",count1);
    CGFloat topImageW = imageW*count1;
    [UIView animateWithDuration:0.3 animations:^{
        _topImage.frame = CGRectMake(self.bounds.size.width/2.0-imageW/2.0, self.bounds.size.height/2.0-imageW/2.0, imageW, topImageW);
    } completion:^(BOOL finished) {
        
        if (count1 == 1) {
            _topImage.frame = CGRectMake(self.bounds.size.width/2.0-imageW/2.0, self.bounds.size.height/2.0-imageW/2.0, imageW, 0);
        }
    }];
    self.timeCount++;
}

@end
