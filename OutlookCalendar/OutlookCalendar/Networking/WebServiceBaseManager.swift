//
//  WebServiceBaseManager.swift
//  OutlookCalendar
//
//  Created by Aditya Sinha on 12/12/17.
//  Copyright © 2017 Aditya Sinha. All rights reserved.
//

import UIKit


/*
 Completion block type definition
 */
public typealias OperationCompletionHandler = (Data?, Error?) -> Void


/*
 Base networking class to create all web service requests
 */
class WebServiceBaseManager: NSObject {
    // Single ton object of the base networking class
    static let `default`: WebServiceBaseManager = {
        return WebServiceBaseManager()
    }()
    
    var completionHandler : OperationCompletionHandler!
    
    func sendRequest(request : URLRequest? ,onCompletion compHandler : @escaping OperationCompletionHandler){
        completionHandler = compHandler
        // if no request object return completion with custom error
        guard let request = request else {
            DispatchQueue.main.async {
                self.completionHandler(nil, self.getError())
            }
            return
        }
        let task1 = SessionManager.default.session.dataTask(with: request as URLRequest) {
            data, response, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.completionHandler(data, nil)
                }
            }
            else {
                DispatchQueue.main.async {
                    self.completionHandler(nil, error)
                }
            }
        }
        task1.resume()
    }
    private func getError() -> Error {
        let errorMessage = "Something Went Wrong"
        let error = NSError(domain: "", code: 123, userInfo: [NSLocalizedDescriptionKey: errorMessage])
        return error as Error
    }
}
