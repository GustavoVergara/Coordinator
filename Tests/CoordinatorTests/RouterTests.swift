import XCTest
import TestKit
@testable import Coordinator

final class RouterTests: XCTestCase {
    
    func test_presentExtension_servesAsProxy() {
        // given
        let expectedPresentable = PresentableSpy()
        let expectedAnimated = false
        let sut = RouterSpy()
        
        // when
        sut.present(expectedPresentable, animated: expectedAnimated)
        
        // then
        XCTAssertEqual(sut.invokedPresentCount, 1)

        XCTAssertEqual(
            expectedPresentable,
            sut.invokedPresentParameters?.presentable as? PresentableSpy
        )
        
        XCTAssertEqual(
            expectedAnimated,
            sut.invokedPresentParameters?.animated
        )
    }
    
    func test_dismissExtension_servesAsProxy() {
        // given
        let expectedAnimated = false
        let sut = RouterSpy()
        
        // when
        sut.dismiss(animated: expectedAnimated)
        
        // then
        XCTAssertEqual(sut.invokedDismissCount, 1)
        XCTAssertEqual(
            expectedAnimated,
            sut.invokedDismissParameters?.animated
        )
    }

    static var allTests = [
        ("test_presentExtension_servesAsProxy", test_presentExtension_servesAsProxy),
        ("test_dismissExtension_servesAsProxy", test_dismissExtension_servesAsProxy),
    ]
}
