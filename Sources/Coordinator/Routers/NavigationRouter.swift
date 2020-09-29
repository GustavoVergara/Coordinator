//
//  Created by Gustavo Vergara Garcia on 26/08/20.
//

import UIKit

class NavigationRouter: Router {
    var initialPresentable: Presentable?
    var hasMadeFirstPresent = false
    
    let navigationPresentable: NavigationPresentable
    
    init(
        navigationPresentable: NavigationPresentable
    ) {
        self.navigationPresentable = navigationPresentable
    }
    
    func present(
        _ presentable: Presentable,
        animated: Bool,
        completion: (() -> Void)?
    ) {
        if self.hasMadeFirstPresent == false {
            self.initialPresentable = self.navigationPresentable.topPresentable
            self.hasMadeFirstPresent = true
        }
        self.navigationPresentable
            .pushPresentable(presentable, animated: animated)
        completion?()
    }
    
    func dismiss(
        animated: Bool,
        completion: (() -> Void)?
    ) {
        if let initialPresentable = self.initialPresentable {
            self.navigationPresentable
                .popToPresentable(initialPresentable, animated: animated)
        } else {
            self.navigationPresentable
                .setPresentables([], animated: animated)
        }
        completion?()
    }
    
}
