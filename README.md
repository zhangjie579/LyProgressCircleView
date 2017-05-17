# LyProgressCircleView
进度圆环封装
```
pod 'LyProgressCircleView'
```

demo
```
LyProgressCircleView *circle = [[LyProgressCircleView alloc] init];
circle.frame = CGRectMake(100, 100, 200, 200);
[circle updateConfig:^(LyProgressCircleConfig *config) {
    config.startAngles(0).endAngles(M_PI * 2).containStartPoints(NO).containEndPoints(YES);
}];
circle.backgroundColor = [UIColor redColor];
[self.view addSubview:circle];

circle.progress = 0.3;
```
