import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().delegate = self
        }
        registerForPushNotifications()
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func registerForPushNotifications() {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current()
                .requestAuthorization(options: [.alert, .sound, .badge]) {
                    granted, error in
                    print("Permission granted: \(granted)")
            }
        }
    }
}
