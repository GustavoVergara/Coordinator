//
//  Created by Gustavo Vergara Garcia on 28/09/20.
//

import Quick
import Nimble
import TestKit
@testable import Coordinator

final class NavigationRouterSpec: QuickSpec {
    override func spec() {
        
        describe("NavigationRouter") {
            var sut: Router!
            
            var fakeNavigationPresentable: FakeNavigationPresentable!
            
            beforeEach {
                fakeNavigationPresentable = FakeNavigationPresentable()
                sut = NavigationRouter(
                    navigationPresentable: fakeNavigationPresentable
                )
            }
            
            context("when present is called") {
                let expectedPresentable = PresentableSpy()
                let expectedAnimated = true
                
                var didCallCompletion = false
                beforeEach {
                    sut.present(expectedPresentable, animated: expectedAnimated) {
                        didCallCompletion = true
                    }
                }
                
                it("pushes the presentable onto the navigation") {
                    expect(fakeNavigationPresentable.presentables as? [PresentableSpy])
                        .to(equal([expectedPresentable]))
                }
                
                it("calls completion") {
                    expect(didCallCompletion).to(beTrue())
                }
            }
            
            context("when dismiss is called and the NavigationPresentable already had a presentable on the first present") {
                let aPresentable = PresentableSpy()
                
                var didCallCompletion = false
                
                beforeEach {
                    fakeNavigationPresentable
                        .pushPresentable(aPresentable, animated: false)
                    
                    sut.present(PresentableSpy(), animated: true)
                    
                    sut.dismiss(animated: true) {
                        didCallCompletion = true
                    }
                }
                
                it("pops all presentales but the ones that were there already") {
                    expect(fakeNavigationPresentable.presentables as? [PresentableSpy])
                        .to(equal([aPresentable]))
                }
                
                it("calls completion") {
                    expect(didCallCompletion).to(beTrue())
                }
            }
            
            context("when dismiss is called and the NavigationPresentable does not have any presentable on the first present") {
                var didCallCompletion = false
                
                beforeEach {
                    sut.present(PresentableSpy(), animated: true)
                    
                    sut.dismiss(animated: true) {
                        didCallCompletion = true
                    }
                }
                
                it("pops all presentales") {
                    expect(fakeNavigationPresentable.presentables)
                        .to(beEmpty())
                }
                
                it("calls completion") {
                    expect(didCallCompletion).to(beTrue())
                }
            }

        }
        
    }
}
