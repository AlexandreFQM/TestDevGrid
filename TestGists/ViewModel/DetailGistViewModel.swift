//
//  DetailGistViewModel.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import Foundation
import UIKit

class DetailGistViewModel: NSObject {
    
    private var model : GistsModelResponse?
    private var modelComment : [GistsCommentModelResponse]?
    private let service = DGAPI()
    private var controllerDelegate: DetailsGistItemViewControllerDelegate?
    private var parentController: DetailsGistItemViewController
    
    
    // MARK: - Initialization
    public init(controllerDelegate: DetailsGistItemViewControllerDelegate, parentController: DetailsGistItemViewController) {
        self.controllerDelegate = controllerDelegate
        self.parentController = parentController
    }
    
    public func getGistsPublic(gistID: String) {
        service.getGist(id: gistID) { (response) in
            switch response {
            case .success(let gist):
                self.model = gist
                self.parentController.requestSuccess(model: self.model)
            case .failure:
                self.parentController.requestFailure()
                
            }
        }
        
    }
    
    public func getGistComment(gistID: String) {
        
        service.getGistComment(id: gistID) { (response) in
            switch response {
            case .success(let gist):
                self.modelComment = gist
                self.parentController.requestCommentSuccess()
            case .failure:
                self.parentController.requestFailure()
            }
        }
    }
    
    public func createComment(gistID: String, bodyString: String) {
        service.createGistComment(id: gistID, body: bodyString) { (response) in
            switch response {
            case .success(let gist):
                print(gist)
                self.modelComment?.append(gist)
                self.parentController.requestCommentCreateSuccess()
            case .failure:
                self.parentController.requestFailure()
            }
        }
    }
    
}


extension DetailGistViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelComment?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parentController.tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? GistCommentTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "error")
        }
        
        if let item = modelComment?[indexPath.row] {
            cell.configureCell(item: item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        if let item = modelComment?[indexPath.row] {
            print(item.body)
        }
        
    }
    
}
