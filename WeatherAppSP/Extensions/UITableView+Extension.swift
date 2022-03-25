import UIKit

// MARK: - Generics for UITableViewCell
protocol ReusableTableViewCell {

    static var reuseIdentifier: String { get }
}

extension ReusableTableViewCell {

    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableTableViewCell {}

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }
        return cell
    }

    // MARK: - register
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    public func register<T: UITableViewCell>(cell: T.Type) {
        register(UINib(nibName: reuseIndentifier(for: cell), bundle: nil),
                 forCellReuseIdentifier: reuseIndentifier(for: cell))
    }
}
