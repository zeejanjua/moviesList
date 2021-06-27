import UIKit
import Alamofire

typealias DefaultAPIFailureClosure = (Error) -> Void
typealias DefaultAPISuccessClosure = ([String: Any]) -> Void


class APIManagerBase: NSObject {
    
    func getHeaders () -> HTTPHeaders {
        return ["Content-Type":"application/json"]
    }
    
    func getUrl(forRoute route: String, params:Parameters? = nil) -> URL? {
        if let components: NSURLComponents  = NSURLComponents(string: (Constants.baseURL+route)){
            if let params = params {
                var queryItems = [URLQueryItem]()
                for (key,value) in params {
                    queryItems.append(URLQueryItem(name:key,value: value as? String))
                }
                components.queryItems = queryItems
            }
            
            return components.url
        }
        return nil
    }
}

extension APIManagerBase {
    func showErrorMessage(error: Error){
        
        switch (error as NSError).code {
            
        case -1001:
            Utility.showAlert(title: Strings.error.localized, message: ErrorMessage.network.timeOut)
        case -1009:
            Utility.showAlert(title: Strings.error.localized, message: ErrorMessage.network.noNetwork)
        case -1005:
            Utility.showAlert(title: Strings.error.localized, message: ErrorMessage.network.noNetwork)
        default:
            Utility.showAlert(title: Strings.error.localized, message: (error as NSError).localizedDescription)
            
        }
    }
    
}

extension APIManagerBase {
    func getRequestWith(route: URL,
                        success:@escaping DefaultAPISuccessClosure,
                        failure:@escaping DefaultAPIFailureClosure){
        
        AF.request(route, method:.get, parameters: nil,encoding: JSONEncoding.default, headers: getHeaders()) .responseJSON { (response) in
                print(response)
            switch response.result {
            case .success:
                
                if let responseValue = response.value as? [String: Any] {
                    
                    if let _ = responseValue["results"] as? [[String: Any]] {
                        success(responseValue)
                    }
                    else if let errorMessaage = responseValue["status_message"] as? String  {
                        let userInfo: [String : Any] = [
                            NSLocalizedDescriptionKey : errorMessaage,
                            NSLocalizedFailureReasonErrorKey : errorMessaage
                        ]
                        
                        let error = NSError(domain: Constants.bundleId, code: 503, userInfo: userInfo)
                        failure(error)
                    }
                    else {
                        success(responseValue)
                    }
                }
                else {
                    let userInfo: [String : Any] = [
                        NSLocalizedDescriptionKey : Strings.errorOccured.localized,
                        NSLocalizedFailureReasonErrorKey : Strings.errorOccured.localized
                    ]
                    
                    let error = NSError(domain: Constants.bundleId, code: 500, userInfo: userInfo)
                    failure(error)
                }
                
            case .failure(let error):
                failure(error)
            }
        }
    }
}



