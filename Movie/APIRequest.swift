//
//  APIRequest.swift
//  Movie
//
//  Created by Grace Liaw on 15/1/22.
//

import Foundation

enum ResponseError: Error, CustomNSError {
    
    case apiError
    case invalidResponse
    case noData
    case serializationError
    case serverError(statusCode: Int)

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        case .serverError(statusCode: let statusCode):
            return "Server Error \(statusCode)"
        }
    }
    
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}

class APIRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func callRequest(completionHandler: @escaping (Result<MovieResponse, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                print("Error with fetching films: \(error)")
                completionHandler(.failure(ResponseError.apiError))
                return
            }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                print("Error with the response, unexpected status code: \(response.description)")
                completionHandler(.failure(ResponseError.serverError(statusCode: response.statusCode)))
                return
            }
            
            if let data = data,
               let movieResponse = try? JSONDecoder().decode(MovieResponse.self, from: data) {
                print("Successfully retrieve movie response: \(movieResponse)")
                completionHandler(.success(movieResponse))
            }
        })
        task.resume()
    }
    /*
    /// Get movies list form the Movie API
    /// - Parameters:
    ///   - page: index of movie page to fetch
    ///   - completion: `Result` of request returning `MoviesResponce` on success or `Error` on failure
    func fetchMovies(page: Int, completion: @escaping (Result<MoviesResponce, Error>) -> ()) {
        AF.request(baseAPIURL + "/discover/movie?api_key=" + APIKEY + "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(page)&with_watch_monetization_types=flatrate").responseDecodable(of: MoviesResponce.self) { responce in
            debugPrint("responce")
            guard let movies = responce.value else {
                if let error = responce.error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(movies))
        }
        
    }
    */
    
    /*
    func fetchMovies(from endpoint: MovieListEndpoint, completion: @escaping (Result<MovieResponse, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseAPIURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.loadURLAndDecode(url: url, completion: completion)
    }
    */
}
