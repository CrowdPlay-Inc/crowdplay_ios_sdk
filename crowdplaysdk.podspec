#
# Be sure to run `pod lib lint crowdplaysdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'crowdplaysdk'
  s.version          = '1.1460'
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

  s.ios.deployment_target = '12.0'

  s.source_files = 'Sources/**/*'
  s.swift_version = '5.5'
  
  s.ios.frameworks  = 'UIKit'

  s.dependency 'FirebaseAuth', '~> 11.4.0'
  s.dependency 'FirebaseStorage', '~> 11.4.0'
  s.dependency 'FirebaseDatabase', '~> 11.4.0'
  s.dependency 'FirebaseMessaging', '~> 11.4.0'

  s.resource_bundles     = {
    'CrowdplayPrivacy' => ['Sources/crowdplaysdk/PrivacyInfo.xcprivacy']
  }
  
  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS' => 'armv7' }

  s.ios.vendored_frameworks = 'Frameworks/App.xcframework','Frameworks/Braintree.xcframework','Frameworks/BraintreeDropIn.xcframework','Frameworks/CocoaAsyncSocket.xcframework','Frameworks/Cryptor.xcframework','Frameworks/CryptorECC.xcframework','Frameworks/CryptorRSA.xcframework','Frameworks/Flutter.xcframework','Frameworks/FlutterPluginRegistrant.xcframework','Frameworks/GTMSessionFetcher.xcframework','Frameworks/KituraContracts.xcframework','Frameworks/LoggerAPI.xcframework','Frameworks/Logging.xcframework','Frameworks/OrderedSet.xcframework','Frameworks/Sentry.xcframework','Frameworks/SwiftJWT.xcframework','Frameworks/app_links.xcframework','Frameworks/audioplayers_darwin.xcframework','Frameworks/device_info_plus.xcframework','Frameworks/firebase_auth.xcframework','Frameworks/firebase_core.xcframework','Frameworks/firebase_database.xcframework','Frameworks/firebase_messaging.xcframework','Frameworks/firebase_storage.xcframework','Frameworks/flutter_inappwebview_ios.xcframework','Frameworks/flutter_local_notifications.xcframework','Frameworks/image_picker_ios.xcframework','Frameworks/integration_test.xcframework','Frameworks/leveldb.xcframework','Frameworks/location.xcframework','Frameworks/mobile_scanner.xcframework','Frameworks/nanopb.xcframework','Frameworks/package_info_plus.xcframework','Frameworks/path_provider_foundation.xcframework','Frameworks/patrol.xcframework','Frameworks/sentry_flutter.xcframework','Frameworks/share_plus.xcframework','Frameworks/shared_preferences_foundation.xcframework','Frameworks/shift4_sdk.xcframework','Frameworks/sqflite_darwin.xcframework','Frameworks/store_redirect.xcframework','Frameworks/url_launcher_ios.xcframework','Frameworks/vibration.xcframework'
  s.preserve_path = 'Frameworks/*'
end
