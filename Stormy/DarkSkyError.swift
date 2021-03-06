//
//  DarkSkyError.swift
//  Stormy
//
//  Created by Chris William Sehnert on 12/28/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import Foundation

enum DarkSkyError: Error {
    case requestFailed
    case responseUnsuccessful(statusCode: Int)
    case invalidData
    case jsonParsingFailure
    case invalidURL
}
