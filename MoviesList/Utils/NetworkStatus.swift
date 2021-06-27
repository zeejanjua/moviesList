
import UIKit
import Reachability
import NotificationBannerSwift


class NetworkStatus: NSObject {

    static var shareInstance : NetworkStatus?
    
    let reachability = try! Reachability()
    
    var statusBanner = StatusBarNotificationBanner(title: "")
    
    
    class func getNetworkManager()->NetworkStatus {
        
        if shareInstance == nil {
            
            shareInstance = NetworkStatus()
        }
        
        return shareInstance!
    }
    

   public func startNetworkReachabilityObserver() {
        
        //declare this property where it won't go out of scope relative to your listener
        
        //declare this inside of viewWillAppear
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do{
            try reachability.startNotifier()
        }catch{
            print("could not start reachability notifier")
        }
    }
    
    public func removeNetworkReachabilityObserver() {
        
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        let reachability = note.object as! Reachability
        
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            if statusBanner.isDisplaying {
            statusBanner.dismiss()
            }
            break
        case .cellular:
            print("Reachable via Cellular")
            if statusBanner.isDisplaying {
                statusBanner.dismiss()
            }
            break

        case .none,.unavailable:
            print("Network not reachable")
            statusBanner = StatusBarNotificationBanner(title: "No internet connection", style: .danger, colors: nil)
            statusBanner.show()
            statusBanner.autoDismiss = false
            break
        }
        
    }

    
}
