//
//  Created by Gustavo Vergara Garcia on 01/09/20.
//

import UIKit
import Coordinator

public class FakeNavigationPresentable: NavigationPresentable {
    public init() {}

    public var presentables: [Presentable] = []
    
    public var topPresentable: Presentable? { self.presentables.last }

    public var visiblePresentable: Presentable? { self.presentables.last }
    
    public func pushPresentable(_ presentable: Presentable, animated: Bool) {
        self.presentables.append(presentable)
    }

    public func popPresentable(animated: Bool) -> Presentable? {
        self.presentables.removeLast()
    }

    public func popToPresentable(_ presentable: Presentable, animated: Bool) -> [Presentable]? {
        guard
            self.presentables.contains(where: { $0 === presentable })
        else {
            return nil
        }
        var presentables = [Presentable]()
        while self.presentables.last !== presentable {
            presentables.append(self.presentables.removeLast())
        }
        return presentables.isEmpty ? nil : []
    }

    public func popToRootPresentable(animated: Bool) -> [Presentable]? {
        let presentables = Array(self.presentables.dropFirst())
        if let firstPresentable = self.presentables.first {
            self.presentables = [firstPresentable]
        }
        return presentables.isEmpty ? nil : presentables
    }

    public func setPresentables(_ presentables: [Presentable], animated: Bool) {
        self.presentables = presentables
    }
    
    public func asNavigationController() -> UINavigationController {
        fatalError("Dummy implementation")
    }
    
    public func asViewController() -> UIViewController {
        fatalError("Dummy implementation")
    }

    public func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?) {}

    public func dismiss(animated: Bool, completion: (() -> Void)?) {}
}
