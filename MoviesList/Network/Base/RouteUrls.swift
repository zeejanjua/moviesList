

enum Route: String {

    case popularMovies = "/popular"
    case movieDetails = "/"
    
    func url() -> String{
        return Constants.baseURL + self.rawValue
    }
}
