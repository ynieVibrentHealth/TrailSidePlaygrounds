//
//  TestHelper.swift
//  TrailsidePlaygroundTests
//
//  Created by Yuchen Nie on 4/8/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation

class TestHelper {
    static func readJSONObject<Type:Decodable>(from file:String) -> Type? {
        let bundle = Bundle(for: self)
        let decoder = JSONDecoder()
        guard let url = bundle.url(forResource: file, withExtension: "json"),
            let jsonData = try? Data(contentsOf:url),
            let mappedJSON = try? decoder.decode(Type.self, from:jsonData) else {return nil}
        return mappedJSON
    }
}
