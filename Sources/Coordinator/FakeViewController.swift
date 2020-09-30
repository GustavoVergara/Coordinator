//
//  Created by Gustavo Vergara Garcia on 29/09/20.
//

#if canImport(UIKit)
import UIKit
public typealias ViewController = UIViewController
public typealias NavigationController = UINavigationController
#else
public typealias ViewController = FakeViewController

open class FakeViewController {
    open private(set) var presentedViewController: FakeViewController?
    open private(set) var presentingViewController: FakeViewController?
    
    public init() {}
    
    open func present(_ viewControllerToPresent: FakeViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.presentingViewController = viewControllerToPresent
        self.presentedViewController?.presentingViewController = nil
        self.presentedViewController = viewControllerToPresent
        completion?()
    }

    open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        self.presentedViewController?.presentingViewController = nil
        self.presentedViewController = nil
        completion?()
    }
}

public typealias NavigationController = FakeNavigationViewController

open class FakeNavigationViewController: FakeViewController {
    open var viewControllers: [ViewController] = []
    
    open var topViewController: ViewController? { self.viewControllers.last }
    open var visibleViewController: ViewController? { self.viewControllers.last }
    
    open func pushViewController(_ viewController: ViewController, animated: Bool) {
        self.viewControllers.append(viewController)
    }
    
    open func popViewController(animated: Bool) -> ViewController? {
        self.viewControllers.popLast()
    }

    open func popToViewController(_ viewController: ViewController, animated: Bool) -> [ViewController]? {
        guard
            self.viewControllers.contains(where: { $0 === viewController })
        else {
            return nil
        }
        var viewControllers = [ViewController]()
        while self.viewControllers.last !== viewController, let removedViewController = self.viewControllers.popLast() {
            viewControllers.append(removedViewController)
        }
        return viewControllers.isEmpty ? nil : []
    }

    open func popToRootViewController(animated: Bool) -> [ViewController]? {
        let viewControllers = Array(self.viewControllers.dropFirst())
        if let firstViewControllers = self.viewControllers.first {
            self.viewControllers = [firstViewControllers]
        }
        return viewControllers.isEmpty ? nil : viewControllers
    }

    open func setViewControllers(_ viewControllers: [ViewController], animated: Bool) {
        self.viewControllers = viewControllers
    }
    
}
#endif
