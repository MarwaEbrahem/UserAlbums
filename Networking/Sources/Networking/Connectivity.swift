//
//  File.swift
//  
//
//  Created by marwa on 1/03/2025.
//

import Foundation
import Alamofire

public struct Connectivity {

    private init() {}
    static let sharedInstance = NetworkReachabilityManager()!
    public static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}


