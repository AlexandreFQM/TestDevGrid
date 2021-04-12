//
//  ViewController.swift
//  TestGists
//
//  Created by Alexandre Furquim on 05/04/21.
//

import UIKit

protocol ViewControllerDelegate {
    func requestSuccess()
    func requestFailure()
    func itemSelected(id: String)
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scanQRCodeButton: UIButton!
    
    // MARK: - Private
    private var viewModel: ViewControllerViewModel?
    private var selectedID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewControllerViewModel(controllerDelegate: self, parentController: self)
        self.tableView.delegate = self.viewModel
        self.tableView.dataSource = self.viewModel
        
        let nib = UINib(nibName: "GistViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "ItemCell")
        
        
        setupUI()
        setupRequest()
        
    }
    
    private func setupUI() {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Gists"
        
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 140
        tableView.rowHeight = UITableView.automaticDimension
        
        scanQRCodeButton.layer.cornerRadius = 10
        
    }
    
    private func setupRequest() {
        viewModel?.getGistsPublic()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "detailSegue") {
            if let nextViewController = segue.destination as? DetailsGistItemViewController {
                let QrModel = QRData(codeString: selectedID)
                nextViewController.qrData = QrModel
            }
        }
    }
    
}

extension ViewController: ViewControllerDelegate {
    func itemSelected(id: String) {
        selectedID = id
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    func requestSuccess() {
        tableView.reloadData()
    }
    
    func requestFailure() {
        self.presentAlert(withTitle: "Oops!", message: "Error request. Please try again")
    }
    
    
}
