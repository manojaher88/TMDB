//
//  Utils.swift
//  iOS
//
//  Created by admin on 6/29/20.
//

import Foundation


class Utils {
    
    static let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static let dateFormatter:  DateFormatter = {
        let datFormatter = DateFormatter()
        datFormatter.dateFormat = "yyyy-MM-dd"
        return datFormatter
    }()
    
    
    static let yearFormatter: DateFormatter = {
       let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "YYYY"
        return yearFormatter
    }()
    
}
