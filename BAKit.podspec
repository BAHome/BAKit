Pod::Spec.new do |s|
    s.name         = "BAKit"
    s.version      = "0.0.4"
    s.summary      = 'BAKit by boai.'
    s.homepage     = "https://gitee.com/dsteam/BAKit.git"

#s.homepage     = "https://github.com/boai/BAKit.git"
    s.license      = { :type => 'MIT', :file => 'LICENSE' }
    s.authors      = { "boai" => "sunboyan@outlook.com" }
    s.social_media_url   = "http://weibo.com/538298123"
    s.homepage     = 'https://github.com/boai/BAKit.git'
    s.platform     = :ios, "9.0"
    s.source       = { :git => "https://gitee.com/dsteam/BAKit.git", :tag => s.version.to_s }

    s.requires_arc = true
    s.source_files = "BAKit/BAKit/*.{h,m}"
    s.frameworks   = 'UIKit'

    s.dependency   "SDWebImage"
    s.dependency   "BAButton"
    s.dependency   "BAAlert"
    s.dependency   "BAGridView"
    s.dependency   "BAAlertController"

    s.dependency   "BATextField"
    s.dependency   "BATextView"


end
