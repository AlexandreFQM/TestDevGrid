//
//  TestGistsTests.swift
//  TestGistsTests
//
//  Created by Alexandre Furquim on 05/04/21.
//

import XCTest
@testable import TestGists

class TestGistsTests: XCTestCase {

    private let decoder = JSONDecoder()
    
    override func setUp() {
        super.setUp()

        decoder.dateDecodingStrategy = .iso8601
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testParseGistItemsTest() throws {
        let rawJson = """
[
    {
        "url": "https://api.github.com/gists/2401f1bd8316ce12e81552a6c6c4dbb1",
        "forks_url": "https://api.github.com/gists/2401f1bd8316ce12e81552a6c6c4dbb1/forks",
        "commits_url": "https://api.github.com/gists/2401f1bd8316ce12e81552a6c6c4dbb1/commits",
        "id": "2401f1bd8316ce12e81552a6c6c4dbb1",
        "node_id": "MDQ6R2lzdDI0MDFmMWJkODMxNmNlMTJlODE1NTJhNmM2YzRkYmIx",
        "git_pull_url": "https://gist.github.com/2401f1bd8316ce12e81552a6c6c4dbb1.git",
        "git_push_url": "https://gist.github.com/2401f1bd8316ce12e81552a6c6c4dbb1.git",
        "html_url": "https://gist.github.com/2401f1bd8316ce12e81552a6c6c4dbb1",
        "files": {
            "hello_world.js": {
                "filename": "hello_world.js",
                "type": "application/javascript",
                "language": "JavaScript",
                "raw_url": "https://gist.githubusercontent.com/AllenChenRR/2401f1bd8316ce12e81552a6c6c4dbb1/raw/be8ca1ba3493ed8be46dd055d42ac73105151f6a/hello_world.js",
                "size": 27
            },
            "hello_world_js.txt": {
                "filename": "hello_world_js.txt",
                "type": "text/plain",
                "language": "Text",
                "raw_url": "https://gist.githubusercontent.com/AllenChenRR/2401f1bd8316ce12e81552a6c6c4dbb1/raw/ccc14e1f6a157ec74106b89dd8734e6390341d10/hello_world_js.txt",
                "size": 46
            }
        },
        "public": true,
        "created_at": "2021-04-08T00:33:47Z",
        "updated_at": "2021-04-08T00:33:47Z",
        "description": "Hello World Examples",
        "comments": 0,
        "user": null,
        "comments_url": "https://api.github.com/gists/2401f1bd8316ce12e81552a6c6c4dbb1/comments",
        "owner": {
            "login": "AllenChenRR",
            "id": 18714525,
            "node_id": "MDQ6VXNlcjE4NzE0NTI1",
            "avatar_url": "https://avatars.githubusercontent.com/u/18714525?v=4",
            "gravatar_id": "",
            "url": "https://api.github.com/users/AllenChenRR",
            "html_url": "https://github.com/AllenChenRR",
            "followers_url": "https://api.github.com/users/AllenChenRR/followers",
            "following_url": "https://api.github.com/users/AllenChenRR/following{/other_user}",
            "gists_url": "https://api.github.com/users/AllenChenRR/gists{/gist_id}",
            "starred_url": "https://api.github.com/users/AllenChenRR/starred{/owner}{/repo}",
            "subscriptions_url": "https://api.github.com/users/AllenChenRR/subscriptions",
            "organizations_url": "https://api.github.com/users/AllenChenRR/orgs",
            "repos_url": "https://api.github.com/users/AllenChenRR/repos",
            "events_url": "https://api.github.com/users/AllenChenRR/events{/privacy}",
            "received_events_url": "https://api.github.com/users/AllenChenRR/received_events",
            "type": "User",
            "site_admin": false
        },
        "truncated": false
    }
]

""".data(using: .utf8)!

        //do
        let result = try! decoder.decode([GistsModelResponse].self, from: rawJson)

        //asset
        result.forEach{ print($0) }
    }
    
}
