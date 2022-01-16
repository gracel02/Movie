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
}
