//
//  Created by Gustavo Vergara Garcia on 26/08/20.
//

import UIKit
import Coordinator

public class PresentableSpy: Presentable {
    public init() {}

    public var invokedAsViewController = false
    public var invokedAsViewControllerCount = 0
    public var stubbedAsViewControllerResult: UIViewController!

    public func asViewController() -> UIViewController {
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

extension PresentableSpy: Equatable {
    
    public static func == (lhs: PresentableSpy, rhs: PresentableSpy) -> Bool {
        lhs === rhs
    }

}
