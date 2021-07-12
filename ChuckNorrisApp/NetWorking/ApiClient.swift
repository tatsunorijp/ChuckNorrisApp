//
//  ApiClient.swift
//  ChuckNorrisApp
//
//  Created by Tatsu on 10/07/21.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire

class ApiClient {
    
    static func getPosts(term: String) -> Observable<Facts> {
        return request(ApiRouter.getFacts(term: term))
    }

    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible)
                .validate()
                .responseDecodable(of: Facts.self) { response in
                    guard let facts = response.value as? T else { return observer.onCompleted() }
                observer.onNext(facts)
                observer.onCompleted()
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
