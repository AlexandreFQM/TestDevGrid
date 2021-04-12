//
//  DetailsGistItemViewController.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import UIKit
import WebKit

protocol DetailsGistItemViewControllerDelegate {
    func requestSuccess(model : GistsModelResponse?)
    func requestCommentSuccess()
    func requestCommentCreateSuccess()
    func requestFailure()
}

class DetailsGistItemViewController: UIViewController {
    
    @IBOutlet weak var contentFileView: WKWebView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var commentButton: UIButton!
    
    // MARK: - Private
    private var viewModel: DetailGistViewModel?
    var qrData: QRData?
    var model : [GistsModelResponse]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = DetailGistViewModel(controllerDelegate: self, parentController: self)
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        let nib = UINib(nibName: "GistCommentViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        
        setupUI()
        setupRequest()
    }
    
    private func setupUI() {
    
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 105
        tableView.rowHeight = UITableView.automaticDimension
        
        commentButton.layer.cornerRadius = 10
    }
    
    private func setupRequest() {
        if let gistID = qrData?.codeString {
            viewModel?.getGistsPublic(gistID: gistID)
            viewModel?.getGistComment(gistID: gistID)
        }
    }
    
    private func presentAlertFailure(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tappedCreateCommentButton(_ sender: Any) {
        
        if let gistID = qrData?.codeString {
            if let text = commentTextField.text, !text.isEmpty {
                viewModel?.createComment(gistID: gistID, bodyString: text)
            }else{
                self.presentAlert(withTitle: "Oops!", message: "The field comment is required.")
            }
        }
    }
    
    
}

extension DetailsGistItemViewController: DetailsGistItemViewControllerDelegate {
    func requestCommentSuccess() {
        tableView.reloadData()
    }
    
    func requestCommentCreateSuccess() {
        
        commentTextField.text = ""
        
        if let gistID = qrData?.codeString {
            viewModel?.getGistComment(gistID: gistID)
        }
        
        tableView.reloadData()
    }
    
    func requestSuccess(model: GistsModelResponse?) {
        
        let file = Array(model!.files)[0].value

        if let rawValue = file.rawURL {
            contentFileView.load(URLRequest(url: URL(string: rawValue)!))
        }
        
        self.navigationItem.title = file.filename
        
    }
    
    func requestFailure() {
        self.presentAlertFailure(withTitle: "Error", message: "Gists not found. Please try again")
    }
    
    
}
