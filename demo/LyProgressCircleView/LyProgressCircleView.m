//
//  LyProgressCircleView.m
//  01-进度条Progress
//
//  Created by 张杰 on 2017/5/11.
//  Copyright © 2017年 张杰. All rights reserved.
//

#import "LyProgressCircleView.h"
#import "LyCircleImageView.h"

@interface LyProgressCircleView ()

@property(nonatomic,strong)CAShapeLayer             *backgroundShapeLayer;//背景
@property(nonatomic,strong)CAShapeLayer             *progressShapeLayer;//进度
@property(nonatomic,strong)LyCircleImageView        *image_start;//开始圆点
@property(nonatomic,strong)LyCircleImageView        *image_end;//结束圆点
@property(nonatomic,strong)UILabel                  *label;
@property(nonatomic,assign)CGFloat                  startProgress;//进度
@property(nonatomic,strong)NSTimer                  *timer;

@property(nonatomic,strong)LyProgressCircleConfig   *config;//配置

@end

@implementation LyProgressCircleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.progress = 0.0;
        [self addSubview:self.label];
        [self.layer addSublayer:self.backgroundShapeLayer];
        [self.layer addSublayer:self.progressShapeLayer];
        [self addSubview:self.image_start];
        [self addSubview:self.image_end];
    }
    return self;
}

- (void)updateConfig:(void (^)(LyProgressCircleConfig *))config
{
    if (config) {
        config(self.config);
    }
    
    //圆环的配置
    self.backgroundShapeLayer.strokeColor = self.config.backgroundCircleColor.CGColor;
    self.progressShapeLayer.strokeColor = self.config.progressCircleColor.CGColor;
    self.backgroundShapeLayer.lineWidth = self.config.width;
    self.progressShapeLayer.lineWidth = self.config.width;
    
    //圆心的颜色
    self.image_start.colorCenter = self.config.colorCenter;
    self.image_end.colorCenter = self.config.colorCenter;
    
    //圆角
    self.image_start.layer.cornerRadius = self.config.width / 2;
    self.image_end.layer.cornerRadius = self.config.width / 2;
    
    //文本配置
    self.label.textColor = self.config.textColor;
    self.label.font = self.config.font;
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)dealloc
{
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    if (self.config.animated)//动画
    {
        self.startProgress = 0;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(next:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [self setupProgressWithEndAngle:(self.config.endAngle - self.config.startAngle) * self.progress + self.config.startAngle];
    }
    
    self.label.text = [NSString stringWithFormat:@"%ld%@",(NSInteger)(progress * 100),@"%"];
    
}

- (void)next:(NSTimer *)timer
{
    if (self.startProgress >= self.progress)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        self.startProgress = self.startProgress + self.progress / 10;
        
        //进度结束的角度
        CGFloat endAngle = (self.config.endAngle - self.config.startAngle) * self.startProgress + self.config.startAngle;
        
        [self setupProgressWithEndAngle:endAngle];
    }
}

