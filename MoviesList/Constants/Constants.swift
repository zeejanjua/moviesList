
import UIKit

struct Constants {
    
    static let appName = "MovieList"
    static let bundleId = "com.app.movieslist"
    
    static let movieApiKey = "1e70f212d75652ddfacad7333158ec40"
    
    /** BASE URL */
    static let baseURL = "https://api.themoviedb.org/3/movie"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500/"
    
}


enum Strings: String {
   
    case error = "Error!"
    
    //MARK: - Error Messages
    case noRecords = "Sorry!, we couldn't find any movie"
    case noNetwork = "no_network"
    case timeOut = "time_out"
    case errorOccured = "error_occured"
    case badRequest = "bad_request"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: self.rawValue)
    }
}


struct ErrorMessage {
    private init() {}
    
    static let network = NeworkAlerts()
}


struct NeworkAlerts {
    fileprivate init() {}
    
    var noNetwork: String {
        return Strings.noNetwork.localized
    }
    var timeOut: String {
        return Strings.timeOut.localized
    }
    var errorOccured: String {
        return Strings.errorOccured.localized
    }
    var badRequest: String {
        return Strings.badRequest.localized
    }
}
