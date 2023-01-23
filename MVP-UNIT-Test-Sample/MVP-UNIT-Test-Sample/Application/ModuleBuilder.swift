import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

// Здесь как раз происходит внедрение зависимости извне, вместо view мы можем подсунуть mock view
class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let person = Person(firstName: "Andy", lastName: "PolDev")
        let view = MainViewController()
        let presenter = MainPresenter(view: view, person: person)
        view.presenter = presenter
        return view
    }
    
    //Для каждого модуля мы пишем отельную функцию createSomeModule()
}
