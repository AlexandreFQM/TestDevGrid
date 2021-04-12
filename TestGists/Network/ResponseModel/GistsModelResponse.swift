//
//  GistsModelResponse.swift
//  TestGists
//
//  Created by Alexandre Furquim on 07/04/21.
//

import Foundation

// MARK: - GistsModelResponse
struct GistsModelResponse: Codable {
    let id: String
    let htmlURL: String
    let files: [String: Files]
    let isPublic: Bool
    let createdAt: String
    let description: String?
    let comments: Int
    let owner: Owner
    let truncated: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case htmlURL = "html_url"
        case files
        case isPublic = "public"
        case createdAt = "created_at"
        case description
        case comments, owner, truncated
    }
    
    func getFirstFileName() -> String {
        return Array(files)[0].key
    }
    
}

// MARK: - Files
struct Files: Codable {
    let filename, type: String?
    let language: String?
    let rawURL: String?
    let size: Int?
    
    enum CodingKeys: String, CodingKey {
        case filename, type, language
        case rawURL = "raw_url"
        case size
    }
}

// MARK: - Owner
struct Owner: Codable {
    let login: String
    let id: Int
    let avatarURL, htmlURL: String
    
    enum CodingKeys: String, CodingKey {
        case login, id
        case avatarURL = "avatar_url"
        case htmlURL = "html_url"
    }
}

