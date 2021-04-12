//
//  LoginViewController.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import UIKit
import SafariServices
import KeychainSwift

class LoginViewController: UIViewController {
    let oAuthService: OAuthService
    init(oAuthService: OAuthService) {
        self.oAuthService = oAuthService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        oAuthService.onAuthenticationResult = { [weak self] in self?.onAuthenticationResult(result: $0) }
    }
    
    @IBAction func onLoginClick(_ sender: Any) {
        guard let url = oAuthService.getAuthPageUrl(state: "state") else { return }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.modalPresentationStyle = .fullScreen
        present(safariVC, animated: true, completion: nil)
    }
    
    func onAuthenticationResult(result: Result<TokenBag, Error>) {
        DispatchQueue.main.async {
            self.presentedViewController?.dismiss(animated: true) {
                switch result {
                case .success(let tokenBag):
                    
                    let keychain = KeychainSwift()
                    keychain.set(tokenBag.accessToken, forKey: "tokenKey")                    
                                        
                    if let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController") as? ViewController {
                        let navigation  = UINavigationController(rootViewController:viewController)
                        navigation.modalPresentationStyle = .fullScreen
                        self.present(navigation, animated: true, completion: nil)
                    }                                    
                case .failure:
                    let alert = UIAlertController(title: "Something went wrong :(",
                                                  message: "Authentication error",
                                                  preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
}
