//
//  BaseAPI.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/12/19.
//

import Foundation
import Alamofire
import UIKit
import RxSwift


enum APIConstants {
    case xxx
    public var path: String {
        switch self {
        case .xxx: return "/api/v1/products"
        }
    }

   
    // MARK: Public Static Variables
    public static var baseURL = "https://suzuri.jp"

    public static var header: HTTPHeaders? {
        return [
            "Authorization": "Bearer sya-StGl4wbHoBCMRvp3iBVedVYlS06NZ04B_v5FO9Q"
        ]
    }
}
protocol BaseAPIProtocol {
    associatedtype ResponseType: Decodable

    var method: HTTPMethod { get }
    var baseURL: URL { get }
    var path: String { get }
    var headers: HTTPHeaders? { get }
    var decode: (Data) throws -> ResponseType { get }
}

extension BaseAPIProtocol {

    var baseURL: URL {
        return try! APIConstants.baseURL.asURL()
    }

    var headers: HTTPHeaders? {
        return APIConstants.header
    }

    var decode: (Data) throws -> ResponseType {
        return { try JSONDecoder().decode(ResponseType.self, from: $0) }
    }
}
protocol BaseRequestProtocol: BaseAPIProtocol, URLRequestConvertible {
    var parameters: Parameters? { get }
    var encoding: URLEncoding { get }
}

extension BaseRequestProtocol {
    var encoding: URLEncoding {
        return URLEncoding.default
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.headers = headers!
        urlRequest.timeoutInterval = TimeInterval(30)
        if let params = parameters {
            urlRequest = try encoding.encode(urlRequest, with: params)
        }
        return urlRequest
    }
}

//enum productRequest: BaseRequestProtocol {
//    typealias ResponseType = Test
//
//    case get
//
//    var method: HTTPMethod {
//        switch self {
//        case .get: return .get
//        }
//    }
//
//    var path: String {
//        return APIConstants.xxx.path
//    }
//
//    var parameters: Parameters? {
//        return nil
//    }
//}

