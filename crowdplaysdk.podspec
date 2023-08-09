#
# Be sure to run `pod lib lint crowdplaysdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'crowdplaysdk'
  s.version          = '0.1.46'
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

  s.ios.vendored_frameworks = 'Frameworks/App.xcframework', 'Frameworks/FirebaseInstallations.xcframework', 'Frameworks/device_info_plus.xcframework', 'Frameworks/flutter_inappwebview.xcframework', 'Frameworks/OrderedSet.xcframework', 'Frameworks/vibration.xcframework', 'Frameworks/path_provider_foundation.xcframework', 'Frameworks/MTBBarcodeScanner.xcframework', 'Frameworks/image_picker_ios.xcframework', 'Frameworks/qr_code_scanner.xcframework', 'Frameworks/firebase_auth.xcframework', 'Frameworks/image_picker.xcframework', 'Frameworks/share.xcframework', 'Frameworks/FirebaseMessaging.xcframework', 'Frameworks/firebase_core.xcframework', 'Frameworks/leveldb.xcframework', 'Frameworks/store_redirect.xcframework', 'Frameworks/FirebaseAuth.xcframework', 'Frameworks/FirebaseAuthInterop.xcframework', 'Frameworks/FirebaseStorage.xcframework', 'Frameworks/FirebaseStorageInternal.xcframework', 'Frameworks/firebase_database.xcframework', 'Frameworks/location.xcframework', 'Frameworks/uni_links.xcframework', 'Frameworks/FirebaseCore.xcframework', 'Frameworks/FirebaseCoreExtension.xcframework', 'Frameworks/Flutter.xcframework', 'Frameworks/audioplayers_darwin.xcframework', 'Frameworks/firebase_messaging.xcframework', 'Frameworks/url_launcher_ios.xcframework', 'Frameworks/FirebaseCoreDiagnostics.xcframework', 'Frameworks/FirebaseAppCheckInterop.xcframework', 'Frameworks/FirebaseCoreInternal.xcframework', 'Frameworks/FlutterPluginRegistrant.xcframework', 'Frameworks/connectivity.xcframework', 'Frameworks/firebase_storage.xcframework', 'Frameworks/package_info.xcframework', 'Frameworks/video_player.xcframework', 'Frameworks/FirebaseDatabase.xcframework', 'Frameworks/GTMSessionFetcher.xcframework', 'Frameworks/device_info.xcframework', 'Frameworks/flutter_local_notifications.xcframework', 'Frameworks/path_provider_ios.xcframework'
  s.preserve_path = 'Frameworks/*'
end
