//
//  NetworkHelper.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 11.04.2024.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum ErrorTypes: String, Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
    case generalError = "An Error Happend"
}

struct NetworkHelper {
    
    static let shared = NetworkHelper()

    private let BASE_URL = "https://65c38b5339055e7482c12050.mockapi.io/api/"
    
    enum Api {
        case products
        case suggestedProducts
        
        var endPoint: String {
            switch self {
            case .products:
                return NetworkHelper.shared.BASE_URL + "products"
            case .suggestedProducts:
                return NetworkHelper.shared.BASE_URL + "suggestedProducts"
            }
        }
        
        var method: HTTPMethods {
            switch self {
                ///use post, put and delete for http request method
            default:
                ///default https method is get
                return .get
            }
        }
    }
}
