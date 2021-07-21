//
//  EventMonitor.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//
//

import Alamofire
import Foundation
class NetworkLogger:EventMonitor {
    /// Event monitor, to monitor the requests
    let queue = DispatchQueue(label: "com.SIXT.networkLogger")
    
    func requestDidFinish(_ request: Request) {
        print(request.description)
    }
    
    func request(_ request: DataRequest, didParseResponse response: DataResponse<Data?, AFError>) {
        guard let data = response.data else {
            return
        }
        print(data)
        
    }
    
    func request(_ request: Request, didCompleteTask task: URLSessionTask, with error: AFError?) {
        debugPrint(request)
    }
}
