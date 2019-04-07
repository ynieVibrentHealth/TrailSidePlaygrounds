//
//  HTTPWorker.swift
//  TrailsidePlayground
//
//  Created by Yuchen Nie on 4/7/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import Foundation
import Alamofire

class HTTPWorker {
    static let instance:HTTPWorker = HTTPWorker()
    private init(){}
    
    private let baseURL:String = "https://itunes.apple.com/"
    
    public func searchMovies(searchTerm:String, completion:@escaping ((_ response:Data?) -> Void)) {
        let searchParams:Parameters = ["term":searchTerm, "entity":"movie"]
        let searchURL = "\(baseURL)search"
        Alamofire.request(searchURL, parameters: searchParams).responseData { (response) in
            switch response.result {
            case .success(let value):
                completion(value)
            case .failure:
                completion(nil)
            }
        }
    }
}
