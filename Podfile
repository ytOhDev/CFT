# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FittersTimer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  
  

  source 'https://github.com/CocoaPods/Specs.git'
  platform :ios, '9.0'
  use_frameworks!
  
  pod "PagingMenuController"
  
  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '3.0'
      end
    end
  end

  # Pods for FittersTimer

end
