//
//  Created by Gustavo Vergara Garcia on 26/08/20.
//

import Coordinator

public class NavigationPresentableSpy: NavigationPresentable {
    public init() {}

    public var invokedTopPresentableGetter = false
    public var invokedTopPresentableGetterCount = 0
    public var stubbedTopPresentable: Presentable!

    public var topPresentable: Presentable? {
        invokedTopPresentableGetter = true
        invokedTopPresentableGetterCount += 1
        return stubbedTopPresentable
    }

    public var invokedVisiblePresentableGetter = false
    public var invokedVisiblePresentableGetterCount = 0
    public var stubbedVisiblePresentable: Presentable!

    public var visiblePresentable: Presentable? {
        invokedVisiblePresentableGetter = true
        invokedVisiblePresentableGetterCount += 1
        return stubbedVisiblePresentable
    }

    public var invokedPresentablesSetter = false
    public var invokedPresentablesSetterCount = 0
    public var invokedPresentables: [Presentable]?
    public var invokedPresentablesList = [[Presentable]]()
    public var invokedPresentablesGetter = false
    public var invokedPresentablesGetterCount = 0
    public var stubbedPresentables: [Presentable]! = []

    public var presentables: [Presentable] {
        set {
            invokedPresentablesSetter = true
            invokedPresentablesSetterCount += 1
            invokedPresentables = newValue
            invokedPresentablesList.append(newValue)
        }
        get {
            invokedPresentablesGetter = true
            invokedPresentablesGetterCount += 1
            return stubbedPresentables
        }
    }

    public var invokedAsNavigationController = false
    public var invokedAsNavigationControllerCount = 0
    public var stubbedAsNavigationControllerResult: NavigationController!

    public func asNavigationController() -> NavigationController {
        invokedAsNavigationController = true
        invokedAsNavigationControllerCount += 1
        return stubbedAsNavigationControllerResult
    }

    public var invokedPushPresentable = false
    public var invokedPushPresentableCount = 0
    public var invokedPushPresentableParameters: (presentable: Presentable, animated: Bool)?
    public var invokedPushPresentableParametersList = [(presentable: Presentable, animated: Bool)]()

    public func pushPresentable(_ presentable: Presentable, animated: Bool) {
        invokedPushPresentable = true
        invokedPushPresentableCount += 1
        invokedPushPresentableParameters = (presentable, animated)
        invokedPushPresentableParametersList.append((presentable, animated))
    }

    public var invokedPopPresentable = false
    public var invokedPopPresentableCount = 0
    public var invokedPopPresentableParameters: (animated: Bool, Void)?
    public var invokedPopPresentableParametersList = [(animated: Bool, Void)]()
    public var stubbedPopPresentableResult: Presentable!

    public func popPresentable(animated: Bool) -> Presentable? {
        invokedPopPresentable = true
        invokedPopPresentableCount += 1
        invokedPopPresentableParameters = (animated, ())
        invokedPopPresentableParametersList.append((animated, ()))
        return stubbedPopPresentableResult
    }

    public var invokedPopToPresentable = false
    public var invokedPopToPresentableCount = 0
    public var invokedPopToPresentableParameters: (presentable: Presentable, animated: Bool)?
    public var invokedPopToPresentableParametersList = [(presentable: Presentable, animated: Bool)]()
    public var stubbedPopToPresentableResult: [Presentable]!

    public func popToPresentable(_ presentable: Presentable, animated: Bool) -> [Presentable]? {
        invokedPopToPresentable = true
        invokedPopToPresentableCount += 1
        invokedPopToPresentableParameters = (presentable, animated)
        invokedPopToPresentableParametersList.append((presentable, animated))
        return stubbedPopToPresentableResult
    }

    public var invokedPopToRootPresentable = false
    public var invokedPopToRootPresentableCount = 0
    public var invokedPopToRootPresentableParameters: (animated: Bool, Void)?
    public var invokedPopToRootPresentableParametersList = [(animated: Bool, Void)]()
    public var stubbedPopToRootPresentableResult: [Presentable]!

    public func popToRootPresentable(animated: Bool) -> [Presentable]? {
        invokedPopToRootPresentable = true
        invokedPopToRootPresentableCount += 1
        invokedPopToRootPresentableParameters = (animated, ())
        invokedPopToRootPresentableParametersList.append((animated, ()))
        return stubbedPopToRootPresentableResult
    }

    public var invokedSetPresentables = false
    public var invokedSetPresentablesCount = 0
    public var invokedSetPresentablesParameters: (presentables: [Presentable], animated: Bool)?
    public var invokedSetPresentablesParametersList = [(presentables: [Presentable], animated: Bool)]()

    public func setPresentables(_ presentables: [Presentable], animated: Bool) {
        invokedSetPresentables = true
        invokedSetPresentablesCount += 1
        invokedSetPresentablesParameters = (presentables, animated)
        invokedSetPresentablesParametersList.append((presentables, animated))
    }

    public var invokedAsViewController = false
    public var invokedAsViewControllerCount = 0
    public var stubbedAsViewControllerResult: ViewController!

    public func asViewController() -> ViewController {
        invokedAsViewController = true
        invokedAsViewControllerCount += 1
        return stubbedAsViewControllerResult
    }

    public var invokedPresent = false
    public var invokedPresentCount = 0
    public var invokedPresentParameters: (presentable: Presentable, animated: Bool)?
    public var invokedPresentParametersList = [(presentable: Presentable, animated: Bool)]()
    public var shouldInvokePresentCompletion = false

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {
        invokedPresent = true
        invokedPresentCount += 1
        invokedPresentParameters = (presentable, animated)
        invokedPresentParametersList.append((presentable, animated))
        if shouldInvokePresentCompletion {
            completion?()
        }
    }

    public var invokedDismiss = false
    public var invokedDismissCount = 0
    public var invokedDismissParameters: (animated: Bool, Void)?
    public var invokedDismissParametersList = [(animated: Bool, Void)]()
    public var shouldInvokeDismissCompletion = false

    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        invokedDismiss = true
        invokedDismissCount += 1
        invokedDismissParameters = (animated, ())
        invokedDismissParametersList.append((animated, ()))
        if shouldInvokeDismissCompletion {
            completion?()
        }
    }
}
