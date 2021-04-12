//
//  AppDependencyContainer.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import Foundation
import UIKit

class AppDependencyContainer {
    let deepLinkHandler = DeepLinkHandler()
    
    func makeMainViewController() -> UIViewController {
        let redirectUri = URL(string: "br.com.alexandrefurquim.testgists://authentication")!
        let oAuthConfig = OAuthConfig(authorizationUrl: URL(string: "https://github.com/login/oauth/authorize")!,
                                      tokenUrl: URL(string: "https://github.com/login/oauth/access_token")!,
                                      clientId: "2ed1c454d39062bd93c0",
                                      clientSecret: "b45e04305e7c80de4656891641bbaf52aa92cec1",
                                      redirectUri: redirectUri,
                                      scopes: ["public", "gist"])
        let oAuthClient = RemoteOAuthClient(config: oAuthConfig, httpClient: HTTPClient())
        let oAuthService = OAuthService(oauthClient: oAuthClient)
        let deepLinkCallback: (DeepLink) -> Void = { deepLink in
            if case .oAuth(let url) = deepLink {
                oAuthService.exchangeCodeForToken(url: url)
            }
        }
        deepLinkHandler.addCallback(deepLinkCallback, forDeepLink: DeepLink(url: redirectUri)!)
        let loginVC = LoginViewController(oAuthService: oAuthService)
        let navigationController = UINavigationController(rootViewController: loginVC)
        return navigationController
    }
}
