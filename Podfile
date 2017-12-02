# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Mobi' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Mobi

    pod 'Alamofire', '~> 4.5'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'AlamofireImage'
    
    pod 'EZSwiftExtensions'
    pod 'ALCameraViewController', '~> 2.0.3'
    pod 'Google-Mobile-Ads-SDK'
    pod 'SwiftOverlays', '~> 3.0.0'
    pod 'PopupDialog', '~> 0.5'
    pod 'REFrostedViewController', '~> 2.4'
    pod 'Toast-Swift', '~> 2.0.0'
    pod 'MBProgressHUD', '~> 1.0.0'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.0'
            end
        end
    end


  target 'MobiTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
