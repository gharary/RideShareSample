//
//  NetworkManager+RequestInterceptor.swift
//  AFRetryRequest
//


import Alamofire
import Foundation
class APIRequestInterceptor: RequestInterceptor {
    /// network interceptor for attaching `token` to the network calls if needed
    /// and retry for the times the request fails
    let retryLimit = 2
    let retryDelay:TimeInterval = 5
    
    
    func retry(_ request: Request, for session: Session, dueTo error: Error,
               completion: @escaping (RetryResult) -> Void) {
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        completion(.retryWithDelay(retryDelay))
    }
        
}
extension Request {
    public func debugLog() -> Self {
        //#if DEBUG
        debugPrint(self)
        cURLDescription(calling: { (curl) in
            debugPrint("=======================================")
            print(curl)
            debugPrint("=======================================")
        })
        //#endif
        return self
    }
}
