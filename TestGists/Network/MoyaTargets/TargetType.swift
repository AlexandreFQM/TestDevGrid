//
//  TargetType.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation
import Moya
import KeychainSwift

public enum DGTargetType {
    case gistPublic(perPage: Int)
    case getGist(id: String)
    case getComment(id: String)
    case createComment(id: String, body: String)
}

extension DGTargetType: TargetType {
    
    public var baseURL: URL {
        return DataConfig.getEntryPoint()
    }
    
    public var path: String {
        switch self {
        case .gistPublic:
            return "/gists/public"
        case .getGist(let id):
            return "/gists/\(id)"
        case .getComment(let id):
            return "/gists/\(id)/comments"
        case .createComment(let id, _):
            return "/gists/\(id)/comments"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .gistPublic: return .get
        case .getGist: return .get
        case .getComment: return .get
        case .createComment: return .post
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .gistPublic(let perPage):
            return .requestParameters(parameters: ["per_page": perPage], encoding: URLEncoding.queryString)
        case .getGist, .getComment:
            return .requestPlain
            
        case .createComment(_, let body):
            return .requestParameters(parameters: ["body": body], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        
        let keychain = KeychainSwift()
        guard let token = keychain.get("tokenKey") else { return ["":""] }
        
        switch self {
        case .gistPublic, .getGist, .getComment, .createComment:
            let gistParams = ["Content-Type":"application/json", "Authorization": "Token " + token]
            return gistParams
        }
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}
