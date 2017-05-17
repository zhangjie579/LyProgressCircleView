//
//  LyCircleImageView.m
//  ThreeSmallPlaces
//
//  Created by 张杰 on 2017/5/11.
//  Copyright © 2017年 liebe. All rights reserved.
//

#import "LyCircleImageView.h"

@interface LyCircleImageView ()

@property(nonatomic,strong)UIView *view_circle;

@end

@implementation LyCircleImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:216.0 / 255.0 green:216.0 / 255.0 blue:216.0 / 255.0 alpha:1.0];
        [self addSubview:self.view_circle];
    }
    return self;
}

- (void)setColorCenter:(UIColor *)colorCenter
{
    _colorCenter = colorCenter;
    
    self.view_circle.backgroundColor = colorCenter;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    [self.view_circle mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.mas_equalTo(self);
//        make.size.mas_equalTo(CGSizeMake(4, 4));
//    }];
    
    self.view_circle.frame = CGRectMake((self.frame.size.width - 4) / 2, (self.frame.size.height - 4) / 2, 4, 4);
}

- (UIView *)view_circle
{
    if (!_view_circle) {
        _view_circle = [[UIView alloc] init];
        _view_circle.layer.cornerRadius = 2;
        _view_circle.clipsToBounds = YES;
        _view_circle.backgroundColor = [UIColor colorWithRed:198.0 / 255.0 green:27.0 / 255.0 blue:27.0 / 255.0 alpha:1.0];
    }
    return _view_circle;
}

@end
