import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootViewController: UINavigationController?

    var applicationCoordinator: ApplicationCoordinator?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        rootViewController = navigationController

        let router = RouterImp(rootController: navigationController)
        applicationCoordinator = ApplicationCoordinator(router: router)
        applicationCoordinator?.start()

        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

// TODO: Name location on LocationModel - get from Apple -
// geocode APPLE  https://developer.apple.com/documentation/corelocation/clgeocoder

// TODO: Feature when will be free time:
// - Delete location from listOfLocation (LocationsViewController) by swipe
// - Show List Location when no internet
// - Unboarding (first start app - meet and choose first location)
