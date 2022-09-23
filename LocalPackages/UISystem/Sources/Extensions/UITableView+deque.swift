import UIKit

extension UITableView {
    public func dequeue<T: UITableViewCell & Reusable>(_ cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell: \(T.reuseIdentifier)")
        }
        return cell
    }
}
