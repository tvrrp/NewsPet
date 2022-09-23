import UIKit

public extension UITableView {
    func registerCellClass(_ cellClass: AnyClass) {
        let identifier = String.className(cellClass)
        register(cellClass, forCellReuseIdentifier: identifier)
    }
}
