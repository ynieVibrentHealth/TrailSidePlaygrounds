# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'
source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

def shared_pods
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'SnapKit'
    pod 'Alamofire'
    pod 'Kingfisher'
end

def testing_pods
    pod 'Quick'
    pod 'Nimble'
end

target 'TrailsidePlayground' do
  shared_pods
end

target 'TrailsidePlaygroundTests' do
  shared_pods
  testing_pods
end

target 'TrailsidePlaygroundUITests' do
  shared_pods
  testing_pods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.name == "Debug" && defined?(target.product_type) && target.product_type == "com.apple.product-type.framework"
        config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = "YES"
      end
      config.build_settings['OTHER_SWIFT_FLAGS'] = "-Xfrontend -warn-long-function-bodies=100 -Xfrontend -warn-long-expression-type-checking=100"
    end
  end
end
