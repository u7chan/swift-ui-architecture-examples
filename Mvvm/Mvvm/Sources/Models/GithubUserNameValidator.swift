//
//  GithubUserNameValidator.swift
//  Models
//
//  Created by unagami on 2023/02/05.
//

import Foundation

func githubUserNameValidator(_ userName: String) -> Bool {
    let maxSize = 39
    let pattern = "^[a-zA-Z0-9]([a-zA-Z0-9]?|[\\-]?([a-zA-Z0-9])){0,\(maxSize - 1)}$"
    guard let regex = try? NSRegularExpression(pattern: pattern) else { return true }
    let matcher = regex.matches(in: userName, range: NSRange(location: 0, length: userName.count))
    return matcher.count == 0
}
