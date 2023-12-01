import UIKit
import GoogleMaps
import Flutter
import Firebase

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    lazy var flutterEngine = FlutterEngine(name: "MyApp")
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
      flutterEngine.run()
      FirebaseApp.configure()
      if #available(iOS 10.0, *) {
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      }
      GMSServices.provideAPIKey("AIzaSyBl0Pm1-cZM3-IdYhEkmEQ2A4XxSJpIRdQ")
      GeneratedPluginRegistrant.register(with: self.flutterEngine)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
