import Foundation
//output protocol
protocol DetailViewProtocol: AnyObject {
    func setComment(comment: Comment?)
}

//input protocol
protocol DetailViewPresenterProtocol: AnyObject {
    init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comment: Comment?)
    func setComment()
}

class DetailPresenter: DetailViewPresenterProtocol {
    let view: DetailViewProtocol
    let networkService: NetworkServiceProtocol
    var comment: Comment?
    required init(view: DetailViewProtocol, networkService: NetworkServiceProtocol, comment: Comment?) {
        self.view = view
        self.networkService = networkService
        self.comment = comment
    }
    
    func setComment() {
        self.view.setComment(comment: comment)
    }
}
