//
//  File.swift
//  
//
//  Created by 2B on 05/08/2024.
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


