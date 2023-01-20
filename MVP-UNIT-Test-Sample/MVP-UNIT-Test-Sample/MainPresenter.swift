import Foundation
// output protocol
protocol MainViewProtocol: AnyObject {
    func setGreeting(greeting: String)
}

// input protocol
// view должно соответствовать протоколу, чтобы не привязыватьса к конкретному классу, а привязываться к абстракции (D из SOLID)
// presenter управляет и view и model
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, person: Person)
    func showGreeting()
}

// создаем непосредственно Presentor подписываем на протокол, те на абстракцию

class mainPresentor: MainViewPresenterProtocol {
    // объявляем view чтобы presentor управлял моделью
    // view может быть любая абстрактная вью подписанная на протокол
    // в unit тестах мы можем поместить mock view
    let view: MainViewProtocol
    
    // объявляем person чтобы presentor управлял моделью
    let person: Person
    
    // внедрение зависимости
    required init(view: MainViewProtocol, person: Person) {
        self.view = view
        self.person = person
    }
    
    func showGreeting() {
        let greeting = person.firstName + " " + person.lastName
        view.setGreeting(greeting: greeting)
    } 
}
