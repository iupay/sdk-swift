#
# Be sure to run `pod lib lint SuperDDAIuPay.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SuperDDAIuPay'
  s.version          = '1.0.1'
  s.summary          = 'UILibrary for IuPay DDA'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  UILibrary for IuPay DDA containing all UI components ready to be used
                       DESC

  s.homepage         = 'https://github.com/lucianobohrer/superdda-iupay'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'lucianobohrer' => 'luciano@kodemy.dev' }
  s.source           = { :git => 'https://github.com/lucianobohrer/superdda-iupay.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/lucianobohrer/'

  s.ios.deployment_target = '11.4'
  s.swift_versions = '5.0'
  s.dependency 'Valley'
  s.dependency 'Material'
  s.dependency 'SweeterSwift'
  s.source_files  = 'SuperDDAIuPay/Source/**/*'
  s.resources = 'SuperDDAIuPay/**/*.{lproj,storyboard,xcdatamodeld,xib,xcassets,json,ttf, png}'

  s.resource_bundles = {
    'SuperDDAIuPay' => ['SuperDDAIuPay/Assets/**/*']
  }
   
  # s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'UIKit'
end
