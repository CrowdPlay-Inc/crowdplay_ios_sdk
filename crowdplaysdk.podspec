#
# Be sure to run `pod lib lint crowdplaysdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'crowdplaysdk'
  s.version          = '0.1.18'
  s.summary          = 'A short description of crowdplaysdk.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/takaoandrew/crowdplay_ios_sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Crowdplay' => 'support@crowdplayapp.com' }
  s.source           = { :git => 'git@github.com:takaoandrew/crowdplay_ios_sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'crowdplaysdk/Classes/**/*'
  
  s.ios.frameworks  = 'UIKit'

  s.dependency 'Firebase', '8.6.0'
  s.dependency 'FirebaseAuth', '8.6.0'
  s.dependency 'FirebaseCore', '8.6.0'
  s.dependency 'FirebaseCoreDiagnostics', '8.15.0'
  s.dependency 'FirebaseDatabase', '8.6.0'
  s.dependency 'FirebaseInstallations', '8.15.0'
  s.dependency 'FirebaseMessaging', '8.6.0'
  s.dependency 'FirebaseStorage', '8.6.0'
  s.dependency 'GTMSessionFetcher', '1.7.2'
  s.dependency 'GoogleDataTransport', '9.2.0'
  s.dependency 'GoogleUtilities', '7.8.0'
  s.dependency 'MTBBarcodeScanner', '5.0.11'
  s.dependency 'PromisesObjC', '2.1.1'
  s.dependency 'Reachability', '3.2'

  s.ios.vendored_frameworks = 'Frameworks/App.xcframework',  'Frameworks/image_picker_ios.xcframework', 'Frameworks/qr_code_scanner.xcframework', 'Frameworks/firebase_auth.xcframework', 'Frameworks/image_picker.xcframework', 'Frameworks/share.xcframework', 'Frameworks/FBLPromises.xcframework', 'Frameworks/firebase_core.xcframework', 'Frameworks/store_redirect.xcframework', 'Frameworks/firebase_database.xcframework', 'Frameworks/location.xcframework', 'Frameworks/uni_links.xcframework', 'Frameworks/Flutter.xcframework', 'Frameworks/audioplayers.xcframework', 'Frameworks/firebase_messaging.xcframework', 'Frameworks/url_launcher_ios.xcframework', 'Frameworks/FlutterPluginRegistrant.xcframework', 'Frameworks/connectivity.xcframework', 'Frameworks/firebase_storage.xcframework', 'Frameworks/package_info.xcframework', 'Frameworks/video_player.xcframework', 'Frameworks/device_info.xcframework', 'Frameworks/flutter_local_notifications.xcframework', 'Frameworks/path_provider_ios.xcframework'
  s.preserve_path = 'Frameworks/*'
end
