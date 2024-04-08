#
# Be sure to run `pod lib lint crowdplaysdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'crowdplaysdk'
  s.version          = '0.1.59'
  s.summary          = 'A short description of crowdplaysdk.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/CrowdPlay-Inc/crowdplay_ios_sdk'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Crowdplay' => 'support@crowdplayapp.com' }
  s.source           = { :git => 'git@github.com:CrowdPlay-Inc/crowdplay_ios_sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'crowdplaysdk/Classes/**/*'
  s.swift_version = '5.0'
  
  s.ios.frameworks  = 'UIKit'
  
  s.dependency 'GoogleUtilities', '~> 7.8.0'
  s.dependency 'GoogleDataTransport', '~> 9.2.0'

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS' => 'armv7' }

  s.ios.vendored_frameworks = 'Frameworks/App.xcframework', 'Frameworks/audioplayers_darwin.xcframework', 'Frameworks/device_info_plus.xcframework', 'Frameworks/FirebaseAppCheckInterop.xcframework', 'Frameworks/FirebaseAuth.xcframework', 'Frameworks/FirebaseAuthInterop.xcframework', 'Frameworks/FirebaseCore.xcframework', 'Frameworks/FirebaseCoreExtension.xcframework', 'Frameworks/FirebaseCoreInternal.xcframework', 'Frameworks/FirebaseDatabase.xcframework', 'Frameworks/FirebaseInstallations.xcframework', 'Frameworks/FirebaseMessaging.xcframework', 'Frameworks/FirebaseStorage.xcframework', 'Frameworks/firebase_auth.xcframework', 'Frameworks/firebase_core.xcframework', 'Frameworks/firebase_database.xcframework', 'Frameworks/firebase_messaging.xcframework', 'Frameworks/firebase_storage.xcframework', 'Frameworks/Flutter.xcframework', 'Frameworks/FlutterPluginRegistrant.xcframework', 'Frameworks/flutter_inappwebview.xcframework', 'Frameworks/flutter_local_notifications.xcframework', 'Frameworks/GoogleDataTransport.xcframework', 'Frameworks/GTMSessionFetcher.xcframework', 'Frameworks/image_picker_ios.xcframework', 'Frameworks/integration_test.xcframework', 'Frameworks/leveldb.xcframework', 'Frameworks/location.xcframework', 'Frameworks/MTBBarcodeScanner.xcframework', 'Frameworks/nanopb.xcframework', 'Frameworks/OrderedSet.xcframework', 'Frameworks/package_info.xcframework', 'Frameworks/path_provider_foundation.xcframework', 'Frameworks/patrol.xcframework', 'Frameworks/qr_code_scanner.xcframework', 'Frameworks/share.xcframework', 'Frameworks/store_redirect.xcframework', 'Frameworks/uni_links.xcframework', 'Frameworks/url_launcher_ios.xcframework', 'Frameworks/vibration.xcframework'
  s.preserve_path = 'Frameworks/*'
end
