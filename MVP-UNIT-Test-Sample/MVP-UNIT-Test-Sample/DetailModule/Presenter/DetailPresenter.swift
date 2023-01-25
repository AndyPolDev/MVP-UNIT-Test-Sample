import Foundation
//output protocol
protocol DetailViewProtocol: AnyObject {
    func setComment(comment: Comment?)
}

//input protocol
protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?)
    func setComment()
    func backToRootPressed()
}

class DetailPresenter: DetailViewPresenterProtocol {
    let view: DetailViewProtocol?
    let networkService: NetworkServiceProtocol
    let router: RouterProtocol?
    var comment: Comment?
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol, comment: Comment?) {
        self.view = view
        self.networkService = networkService
        self.router = router
        self.comment = comment
    }
    
    func backToRootPressed() {
        router?.popToRoot()
    }
    
    func setComment() {
        self.view?.setComment(comment: comment)
    }
}
