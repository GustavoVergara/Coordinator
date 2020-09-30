//
//  Created by Gustavo Vergara Garcia on 17/08/20.
//

// MARK: - Protocol
public protocol Presentable: class {
    func asViewController() -> ViewController

    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

// MARK: - Implementation
public class PresentableController: Presentable {
    let viewController: ViewController

    public init(_ viewController: ViewController) {
        self.viewController = viewController
    }

    public func asViewController() -> ViewController { self.viewController }

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        self.viewController.present(presentable.asViewController(), animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.viewController.dismiss(animated: animated, completion: completion)
    }
}

// MARK: - Extensions
public extension ViewController {
    func eraseToPresentable() -> Presentable { PresentableController(self) }
}
