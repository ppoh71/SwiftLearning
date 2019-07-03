//
//  TMDBClient.swift
//  TheMovieManager
//
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.
//

import Foundation

class TMDBClient {
    
    static let apiKey = "396a01453e6a340aacd98d786f14e6f4"
    
    struct Auth {
        static var accountId = 0
        static var requestToken = ""
        static var sessionId = ""
    }
    
    enum Endpoints {
        static let base = "https://api.themoviedb.org/3"
        static let apiKeyParam = "?api_key=\(TMDBClient.apiKey)"
        
        case getWatchlist
        case markWatchlist
        case getFavorites
        case markFavorite
        case getSearch(value: String)
        case requestToken
        case login
        case createSessionId
        case webauth
        case logout
        case getPosterImageUrl(value: String)
        
        var stringValue: String {
            switch self {
            case .getWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .markWatchlist: return Endpoints.base + "/account/\(Auth.accountId)/watchlist" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getFavorites: return Endpoints.base + "/account/\(Auth.accountId)/favorite/movies" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .markFavorite: return Endpoints.base + "/account/\(Auth.accountId)/favorite" + Endpoints.apiKeyParam + "&session_id=\(Auth.sessionId)"
            case .getSearch(let query): return Endpoints.base + "/search/movie" + Endpoints.apiKeyParam + "&query=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
            case .requestToken:
                return Endpoints.base + "/authentication/token/new" + "\(Endpoints.apiKeyParam)"
            case .login:
                return Endpoints.base + "/authentication/token/validate_with_login" + "\(Endpoints.apiKeyParam)"
            case .createSessionId:
                return Endpoints.base + "/authentication/session/new" + Endpoints.apiKeyParam
            case .webauth:
                return "https://www.themoviedb.org/authenticate/" + Auth.requestToken + "?redirect_to:themoviewmanager:authenticate"
            case .logout:
                return Endpoints.base + "/authentication/session" + Endpoints.apiKeyParam
            case .getPosterImageUrl(let moviePath):
                return "https://image.tmdb.org/t/p/w500/\(moviePath)"
            }
        }
        
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func taskForGETRquest<ResponseType: Codable>(url: URL, responseType: ResponseType.Type, completion: @escaping (ResponseType?, Error?)->Void ) -> URLSessionTask{
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do {
                let responseObject = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            } catch {
                do{
                    let errorMessage = try JSONDecoder().decode(TMDBResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorMessage)
                    }
                }catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
        return task
    }
    
