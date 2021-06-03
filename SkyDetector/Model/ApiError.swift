//
//  ApiError.swift
//  SkyDetector
//
//  Created by 송하민 on 2021/06/03.
//

import Foundation

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invaildResponse
    case failed(Int)
    case emptyData
}