- (void)setupProgressWithEndAngle:(CGFloat)endAngle
{
    CGFloat w = self.frame.size.width / 2;
    CGPoint arcCenter = CGPointMake(w, w);
    CGFloat radius = (self.frame.size.width - self.config.width) / 2;
    
//    CGFloat endAngle = (self.config.endAngle - self.config.startAngle) * self.progress + self.config.startAngle;
    
    //1.进度圆环
    UIBezierPath *path_progress = [self addBackground:arcCenter radius:radius startAngle:self.config.startAngle endAngle:endAngle];
    self.progressShapeLayer.path = path_progress.CGPath;
    
    //2.结束点
    if (self.config.containEndPoint) {
        CGFloat endX = arcCenter.x + radius * cos((self.config.startAngle + (endAngle - self.config.startAngle))) - self.config.width / 2;
        CGFloat endY = arcCenter.y + radius * sin((self.config.startAngle + (endAngle - self.config.startAngle))) - self.config.width / 2;
        self.image_end.frame = CGRectMake(endX, endY, self.config.width, self.config.width);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //0.求圆心和半径,以view的width的一半为半径,圆心不一定在中心
    CGPoint arcCenter = CGPointMake(self.frame.size.width / 2, self.frame.size.width / 2);
    CGFloat radius = (self.frame.size.width - self.config.width) / 2;
    
    //1.label
    self.label.bounds = CGRectMake(0, 0, self.frame.size.width / 2, self.frame.size.height / 2);
    self.label.center = arcCenter;
    
    //2.背景圆环
    UIBezierPath *path = [self addBackground:arcCenter radius:radius startAngle:self.config.startAngle endAngle:self.config.endAngle];
    self.backgroundShapeLayer.path = path.CGPath;

    //3.开始点
    if (self.config.containStartPoint) {
        CGFloat beginX = arcCenter.x + radius * cos((self.config.startAngle)) - self.config.width / 2;
        CGFloat beginY = arcCenter.y + radius * sin((self.config.startAngle)) - self.config.width / 2;
        self.image_start.frame = CGRectMake(beginX, beginY, self.config.width, self.config.width);
    }
    
}

- (UIBezierPath *)addBackground:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle
{
    //路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    //    [path closePath];
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    return path;
}

#pragma mark - get
- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (LyCircleImageView *)image_start
{
    if (!_image_start) {
        _image_start = [[LyCircleImageView alloc] init];
        _image_start.clipsToBounds = YES;
    }
    return _image_start;
}

- (LyCircleImageView *)image_end
{
    if (!_image_end) {
        _image_end = [[LyCircleImageView alloc] init];
        _image_end.clipsToBounds = YES;
    }
    return _image_end;
}

- (CAShapeLayer *)backgroundShapeLayer
{
    if (!_backgroundShapeLayer) {
        
        _backgroundShapeLayer = [CAShapeLayer layer];
        _backgroundShapeLayer.fillColor = [UIColor clearColor].CGColor;
        //边缘线的类型
        _backgroundShapeLayer.lineCap = kCALineCapRound;
        _backgroundShapeLayer.lineJoin = kCALineJoinRound;
//        _backgroundShapeLayer.path = path.CGPath;
//        _backgroundShapeLayer.strokeColor = [UIColor colorWithRed:198.0 / 255.0 green:27.0 / 255.0 blue:27.0 / 255.0 alpha:1.0].CGColor;
//        _backgroundShapeLayer.lineWidth = 10;
    }
    return _backgroundShapeLayer;
}

- (CAShapeLayer *)progressShapeLayer
{
    if (!_progressShapeLayer) {
        
        _progressShapeLayer = [CAShapeLayer layer];
        _progressShapeLayer.fillColor = [UIColor clearColor].CGColor;
        //边缘线的类型
        _progressShapeLayer.lineCap = kCALineCapRound;
        _progressShapeLayer.lineJoin = kCALineJoinRound;
    }
    return _progressShapeLayer;
}

- (LyProgressCircleConfig *)config
{
    if (!_config) {
        _config = [LyProgressCircleConfig defaultConfig];
    }
    return _config;
}

@end

@interface LyProgressCircleConfig ()

@end

@implementation LyProgressCircleConfig

+ (instancetype)defaultConfig
{
    LyProgressCircleConfig *config = [[LyProgressCircleConfig alloc] init];
    
    return config;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.progressCircleColor = [UIColor colorWithRed:242.0 / 255.0 green:242.0 / 255.0 blue:242.0 / 255.0 alpha:1.0];
        self.backgroundCircleColor = [UIColor colorWithRed:198.0 / 255.0 green:27.0 / 255.0 blue:27.0 / 255.0 alpha:1.0];
        self.width = 10;
        self.startAngle = -M_PI - 3.0 / 5.0;
        self.endAngle = 3.0 / 5.0;
        self.colorCenter = [UIColor redColor];
        self.textColor = [UIColor colorWithRed:171.0 / 255.0 green:0 blue:0 alpha:1.0];
        self.font = [UIFont systemFontOfSize:18];
        self.animated = YES;
        self.containStartPoint = YES;
        self.containEndPoint = YES;
    }
    return self;
}

- (LyProgressCircleConfig *(^)(UIColor *))pgColor
{
    return ^(UIColor *color){
        self.progressCircleColor = color;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(UIColor *))bgColor
{
    return ^(UIColor *color){
        self.backgroundCircleColor = color;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(CGFloat))widths
{
    return ^(CGFloat width){
        self.width = width;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(CGFloat))startAngles
{
    return ^(CGFloat startAngle){
        self.startAngle = startAngle;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(CGFloat))endAngles
{
    return ^(CGFloat endAngles){
        self.endAngle = endAngles;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(UIColor *))colorCenters
{
    return ^(UIColor *color){
        self.colorCenter = color;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(BOOL ))animate
{
    return ^(BOOL animate){
        self.animated = animate;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(UIColor *textColor))textColors
{
    return ^(UIColor *color){
        self.textColor = color;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(UIFont *font))fonts
{
    return ^(UIFont *font){
        self.font = font;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(BOOL containStartPoint))containStartPoints
{
    return ^(BOOL containStartPoint){
        self.containStartPoint = containStartPoint;
        return self;
    };
}

- (LyProgressCircleConfig *(^)(BOOL containEndPoint))containEndPoints
{
    return ^(BOOL containEndPoint){
        self.containEndPoint = containEndPoint;
        return self;
    };
}

@end
