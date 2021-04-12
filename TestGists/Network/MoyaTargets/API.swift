//
//  DGAPI.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation
import Moya
import Result

public class DGAPI {
    
    public init() {}
    
    let provider: MoyaProvider<DGTargetType> = MoyaProvider(plugins: [NetworkLoggerPlugin()])
    
    func getListGistPublic(perPage: Int, completionHandler: @escaping(Result<[GistsModelResponse], NetworkError>)->Void) {
        self.provider.request(.gistPublic(perPage: perPage)) { result in
            switch result {
            case .success(let response):
                do {                                    
                    let gistResponse = try response.map([GistsModelResponse].self)
                    completionHandler(.success(gistResponse))
                } catch {
                    completionHandler(.failure(.badJSONFormat))
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }

    func getGist(id: String, completionHandler: @escaping(Result<GistsModelResponse, NetworkError>)->Void) {
        self.provider.request(.getGist(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let gistResponse = try response.map(GistsModelResponse.self)
                    completionHandler(.success(gistResponse))
                } catch {
                    completionHandler(.failure(.badJSONFormat))
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }
    
    func getGistComment(id: String, completionHandler: @escaping(Result<[GistsCommentModelResponse], NetworkError>)->Void) {
        self.provider.request(.getComment(id: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let gistResponse = try response.map([GistsCommentModelResponse].self)
                    completionHandler(.success(gistResponse))
                } catch {
                    completionHandler(.failure(.badJSONFormat))
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }
    
    func createGistComment(id: String, body: String, completionHandler: @escaping(Result<GistsCommentModelResponse, NetworkError>)->Void) {
        self.provider.request(.createComment(id: id, body: body)) { result in
            switch result {
            case .success(let response):
                do {
                    let gistResponse = try response.map(GistsCommentModelResponse.self)
                    completionHandler(.success(gistResponse))
                } catch {
                    completionHandler(.failure(.badJSONFormat))
                }
            case .failure:
                completionHandler(.failure(.unknownError))
            }
        }
    }

    
}
