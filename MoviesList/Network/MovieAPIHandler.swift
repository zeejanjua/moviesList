
import UIKit
import Alamofire


class MovieAPIHandler: NSObject {
    static let instance = MovieAPIHandler()
    internal var apiManager = APIManagerBase()
    
    private override init() {
        super.init()
    }
}


//MARK: - All APIs
extension MovieAPIHandler {
    func getPopularMovies(parameters: Parameters?,
                  success:@escaping DefaultAPISuccessClosure,
                  failure:@escaping DefaultAPIFailureClosure){
        
        if let route = apiManager.getUrl(forRoute: Route.popularMovies.rawValue, params: parameters) {
            apiManager.getRequestWith(route: route as URL, success: success, failure: failure)
        }
    }
    
    func getMovieDetails(movieId: Int, parameters: Parameters?,
                  success:@escaping DefaultAPISuccessClosure,
                  failure:@escaping DefaultAPIFailureClosure){
        
        if let route = apiManager.getUrl(forRoute: Route.movieDetails.rawValue+movieId.description, params: parameters) {
            apiManager.getRequestWith(route: route as URL, success: success, failure: failure)
        }
    }
    
    func getVideos(movieId: Int, parameters: Parameters?,
                  success:@escaping DefaultAPISuccessClosure,
                  failure:@escaping DefaultAPIFailureClosure){
        let urlString = Route.movieDetails.rawValue+movieId.description+"/videos"
        if let route = apiManager.getUrl(forRoute: urlString, params: parameters) {
            apiManager.getRequestWith(route: route as URL, success: success, failure: failure)
        }
    }
    
}

