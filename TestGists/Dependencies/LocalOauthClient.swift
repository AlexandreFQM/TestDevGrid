//
//  LocalOauthClient.swift
//  TestGists
//
//  Created by Alexandre Furquim on 08/04/21.
//

import Foundation

class LocalOauthClient: OAuthClient {
    func exchangeCodeForToken(code: String, state: String, completion: @escaping (Result<TokenBag, Error>) -> Void) {
        completion(.success(TokenBag(accessToken: "anAccessToken")))
    }
    
    func getAuthPageUrl(state: String) -> URL? {
        let urlString = "https://codesandbox.io/s/affectionate-wind-wp72f"
        
        return URL(string: urlString)!
    }
}
