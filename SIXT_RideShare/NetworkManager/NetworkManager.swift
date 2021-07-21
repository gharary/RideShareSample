//
//  NetworkManager.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/18/21.
//

import Alamofire
import Foundation

class NetworkManager {
    
    /// Network manager class to handle the requests and error handling
    static let shared:NetworkManager = {
        return NetworkManager()
    }()
    typealias completionHandler = ((Result<Data, AFError>) ->Void)

    
    func handleAFrequest(request: DataRequest,completion: @escaping completionHandler) {
        
        
        
        /// print the request
        _ = request.debugLog()
        /// validate the request
        request.validate(statusCode: 200..<300)
        
        /// error handling of the request
        request.responseJSON { (response) in
           
            
            
            switch response.result {
            case .success(_):
                
                if let data = response.data {
                    completion(.success(data))
                }
                
            case .failure(let error):
                switch error {
                case .invalidURL(let url):
                    print("Invalid URL: \(url) - \(error.localizedDescription)")
                    completion(.failure(.invalidURL(url: url)))
                case .parameterEncodingFailed(let reason):
                    print("Parameter encoding failed: \(error.localizedDescription); reason:\(reason)")
                    
                    completion(.failure(.parameterEncodingFailed(reason: reason)))
                case .multipartEncodingFailed(let reason):
                    print("Multipart encoding failed: \(error.localizedDescription) Reason: \(reason)")
                    
                    completion(.failure(.multipartEncodingFailed(reason: reason)))
                case .responseValidationFailed(let reason):
                    
                    
                    print("Response validation failed: \(error.localizedDescription); Reason:\(reason)")
                    
                    completion(.failure(.responseValidationFailed(reason: reason)))
                    switch reason {
                    case .dataFileNil, .dataFileReadFailed:
                        print("Downloaded file could not be read")
                        completion(.failure(.responseValidationFailed(reason: .dataFileNil)))
                        
                    case .missingContentType(let acceptableContentTypes):
                        print("Content Type Missing: \(acceptableContentTypes)")
                        completion(.failure(.responseValidationFailed(reason:.missingContentType(acceptableContentTypes: acceptableContentTypes))))
                        
                    case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                        print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                        completion(.failure(.responseValidationFailed(reason:.unacceptableContentType(acceptableContentTypes: acceptableContentTypes, responseContentType: responseContentType))))
                        
                    case .unacceptableStatusCode(let code):
                        print("Response status code was unacceptable: \(code)")
                        completion(.failure(.responseValidationFailed(reason: .unacceptableStatusCode(code: code))))
                    case .customValidationFailed(error: let error):
                        print("Response Custom Validation Failed: \(error.localizedDescription)")
                        completion(.failure(.responseValidationFailed(reason: .customValidationFailed(error: error))))
                    }
                    
                case .responseSerializationFailed(let reason):
                    print("Response serialization failed: \(error.localizedDescription); Reason:\(reason)")
                    
                    completion(.failure(.responseSerializationFailed(reason: reason)))
                    break
               
                case .createUploadableFailed(error: let error):
                    completion(.failure(.createUploadableFailed(error: error)))
                case .createURLRequestFailed(error: let error):
                    completion(.failure(.createURLRequestFailed(error: error)))
                case .downloadedFileMoveFailed(error: let error, source: let source, destination: let destination):
                    completion(.failure(.downloadedFileMoveFailed(error: error, source: source, destination: destination)))
                case .explicitlyCancelled:
                    completion(.failure(.explicitlyCancelled))
                case .parameterEncoderFailed(reason: let reason):
                    completion(.failure(.parameterEncoderFailed(reason: reason)))
                case .requestAdaptationFailed(error: let error):
                    completion(.failure(.requestAdaptationFailed(error: error)))
                case .requestRetryFailed(retryError: let retryError, originalError: let originalError):
                    completion(.failure(.requestRetryFailed(retryError: retryError, originalError: originalError)))
                case .serverTrustEvaluationFailed(reason: let reason):
                    completion(.failure(.serverTrustEvaluationFailed(reason: reason)))
                case .sessionDeinitialized:
                    completion(.failure(.sessionDeinitialized))
                case .sessionInvalidated(error: let error):
                    completion(.failure(.sessionInvalidated(error: error)))
                case .sessionTaskFailed(error: let error):
                    completion(.failure(.sessionTaskFailed(error: error)))
                case .urlRequestValidationFailed(reason: let reason):
                    completion(.failure(.urlRequestValidationFailed(reason: reason)))
                }

            }
 
        }
    }
}
