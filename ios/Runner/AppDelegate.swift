import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
    
    private var textField = UITextField()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      makeSecureYourScreen()
      
      let controller : FlutterViewController = self.window?.rootViewController as! FlutterViewController
          let securityChannel = FlutterMethodChannel(name: "secureShotChannel", binaryMessenger: controller.binaryMessenger)
          securityChannel.setMethodCallHandler({
                  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  if call.method == "secureIOS" {
                      self.textField.isSecureTextEntry = true
                  } else if call.method == "unSecureIOS" {
                      self.textField.isSecureTextEntry = false
                  }
          })
      
        GMSServices.provideAPIKey("AIzaSyC90DoQfGyncFuadw1japqUN86b51FcV9Q");
      
  		if #available(iOS 10.0, *) {
  			UNUserNotificationCenter.current().delegate = self as?
  UNUserNotificationCenterDelegate
  		}
      
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
    //UITextField View에 추가
      private func makeSecureYourScreen() {
            if (!self.window.subviews.contains(textField)) {
                self.window.addSubview(textField)
                textField.centerYAnchor.constraint(equalTo: self.window.centerYAnchor).isActive = true
                textField.centerXAnchor.constraint(equalTo: self.window.centerXAnchor).isActive = true
                self.window.layer.superlayer?.addSublayer(textField.layer)
                textField.layer.sublayers?.first?.addSublayer(self.window.layer)
            }
        }
}
