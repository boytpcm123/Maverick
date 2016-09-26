//
//  Networking.swift
//  Maverick
//
//  Created by Huy Pham on 4/2/15.
//  Copyright (c) 2015 Huy Pham. All rights reserved.
//

class Networking {
  fileprivate let requestManager = AFHTTPSessionManager()
  
  init() {
    let securityPolicy = AFSecurityPolicy(pinningMode: AFSSLPinningMode.none)
    securityPolicy.validatesDomainName = false
    self.requestManager.securityPolicy = securityPolicy
    self.requestManager.requestSerializer = AFJSONRequestSerializer()
    self.requestManager.responseSerializer = AFJSONResponseSerializer()
  }
  
  class func setNetworkHeader() {
    let networkHeaders: [String: String] = [
      "Content-Type": "application/json",
      "X-Maverick-Client": Constant.clientId,
      "X-App-Build": "\(Constant.appBuild)",
    ]
    for key in networkHeaders.keys {
      let value = networkHeaders[key]
      Global.networking.requestManager.requestSerializer.setValue(value,
                                                                  forHTTPHeaderField: key)
    }
  }
  
  class func handleStatus(_ status: Int) {
    switch status {
    case 401:
      // Handle login
      break
    case 417:
      // handle update
      break
    default:
      break
    }
  }
  
  func get(_ url: String, parameters: Any?,
           handler:@escaping ((_ responseObject: Result<Any>) -> Void)) -> URLSessionDataTask? {
    let task = self.requestManager.get(url, parameters: parameters, progress: nil, success: { (task, response) -> Void in
      handler(Result.success(response))
    }) { (taskOp, error) -> Void in
      if let task = taskOp, let reponse = task.response as? HTTPURLResponse {
        Networking.handleStatus(reponse.statusCode)
        handler(Result.failure(reponse.statusCode))
        return
      }
      handler(Result.failure(-1))
    }
    return task
  }
  
  func post(_ url: String, parameters: Any?,
            handler:@escaping ((_ responseObject: Result<Any>) -> Void)) -> URLSessionDataTask? {
    let task = self.requestManager.post(url, parameters: parameters, progress: nil, success: { (task, response) -> Void in
      handler(Result.success(response))
    }) { (taskOp, error) -> Void in
      if let task = taskOp, let reponse = task.response as? HTTPURLResponse {
        Networking.handleStatus(reponse.statusCode)
        handler(Result.failure(reponse.statusCode))
        return
      }
      handler(Result.failure(-1))
    }
    return task
  }
  
  func put(_ url: String, parameters: Any?,
           handler:@escaping ((_ responseObject: Result<Any>) -> Void)) -> URLSessionDataTask? {
    let task = self.requestManager.put(url, parameters: parameters, success: { (task, response) -> Void in
      handler(Result.success(response))
    }) { (taskOp, error) -> Void in
      if let task = taskOp, let reponse = task.response as? HTTPURLResponse {
        Networking.handleStatus(reponse.statusCode)
        handler(Result.failure(reponse.statusCode))
        return
      }
      handler(Result.failure(-1))
    }
    return task
  }
  
  func delete(_ url: String, parameters: Any?,
              handler:@escaping ((_ responseObject: Result<Any>) -> Void)) -> URLSessionDataTask? {
    let task = self.requestManager.delete(url, parameters: parameters, success: { (task, response) -> Void in
      handler(Result.success(response))
    }) { (taskOp, error) -> Void in
      if let task = taskOp, let reponse = task.response as? HTTPURLResponse {
        Networking.handleStatus(reponse.statusCode)
        handler(Result.failure(reponse.statusCode))
        return
      }
      handler(Result.failure(-1))
    }
    return task
  }
  
  func upload(_ data: Data, parameters: NSDictionary, url: String,
              progress:(UInt, CLongLong, CLongLong) -> Void, completion:@escaping (Result<Any>) -> Void) -> URLSessionDataTask? {
    let task = self.requestManager.post(url, parameters: parameters, constructingBodyWith: { (formData) -> Void in
      formData.appendPart(withFileData: data, name: "files",
                          fileName: "image.jpg", mimeType: "image/jpeg")
      }, progress: { (progress) -> Void in
      }, success: { (task, reponse) -> Void in
        completion(Result.success(reponse))
    }) { (taskOp, error) -> Void in
      if let task = taskOp, let reponse = task.response as? HTTPURLResponse {
        Networking.handleStatus(reponse.statusCode)
        completion(Result.failure(reponse.statusCode))
        return
      }
      completion(Result.failure(-1))
    }
    return task
  }
  
  func isTaskExisted(_ identifier: Int) -> Bool {
    for task in self.requestManager.dataTasks {
      if task.taskIdentifier == identifier {
        return true
      }
    }
    return false
  }
  
  func cancelAllTasks() {
    for task in self.requestManager.dataTasks {
      task.cancel()
    }
  }
  
  func cancelTask(_ identifier: Int) {
    for task in self.requestManager.dataTasks {
      if task.taskIdentifier == identifier {
        task.cancel()
      }
    }
  }
}
