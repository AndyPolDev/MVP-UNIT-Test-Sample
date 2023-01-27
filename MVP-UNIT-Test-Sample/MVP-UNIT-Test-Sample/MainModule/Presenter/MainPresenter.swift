import Foundation
// output protocol
protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

// input protocol
// view должно соответствовать протоколу, чтобы не привязыватьса к конкретному классу, а привязываться к абстракции (D из SOLID)
// presenter управляет и view и model
protocol MainViewPresenterProtocol: AnyObject {
    init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
    func getComments()
    func tapOnTheComment(comment: Comment?)
    var comments: [Comment]? { get set }
}

// создаем непосредственно Presentor подписываем на протокол, те на абстракцию

class MainPresenter: MainViewPresenterProtocol {
    // объявляем view чтобы presentor управлял моделью
    // view может быть любая абстрактная вью подписанная на протокол
    // в unit тестах мы можем поместить mock view
    let view: MainViewProtocol?
    var router: RouterProtocol?
    let networkService: NetworkServiceProtocol!
    var comments: [Comment]?
    
    // внедрение зависимости
    required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
        self.view = view
        self.router = router
        self.networkService = networkService
        // вместе с init вызовется getComments()
        getComments()
    }
    
    func getComments() {
        networkService.getComments { [weak self] result in
            guard let self = self else { return }
            // URL работает асинхронно, соответственно result приходит асинхтонно, чтобы передать данные через success во вью без ошибки необходимо это сделать на main очереди
            DispatchQueue.main.async {
                switch result {
                case .success(let comments):
                    self.comments = comments
                    self.view?.success()
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func tapOnTheComment(comment: Comment?) {
        router?.showDetail(comment: comment)
    }
}
