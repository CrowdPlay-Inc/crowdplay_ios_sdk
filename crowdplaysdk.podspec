#
# Be sure to run `pod lib lint crowdplaysdk.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

flutter_application_path = '../'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

Pod::Spec.new do |s|
  s.name             = 'crowdplaysdk'
  s.version          = '0.1.1'
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
  s.author           = { 'Matthew Baker' => 'matt@bakermatt.com' }
  s.source           = { :git => 'git@github.com:takaoandrew/crowdplay_ios_sdk.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'crowdplaysdk/Classes/**/*'
  
  # s.resource_bundles = {
  #   'crowdplaysdk' => ['crowdplaysdk/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  
  s.ios.frameworks  = 'UIKit'
  s.dependency 'Flutter'
  s.ios.vendored_frameworks = 'Frameworks/App.xcframework', 'Frameworks/FirebaseInstallations.xcframework', 'Frameworks/MTBBarcodeScanner.xcframework', 'Frameworks/image_picker_ios.xcframework', 'Frameworks/qr_code_scanner.xcframework', 'Frameworks/GoogleDataTransport.xcframework', 'Frameworks/firebase_auth.xcframework', 'Frameworks/image_picker.xcframework', 'Frameworks/share.xcframework', 'Frameworks/FBLPromises.xcframework', 'Frameworks/FirebaseMessaging.xcframework', 'Frameworks/GoogleUtilities.xcframework', 'Frameworks/firebase_core.xcframework', 'Frameworks/leveldb.xcframework', 'Frameworks/store_redirect.xcframework', 'Frameworks/FirebaseAuth.xcframework', 'Frameworks/FirebaseStorage.xcframework', 'Frameworks/Reachability.xcframework', 'Frameworks/firebase_database.xcframework', 'Frameworks/location.xcframework', 'Frameworks/uni_links.xcframework', 'Frameworks/FirebaseCore.xcframework', 'Frameworks/audioplayers.xcframework', 'Frameworks/firebase_messaging.xcframework', 'Frameworks/nanopb.xcframework', 'Frameworks/url_launcher_ios.xcframework', 'Frameworks/FirebaseCoreDiagnostics.xcframework', 'Frameworks/FlutterPluginRegistrant.xcframework', 'Frameworks/connectivity.xcframework', 'Frameworks/firebase_storage.xcframework', 'Frameworks/package_info.xcframework', 'Frameworks/video_player.xcframework', 'Frameworks/FirebaseDatabase.xcframework', 'Frameworks/GTMSessionFetcher.xcframework', 'Frameworks/device_info.xcframework', 'Frameworks/flutter_local_notifications.xcframework', 'Frameworks/path_provider_ios.xcframework'
  s.preserve_path = 'Frameworks/*'
end