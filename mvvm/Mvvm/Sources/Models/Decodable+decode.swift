//
//  Decodable+decode.swift
//  Models
//
//  Created by unagami on 2023/02/04.
//

import Foundation

extension Decodable {
    static func decode(json data: Data?) -> Self? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        return try? decoder.decode(Self.self, from: data)
    }
}
