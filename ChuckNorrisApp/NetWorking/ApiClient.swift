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
    
//    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
//        return RxAlamofire.request(urlConvertible).response
//    }

    
    private static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        return Observable<T>.create { observer in
            let request = AF.request(urlConvertible).responseJSON { (response: DataResponse) in

                switch response.result {
                case .success(let value):
                    print(value)
                    observer.onNext(value as! T)
                    observer.onCompleted()

                case .failure(let error):
                    switch response.response?.statusCode {
                    case 403:
                        observer.onError(ApiError.forbidden)
                    case 404:
                        observer.onError(ApiError.notFound)
                    case 409:
                        observer.onError(ApiError.conflict)
                    case 500:
                        observer.onError(ApiError.internalServerError)
                    default:
                        observer.onError(error)
                    }
                }
            }

            return Disposables.create {
                request.cancel()
            }
        }
    }
}
