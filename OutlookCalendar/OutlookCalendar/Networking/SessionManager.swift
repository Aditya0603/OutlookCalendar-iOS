//
//  SessionManager.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/12/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit

/*
 Base URL session for our base networking class
 Used to set any authentication header
 and other certificate based authentication for web services- we dont have any yet :P
 */
class SessionManager {
    
    static let `default`: SessionManager = {
        let configuration = URLSessionConfiguration.default
        return SessionManager(configuration: configuration)
    }()
    
    let session: URLSession
    
    public init(configuration: URLSessionConfiguration = URLSessionConfiguration.default)
    {
        self.session = URLSession(configuration: configuration)
    }
    
    deinit {
        session.invalidateAndCancel()
    }
}
