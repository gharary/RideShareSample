//
//  API.swift
//  SIXT_RideShare
//
//  Created by Mohammad Gharari on 7/16/21.
//

import Foundation
import Alamofire
import SwiftyJSON
class RideAPI {
    
    /// a singeleton model to communicate with server
    
    public static let sharedInstance = RideAPI()
    
    private init() { }
    
    /// a session manager for network configuration
    /// As we want to cache data to reduce number of calls to server while there is not new data
    /// and also a network monitor to monitor our requests
    let sessionManager:Session = {
        let configuration = URLSessionConfiguration.af.default
        
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        let responseCacher = ResponseCacher(behavior: .modify { _,response in
            let userInfo = ["date":Date()]
            return CachedURLResponse(response: response.response,
                                     data: response.data,
                                     userInfo: userInfo,
                                     storagePolicy: .allowed)
        })
        let networkLogger = NetworkLogger()
        let interceptor = APIRequestInterceptor()
        return Session(configuration:configuration,
                       interceptor: interceptor,
                       cachedResponseHandler: responseCacher,
                       eventMonitors: [networkLogger])
    }()
    
    
    /// the main `API` to communicate with server
    open func getData(completion:@escaping ([RideModel],String) -> Void) {
        
        let url = "https://cdn.sixt.io/codingtask/cars"
        let request = sessionManager.request(url,method: .get)
        NetworkManager.shared.handleAFrequest(request: request, completion: { [self] response in
            
            switch response {
            case .success(let data) :
                completion(buildRideModel(data: data), "")
            case .failure(let error):
                
                print(error.localizedDescription)
                completion([],error.localizedDescription)
            }

        })
        
    }
        
    open func buildRideModel(data:Data) -> [RideModel] {
        do {
            let decoder = JSONDecoder()
            let rides = try decoder.decode([RideModel].self, from: data)
            return rides
        } catch (let error) {
            print(error)
            return []
            
        }
    }
}



