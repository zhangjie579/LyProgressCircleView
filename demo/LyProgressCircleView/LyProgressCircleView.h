//
//  LyProgressCircleView.h
//  01-进度条Progress
//
//  Created by 张杰 on 2017/5/11.
//  Copyright © 2017年 张杰. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LyProgressCircleConfig;

@interface LyProgressCircleView : UIView

@property(nonatomic,assign)CGFloat progress;//进度

- (void)updateConfig:(void(^)(LyProgressCircleConfig *config))config;//配置属性

/* 例子
 LyProgressCircleView *circle = [[LyProgressCircleView alloc] initWithFrame:CGRectMake(100, 100, 110, 88)];
 circle.frame = CGRectMake(100, 100, 200, 200);
 [circle updateConfig:^(LyProgressCircleConfig *config) {
 config.startAngles(0).endAngles(M_PI * 2);
 }];
 circle.backgroundColor = [UIColor redColor];
 [self.view addSubview:circle];
 
 circle.progress = 0.3;
 */

@end

@interface LyProgressCircleConfig : NSObject

@property(nonatomic,strong)UIColor *backgroundCircleColor;//背景圆环的颜色
@property(nonatomic,strong)UIColor *progressCircleColor;//进度圆环的颜色
@property(nonatomic,assign)CGFloat width;//圆环宽度
@property(nonatomic,assign)CGFloat startAngle;//开始角度
@property(nonatomic,assign)CGFloat endAngle;//结束角度
@property(nonatomic,strong)UIColor *colorCenter;//圆点的颜色
@property(nonatomic,strong)UIColor *textColor;//进度文件的颜色
@property(nonatomic,strong)UIFont  *font;//字体大小
@property(nonatomic,assign)BOOL    animated;//是否动画
@property(nonatomic,assign)BOOL    containStartPoint;//是否包含开始点
@property(nonatomic,assign)BOOL    containEndPoint;//是否包含结束点

+ (instancetype)defaultConfig;

- (LyProgressCircleConfig *(^)(UIColor *backgroundCircleColor))bgColor;
- (LyProgressCircleConfig *(^)(UIColor *progressCircleColor))pgColor;
- (LyProgressCircleConfig *(^)(CGFloat width))widths;
- (LyProgressCircleConfig *(^)(CGFloat startAngle))startAngles;
- (LyProgressCircleConfig *(^)(CGFloat endAngle))endAngles;
- (LyProgressCircleConfig *(^)(UIColor *colorCenter))colorCenters;
- (LyProgressCircleConfig *(^)(BOOL animate))animate;
- (LyProgressCircleConfig *(^)(UIColor *textColor))textColors;
- (LyProgressCircleConfig *(^)(UIFont *font))fonts;
- (LyProgressCircleConfig *(^)(BOOL containStartPoint))containStartPoints;
- (LyProgressCircleConfig *(^)(BOOL containEndPoint))containEndPoints;
@end
