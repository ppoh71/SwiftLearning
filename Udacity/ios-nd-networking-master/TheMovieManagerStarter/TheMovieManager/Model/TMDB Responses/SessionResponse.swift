//
//  SessionResponse.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

struct SessionResponse: Codable{
    let success: Bool
    let sessionId: String
    
    enum CodingKeys: String, CodingKey{
        case success
        case sessionId = "session_id"
    }
}

struct SessionResponseError: Codable{
    let statusMessage: String
    let statusCode: Int
    
    enum CodingKeys: String, CodingKey{
        case statusMessage = "status_message"
        case statusCode = "status_code"
    }
}
