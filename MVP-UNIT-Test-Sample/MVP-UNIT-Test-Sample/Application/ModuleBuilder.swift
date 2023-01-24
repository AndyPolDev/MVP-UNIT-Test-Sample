import UIKit

protocol Builder {
    static func createMainModule() -> UIViewController
}

// Здесь как раз происходит внедрение зависимости извне, вместо view мы можем подсунуть mock view
class ModuleBuilder: Builder {
    static func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkService = NetworkService()
        let presenter = MainPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        return view
    }
    
    //Для каждого модуля мы пишем отельную функцию createSomeModule()
}
