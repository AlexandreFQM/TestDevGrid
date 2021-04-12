//
//  ViewControllerViewModel.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation
import UIKit

class ViewControllerViewModel: NSObject {
    
    private var model : [GistsModelResponse]?
    private let service = DGAPI()
    private var controllerDelegate: ViewControllerDelegate?
    private var parentController: ViewController
        
    // MARK: - Initialization
    public init(controllerDelegate: ViewControllerDelegate, parentController: ViewController) {
        self.controllerDelegate = controllerDelegate
        self.parentController = parentController
    }
    
    public func getGistsPublic() {
        
        service.getListGistPublic(perPage: 10) { (response) in
            switch response {
            case .success(let gist):
                self.model = gist
                self.parentController.requestSuccess()
            case .failure:
                self.parentController.requestFailure()
                
            }
        }
    }
}


extension ViewControllerViewModel: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = parentController.tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as? GistItemTableViewCell else {
            return UITableViewCell(style: .default, reuseIdentifier: "error")
        }
        
        if let item = model?[indexPath.row] {
            cell.configureCell(item: item)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let item = model?[indexPath.row] {
            self.parentController.itemSelected(id: item.id)
        }
    }
    
}
