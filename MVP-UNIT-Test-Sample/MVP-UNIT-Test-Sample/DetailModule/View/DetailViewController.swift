import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailLabel: UILabel!
    
    var presenter: DetailViewPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setComment()
    }
    
    @IBAction func popToRootPressed(_ sender: UIButton) {
        presenter.backToRootPressed()
    }
}

extension DetailViewController: DetailViewProtocol {
    func setComment(comment: Comment?) {
        if let safeComment = comment {
            detailLabel.text = safeComment.body
        }
    }
}


