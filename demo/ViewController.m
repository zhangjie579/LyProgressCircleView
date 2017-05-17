//
//  ViewController.m
//  demo
//
//  Created by 张杰 on 2017/5/17.
//  Copyright © 2017年 张杰. All rights reserved.
//

#import "ViewController.h"
#import "LyProgressCircleView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    LyProgressCircleView *circle = [[LyProgressCircleView alloc] initWithFrame:CGRectMake(100, 100, 110, 88)];
//    circle.frame = CGRectMake(100, 100, 200, 200);
    [circle updateConfig:^(LyProgressCircleConfig *config) {
        config.startAngles(0).endAngles(M_PI * 2).containStartPoints(NO).containEndPoints(YES);
    }];
    circle.backgroundColor = [UIColor redColor];
    [self.view addSubview:circle];
    
    circle.progress = 0.3;
    
}


@end
