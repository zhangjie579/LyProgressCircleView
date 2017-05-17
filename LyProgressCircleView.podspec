Pod::Spec.new do |s|
s.name         = 'LyProgressCircleView'
s.version      = ‘0.0.1'
s.summary      = '圆环进度条'
s.homepage     = 'https://github.com/zhangjie579/LyProgressCircleView'
#s.license      = 'MIT'
s.license      = { :type => "MIT", :file => "LICENSE" }
s.platform     = :ios
s.author       = {'zhangjie' => '527512749@qq.com'}
s.ios.deployment_target = '7.0'
s.source       = {:git => 'https://github.com/zhangjie579/LyProgressCircleView.git', :tag => s.version}
#这个是相对路径。相对于podspec文件
s.source_files = 'demo/LyProgressCircleView/*.{h,m}'
s.requires_arc = true
s.frameworks   = 'UIKit'
end
