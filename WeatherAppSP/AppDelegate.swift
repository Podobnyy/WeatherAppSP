import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication,
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    func application(_ application: UIApplication,
                     supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
        }
}

// TODO: Add button locations on WeatherViewController for go to LocationsViewController

// TODO: Name location on LocationModel - get from Apple -
// geocode APPLE  https://developer.apple.com/documentation/corelocation/clgeocoder

// TODO: Open start screen WeatherViewController OR LocationsViewController
// Open WeatherViewController if location choose
// Open LocationsViewController if location not choose

// TODO: Feature when will be free time:
// - Delete location from listOfLocation (LocationsViewController) by swipe
// - Show List Location when no internet
// - Unboarding (first start app - meet and choose first location)
