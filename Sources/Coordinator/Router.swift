//
//  Created by Gustavo Vergara Garcia on 17/08/20.
//

public protocol Router: class {
    func present(_ presentable: Presentable, animated: Bool, completion: (() -> Void)?)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}

extension Router {
    func present(_ presentable: Presentable, animated: Bool) {
        self.present(presentable, animated: animated, completion: nil)
    }
    func dismiss(animated: Bool) {
        self.dismiss(animated: animated, completion: nil)
    }
}
