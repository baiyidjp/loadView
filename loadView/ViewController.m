//
//  ViewController.m
//  loadView
//
//  Created by Keep丶Dream on 17/1/10.
//  Copyright © 2017年 dong. All rights reserved.
//

#import "ViewController.h"
#import "JPLoadviewHUD.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *backView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (IBAction)show:(id)sender {
    
    [JPLoadviewHUD showLoadHUDWithView:self.backView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [JPLoadviewHUD dismissLoadHUD];
    });
}
- (IBAction)dismiss:(id)sender {
    [JPLoadviewHUD dismissLoadHUD];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