    class func taskForPOSTRequest<RequestType: Encodable, ResponseType: Decodable>(url: URL, responseType: ResponseType.Type, body: RequestType, completion: @escaping (ResponseType?, Error?) -> Void){
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try! JSONEncoder().encode(body)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print ("no login response data")
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            let decoder = JSONDecoder()
            do{
                let response = try decoder.decode(ResponseType.self, from: data)
                DispatchQueue.main.async {
                    completion(response, nil)
                }
            }catch{
                do{
                    let errorMessage = try JSONDecoder().decode(TMDBResponse.self, from: data)
                    DispatchQueue.main.async {
                        completion(nil, errorMessage)
                    }
                }catch{
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
        task.resume()
    }
    
    class func getWatchlist(completion: @escaping ([Movie], Error?) -> Void) {
        let task = taskForGETRquest(url: Endpoints.getWatchlist.url, responseType: MovieResults.self) { (response, error) in
            if let response = response{
                completion(response.results, nil)
            }else{
                completion([], error)
            }
        }
    }
    
    class func markWatchlist(mediaId: Int, wachtlist: Bool, completion: @escaping (Bool, Error?) -> Void){
        let requestBody = MarkWatchlist(mediaType: "movie", mediaId: mediaId, watchlist: wachtlist)
        taskForPOSTRequest(url: TMDBClient.Endpoints.markWatchlist.url, responseType: TMDBResponse.self, body: requestBody) { (response, error) in
            if let response = response{
                print("markWatchlist success")
                print(response.statusCode)
                completion(response.statusCode==1 || response.statusCode==12 || response.statusCode==13 ,nil)
            }else{
                completion(false, error)
            }
        }
    }
    
    class func getFavorites(completion: @escaping ([Movie], Error?) -> Void) {
         let task = taskForGETRquest(url: Endpoints.getFavorites.url, responseType: MovieResults.self) { (response, error) in
            if let response = response{
                completion(response.results, nil)
            }else{
                completion([], error)
            }
        }
    }
    
    class func markFavorite(mediaId: Int, favorite: Bool, completion: @escaping (Bool, Error?) -> Void){
        let requestBody = MarkFavorite(mediaType: "movie", mediaId: mediaId, favorite: favorite)
        taskForPOSTRequest(url: TMDBClient.Endpoints.markFavorite.url, responseType: TMDBResponse.self, body: requestBody) { (response, error) in
            if let response = response{
                print("markFavorite success")
                print(response.statusCode)
                completion(response.statusCode==1 || response.statusCode==12 || response.statusCode==13 ,nil)
            }else{
                completion(false, error)
            }
        }
    }
    
    class func search(query: String, completion: @escaping ([Movie], Error?)->Void) -> URLSessionTask{
         let task = taskForGETRquest(url: Endpoints.getSearch(value: query).url, responseType: MovieResults.self) { (response, error) in
            if let response = response{
                completion(response.results, nil)
            }else{
                completion([], error)
            }
        }
        return task
    }
    
    class func getRequestToken(completion: @escaping (Bool, Error?) -> Void){
        _ = taskForGETRquest(url: TMDBClient.Endpoints.requestToken.url, responseType: RequestToken.self) { (response, error) in
            if let response = response{
                Auth.requestToken = response.requestToken
                print(response.requestToken)
                completion(true, nil)
            }else{
                completion(false, error)
            }
        }
        
    }
    
    class func login(username: String, password: String, completion: @escaping  (Bool, Error?) -> Void){
        let loginBody = LoginRequest(username: "ppoh71", password: "ingning", requestToken: Auth.requestToken)
        taskForPOSTRequest(url: TMDBClient.Endpoints.login.url, responseType: RequestToken.self, body: loginBody) { (response, error) in
            if let response = response{
                 Auth.requestToken = response.requestToken
                 print(response.requestToken)
                 completion(true, nil)
            }else{
                 completion(false, error)
            }
        }
    }
    
    class func newSessionId(completion: @escaping (Bool, Error?) -> Void) {
        let loginBody = LoginRequest(username: "ppoh71", password: "ingning", requestToken: Auth.requestToken)
        taskForPOSTRequest(url: TMDBClient.Endpoints.createSessionId.url, responseType: SessionResponse.self, body: loginBody) { (response, error) in
            if let response = response{
                print("sessoin success")
                print(response.sessionId)
                Auth.sessionId = response.sessionId
                completion(true, nil)
            }else{
                 print("session failed")
                completion(false, error)
            }
        }
//       before refactored to generic function taskForPOSTRequest()
//
//        var request = URLRequest(url: TMDBClient.Endpoints.createSessionId.url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        let loginBody = LoginRequest(username: "ppoh71", password: "ingning", requestToken: Auth.requestToken)
//        request.httpBody = try! JSONEncoder().encode(loginBody)
//
//        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else {
//                print ("no session id response data")
//                completion(false, error)
//                return
//            }
//            let decoder = JSONDecoder()
//            do{
//                let response = try decoder.decode(SessionResponse.self, from: data)
//                Auth.sessionId = response.sessionId
//                completion(true, nil)
//            }catch{
//                print("session id request failed")
//                let response = try! decoder.decode(SessionResponseError.self, from: data)
//                print(response)
//                completion(false, error)
//            }
//        }
//        task.resume()
    }
    
    class func logout(completion: @escaping (Bool?, Error?) -> Void){
        var request = URLRequest(url: TMDBClient.Endpoints.logout.url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let logoutBody = LogoutRequest(sessionId: Auth.sessionId)
        request.httpBody = try! JSONEncoder().encode(logoutBody)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                print ("no session id response data")
                completion(false, error)
                return
            }
            
            print("session logout success, probably \(data)")
        }
        task.resume()
    }
    
    class func downloadPosterImage(posterPath: String?, completion: @escaping (Data?, Error?) -> Void){
        if let posterPath = posterPath{
            let url = Endpoints.getPosterImageUrl(value: posterPath).url
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data else {
                    print("no image data")
                    return
                }
                DispatchQueue.main.async {
                    completion(data, nil)
                }
            }
            task.resume()
        } else{
            print("no posterPath")
        }
    }
    
}
