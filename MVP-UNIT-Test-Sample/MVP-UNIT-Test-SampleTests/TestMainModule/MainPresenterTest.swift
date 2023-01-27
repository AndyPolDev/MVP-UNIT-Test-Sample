import XCTest
// Необходимо добавить @testable import MVP_UNIT_Test_Sample чтобы class MainPresenterTest: XCTestCase видел таргеты
@testable import MVP_UNIT_Test_Sample

// Cоздаем тестовую mock view
class MockView: MainViewProtocol {
    func success() {
    }
    
    func failure(error: Error) {
    }
}

class MockNethworkService: NetworkServiceProtocol {
    var comments: [Comment]!
    
    init() {}
    // convenience init необходим чтобы засетить comments
    convenience init(comments: [Comment]?) {
        self.init()
        self.comments = comments
    }
    
    func getComments(completion: @escaping (Result<[Comment]?, Error>) -> Void) {
        if let comments = comments {
            completion(.success(comments))
        } else {
            // создаем заглушку ошибки
            let error = NSError(domain: "", code: 0, userInfo: nil)
            completion(.failure(error))
        }
    }
}

final class MainPresenterTest: XCTestCase {
    
    // Oбъявляем
    var view: MockView!
    var presenter: MainPresenter!
    var nethworkService: NetworkServiceProtocol!
    var router: RouterProtocol!
    var comments = [Comment]()
    
    // Метод срабатывает во время запуска теста
    override func setUpWithError() throws {
        let navigationController = UINavigationController()
        let assembly = AsselderModuleBuilder()
        
        router = Router(navigationController: navigationController, assemblyBuilder: assembly)
    }
    
    // Метод срабатывает после теста, необходимо занилить тестовые объекты
    override func tearDownWithError() throws {
        view = nil
        nethworkService = nil
        presenter = nil
    }
    
    // Ниже создаем тестовые функции
    // !!!!Oбязательно пишем test в начале названия метода!!!!
    // В данном случае необходимо сравнить comment на входе и на выходе
    // Позитивный сценарий
    func testGetSuccessComments() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        nethworkService = MockNethworkService(comments: [comment])
        presenter = MainPresenter(view: view, networkService: nethworkService, router: router)
        var catchedComments: [Comment]?
        
        nethworkService.getComments { result in
            switch result {
            case.success(let comments):
                catchedComments = comments
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Сравниваем catchedComments равен ли он нулю
        XCTAssertNotEqual(catchedComments?.count, 0)
        XCTAssertEqual(catchedComments?.count, comments.count)
    }
    
    // Негативный сценарий, ловим error
    
    func testGetError() {
        let comment = Comment(postId: 1, id: 2, name: "Foo", email: "Baz", body: "Bar")
        comments.append(comment)
        
        view = MockView()
        // не передаем comment, не вызываем convenience init
        nethworkService = MockNethworkService()
        presenter = MainPresenter(view: view, networkService: nethworkService, router: router)
        
        var catchedError: Error?
        
        nethworkService.getComments { result in
            switch result {
            case.success(_):
                break
            case.failure(let error):
                catchedError = error
            }
        }
        
        // Сравниваем catchedComments равен ли он нулю
        XCTAssertNotNil(catchedError)
    }
}
