import XCTest
// Необходимо добавить @testable import MVP_UNIT_Test_Sample чтобы class MainPresenterTest: XCTestCase видел таргеты
@testable import MVP_UNIT_Test_Sample

// Cоздаем тестовую mock view
class MockView: MainViewProtocol {
    var mockTitleString: String?
    func setGreeting(greeting: String) {
        self.mockTitleString = greeting
    }
}

final class MainPresenterTest: XCTestCase {
    
    // Oбъявляем
    var mockView: MockView!
    var person: Person!
    var mainPresenter: MainPresenter!
    
    // Метод срабатывает во время запуска теста
    override func setUpWithError() throws {
        mockView = MockView()
        person = Person(firstName: "Baz", lastName: "Bar")
        mainPresenter = MainPresenter(view: mockView, person: person)
    }
    
    // Метод срабатывает после теста, необходимо занилить тестовые объекты
    override func tearDownWithError() throws {
        mockView = nil
        person = nil
        mainPresenter = nil
    }
    
    // Ниже создаем тестовые функции
    // !!!!Oбязательно пишем test в начале названия метода!!!!
    func testMainModuleIsNotNil() {
        // проверяем объекты mockView, person, mainPresenter на nil
        XCTAssertNotNil(mockView, "mockView is not nil")
        XCTAssertNotNil(person, "person is not nil")
        XCTAssertNotNil(mainPresenter, "mainPresenter is not nil")
    }
    
    func testView() {
        // сравниваем данные в mockView
        mainPresenter.showGreeting()
        XCTAssertEqual(mockView.mockTitleString, "Baz Bar")
    }
    
    func testPersonModel() {
        XCTAssertEqual(person.firstName, "Baz")
        XCTAssertEqual(person.lastName, "Bar")
    }
}
