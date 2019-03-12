#
# Be sure to run `pod lib lint BAKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BAKit'
  s.version          = '0.0.5'
  s.summary          = 'A short description of BAKit.'
  s.description      = <<-DESC
                        this is BAKit
                       DESC

  s.homepage         = 'https://github.com/BAHome/BAKit'
  
  # https://gitee.com/dsteam/BAKit.git
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'boai' => 'sunboyan@outlook.com' }
  # s.source           = { :git => 'https://github.com/BAHome/BAKit.git', :tag => s.version.to_s }
  s.source           = { :git => 'https://gitee.com/dsteam/BAKit.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.requires_arc = true

  
  # s.resource_bundles = {
  #   'BAKit' => ['BAKit/Assets/*.png']
  # }
  
    s.dependency 'BAButton'
    s.dependency 'BAAlert'
    s.dependency 'BAGridView'
    s.dependency 'BAAlertController'
    s.dependency 'BATextField'
    s.dependency 'BATextView'
    s.dependency 'ReactiveObjC'
    s.dependency 'OOMDetector'
    s.dependency 'MGJRouter'
    s.dependency 'MJExtension'
    s.dependency 'SVProgressHUD'    
  
    s.frameworks = 'UIKit', 'Foundation'
    s.prefix_header_contents =
    '#import <UIKit/UIKit.h>',
    '#import <Foundation/Foundation.h>',
    '#import <BAButton/BAButton.h>',
    '#import <BAAlert/BAAlert_OC.h>',
    '#import <BATextView/BATextView.h>',
    '#import "BATextField.h"',
    '#import "BAKit_BAGridView.h"',
    '#import "BAKit.h"'
    
    s.source_files = 'BAKit/Classes/**/*.{h,m}'
    s.public_header_files = 'Pod/Classes/**/*.h'





    


end
