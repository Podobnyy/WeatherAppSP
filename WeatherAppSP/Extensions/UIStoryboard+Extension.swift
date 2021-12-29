import UIKit

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T? {
        if let name = NSStringFromClass(T.self).components(separatedBy: (".")).last {
            return instantiateViewController(withIdentifier: name) as? T
        }
        return nil
    }
}
