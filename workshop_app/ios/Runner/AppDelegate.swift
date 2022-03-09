import UIKit
import Flutter
import CryptoKit

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      print("didFinishLaunchingWithOptions")
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
          let platformChannel = FlutterMethodChannel(name: "com.appnoe.flutter-workshop/cryptokit",
                                                    binaryMessenger: controller.binaryMessenger)
          platformChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              print("Call method: \(call.method)")
              
              switch call.method {
              case "increment":
                  guard let count = (call.arguments as? NSDictionary)?["count"] as? Int else {
                      result(FlutterError(code: "INVALID_ARGUMENT", message: "Value of count cannot be null", details: nil))
                      return
                  }
                  result(count + 1)
              case "getHash":
                  guard let text = (call.arguments as? NSDictionary)?["text"] as? String else {
                      result(FlutterError(code: "INVALID_ARGUMENT", message: "Value of text cannot be null", details: nil))
                      return
                  }
                  let digest = SHA256.hash(data: Data(text.utf8))
                  let hashString = digest.compactMap { String(format: "%02x", $0) }.joined()
                  result("\(hashString)")
              default:
                  result(FlutterMethodNotImplemented)
              }
          })
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
