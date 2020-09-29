//
//  Created by Gustavo Vergara Garcia on 17/08/20.
//

import UIKit

// MARK: - Protocol
public protocol Presentable: class {
    func asViewController() -> UIViewController

    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

// MARK: - Implementation
public class PresentableController: Presentable {
    let viewController: UIViewController

    public init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    public func asViewController() -> UIViewController { self.viewController }

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        self.viewController.present(presentable.asViewController(), animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.viewController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - Extensions
public extension UIViewController {
    func eraseToPresentable() -> Presentable { PresentableController(self) }
}
