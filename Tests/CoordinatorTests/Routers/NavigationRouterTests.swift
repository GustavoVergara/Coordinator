//
//  Created by Gustavo Vergara Garcia on 26/08/20.
//

import XCTest
import TestKit
@testable import Coordinator

final class NavigationRouterTests: XCTestCase {
    var fakeNavigationPresentable: FakeNavigationPresentable!
    
    var sut: Router!
    
    override func setUp() {
        self.fakeNavigationPresentable = FakeNavigationPresentable()
        
        sut = createSUT()
    }
    
    func createSUT() -> Router {
        NavigationRouter(
            navigationPresentable: self.fakeNavigationPresentable
        )
    }
    
    func test_present_pushesThePresentableOntoTheNavigation() {
        // given
        let expectedPresentable = PresentableSpy()
        let expectedAnimated = true
        
        var didCallCompletion = false
        
        // when
        sut.present(expectedPresentable, animated: expectedAnimated) {
            didCallCompletion = true
        }
        
        // then
        XCTAssertEqual(
            self.fakeNavigationPresentable.presentables as? [PresentableSpy],
            [expectedPresentable]
        )
        
        XCTAssert(didCallCompletion)
    }
    
    func test_dismiss_popsToInitialPresentable_whenInitialPresentableExistsOnFirstPresent() {
        // given
        let expectedPresentable = PresentableSpy()
        let expectedAnimated = true

        var didCallCompletion = false
        
        self.fakeNavigationPresentable
            .pushPresentable(expectedPresentable, animated: false)
        
        sut.present(PresentableSpy(), animated: true)
        
        // when
        sut.dismiss(animated: expectedAnimated) {
            didCallCompletion = true
        }

        // then
        XCTAssert(didCallCompletion)
        
        XCTAssertEqual(
            self.fakeNavigationPresentable.presentables as? [PresentableSpy],
            [expectedPresentable]
        )
    }
    
    func test_dismiss_setsPresentablesToEmpty_whenNavigationHasNoPresentablesOnFirstPresent() {
        // given
        let expectedAnimated = true

        var didCallCompletion = false
        
        sut.present(PresentableSpy(), animated: true)
        
        // when
        sut.dismiss(animated: expectedAnimated) {
            didCallCompletion = true
        }

        // then
        XCTAssert(didCallCompletion)
        
        XCTAssert(
            self.fakeNavigationPresentable.presentables.isEmpty
        )
    }
    
    static var allTests = [
        ("test_present_pushesThePresentableOntoTheNavigation", test_present_pushesThePresentableOntoTheNavigation),
        ("test_dismiss_popsToInitialPresentable_whenInitialPresentableExistsOnFirstPresent", test_dismiss_popsToInitialPresentable_whenInitialPresentableExistsOnFirstPresent),
        ("test_dismiss_setsPresentablesToEmpty_whenNavigationHasNoPresentablesOnFirstPresent", test_dismiss_setsPresentablesToEmpty_whenNavigationHasNoPresentablesOnFirstPresent),
    ]
}
