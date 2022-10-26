#encoding:utf-8
# Be sure to run `pod lib lint'
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html

Pod::Spec.new do |s|
  s.name = "RXExts"
  s.version = "0.1.0"
  s.summary = "RXExts."

  s.description = <<-DESC
基于RxSwift处理拓展。
DESC

  s.homepage = "https://github.com/yaochenfeng/#{s.name}"
  s.source           = { :git => "https://github.com/yaochenfeng/#{s.name}.git", :tag => s.version.to_s }
  s.license = {
    :type => "MIT",
    :text => <<-LICENSE,
copyright MIT
LICENSE
  }
  s.author = { "yaochenfeng" => "282696845@qq.com" }
  s.platform = :ios, "10.0"
  s.swift_version = "5.4"
  s.source_files = "Sources/#{s.name}/**/*.swift"
  s.dependency "Logging", "~> 1.0"
  s.dependency "RxCocoa", "~> 6.0"
  s.dependency "SnapKit", "~> 5.0"
  s.weak_framework = 'swiftUI'
end
