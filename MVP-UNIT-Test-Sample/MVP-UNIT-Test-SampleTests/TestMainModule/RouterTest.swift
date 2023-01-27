import XCTest
// Необходимо добавить @testable import MVP_UNIT_Test_Sample чтобы class MainPresenterTest: XCTestCase видел таргеты
@testable import MVP_UNIT_Test_Sample

// Моковый navigation controller
class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}

final class RouterTest: XCTestCase {
    
    var router: RouterProtocol!
    var navigationController = MockNavigationController()
    let assembly = AsselderModuleBuilder()

    override func setUpWithError() throws {
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }

    override func tearDownWithError() throws {
        router = nil
    }
    
    func testRouter() {
        router.showDetail(comment: nil)
        let detailViewController = navigationController.presentedVC
        XCTAssertTrue(detailViewController is DetailViewController)
        // Ломаем тест
        //XCTAssertTrue(detailViewController is MainViewController)
    }
}
