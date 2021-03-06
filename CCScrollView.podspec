

Pod::Spec.new do |s|
s.name             = "CCScrollView"
s.version          = "0.0.3"
s.summary          = "CCScrollView是一个轮播图，支持手动滑动，定时器滑动，复用性强"

s.homepage         = "https://github.com/ajiao-github/CCycleScrollView"
s.license          = 'MIT'
s.author           = "ajiao-github"
s.source           = { :git => "https://github.com/ajiao-github/CCycleScrollView.git", :tag => "0.0.3" }

s.platform     = :ios, '7.0'
s.requires_arc = true

s.source_files = "CCScrollView/Lib/**/*"

s.frameworks = 'UIKit'
s.dependency "SDWebImage", "~> 4.4.2"
end
