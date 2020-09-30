//
//  Created by Gustavo Vergara Garcia on 17/08/20.
//

// MARK: - Protocol
public protocol NavigationPresentable: Presentable {
    func asNavigationController() -> NavigationController
    
    func pushPresentable(_ presentable: Presentable, animated: Bool)
    
    @discardableResult
    func popPresentable(animated: Bool) -> Presentable?
    @discardableResult
    func popToPresentable(_ presentable: Presentable, animated: Bool) -> [Presentable]?
    @discardableResult
    func popToRootPresentable(animated: Bool) -> [Presentable]?
    
    var topPresentable: Presentable? { get }
    var visiblePresentable: Presentable? { get }
    
    var presentables: [Presentable] { get set }
    
    func setPresentables(_ presentables: [Presentable], animated: Bool)
}

// MARK: - Implementation
public class NavigationPresentableController: NavigationPresentable {
    let navigationController: NavigationController

    public init(_ navigationController: NavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: Presentable

    public func asViewController() -> ViewController { self.navigationController }

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        self.navigationController.present(presentable.asViewController(), animated: animated, completion: completion)
    }

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        self.navigationController.dismiss(animated: animated, completion: completion)
    }
    
    // MARK: Navigation Presentable
    
    public func asNavigationController() -> NavigationController { self.navigationController }
    
    public func pushPresentable(_ presentable: Presentable, animated: Bool) {
        self.navigationController
            .pushViewController(presentable.asViewController(), animated: animated)
    }
    
    @discardableResult
    public func popPresentable(animated: Bool) -> Presentable? {
        self.navigationController
            .popViewController(animated: animated)?
            .eraseToPresentable()
    }
    
    @discardableResult
    public func popToPresentable(_ presentable: Presentable, animated: Bool) -> [Presentable]? {
        self.navigationController
            .popToViewController(presentable.asViewController(), animated: animated)?
            .map { $0.eraseToPresentable() }
    }
    
    @discardableResult
    public func popToRootPresentable(animated: Bool) -> [Presentable]? {
        self.navigationController
            .popToRootViewController(animated: animated)?
            .map { $0.eraseToPresentable() }
    }
    
    public var topPresentable: Presentable? {
        self.navigationController.topViewController?
            .eraseToPresentable()
    }
    public var visiblePresentable: Presentable? {
        self.navigationController.visibleViewController?
            .eraseToPresentable()
    }
    
    public var presentables: [Presentable] {
        get { self.navigationController.viewControllers.map { $0.eraseToPresentable() } }
        set { self.navigationController.viewControllers = newValue.map { $0.asViewController() } }
    }
    
    public func setPresentables(_ presentables: [Presentable], animated: Bool) {
        self.navigationController
            .setViewControllers(presentables.map { $0.asViewController() }, animated: animated)
    }

}

// MARK: - Extensions
public extension NavigationController {
    func eraseToNavigationPresentable() -> NavigationPresentable { NavigationPresentableController(self) }
}
