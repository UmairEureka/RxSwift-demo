//
//  ApiServices.swift
//  RxMVVM-TMDB
//
//  Created by Umair  on 06/11/2021.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit
import WebKit

class ApiServices {
    
    func getMovies(_ query: String) -> Observable<[Movie]> {
        
        return Observable.create { [weak self] observer in
            
            var url = ""
            var params = [(String,String)]()
            if query.count > 0 {
                url = Constants.movieSearchUrl
                params = [("query", query)]
            } else {
                url = Constants.popularListUrl
            }
            
            let request = self?.buildRequest(url: url, params: params)
            
            let session = URLSession.shared
            
            session.dataTask(with: request!) { data, response, error in

                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }

                if 200..<300 ~= response.statusCode {
                    do {
                        let decoder = JSONDecoder()
                        let movies = try decoder.decode(Movies.self, from: data)
                        observer.onNext(movies.listOfMovies ?? [])
                    } catch let newError {
                        print("An Error : \(newError)")
                        observer.onError(newError)
                    }
                } else {
                    print("Api fail with status code: \(response.statusCode)")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func getMovieDetail(_ movieID: Int) -> Observable<MovieDetail> {
        
        return Observable.create { [weak self] observer in
            
            let session = URLSession.shared
            let url = Constants.movieDetailUrl+String(movieID)
            let request = self?.buildRequest(url: url, params: [])

            session.dataTask(with: request!) { data, response, error in

                guard let data = data, error == nil, let response = response as? HTTPURLResponse else { return }

                if 200..<300 ~= response.statusCode {
                    do {
                        let decoder = JSONDecoder()
                        let movie = try decoder.decode(MovieDetail.self, from: data)
                        
                        observer.onNext(movie)
                        
                    } catch let error {
                        print("An Error : \(error)")
                        observer.onError(error)
                    }
                } else {
                    print("Api fail with status code: \(response.statusCode)")
                }
                observer.onCompleted()
            }.resume()
            
            return Disposables.create {
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    private func buildRequest(method: String = "GET", url: String, params: [(String, String)]) -> URLRequest {
        let url = URL(string: url)!
        var request = URLRequest(url: url)
        let keyQueryItem = URLQueryItem(name: "api_key", value: Constants.apiKey)
        let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        
        if method == "GET" {
            var queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
            queryItems.append(keyQueryItem)
            urlComponents.queryItems = queryItems
        } else {
            urlComponents.queryItems = [keyQueryItem]
            
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
            request.httpBody = jsonData
        }
        
        request.url = urlComponents.url!
        request.httpMethod = method
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
}


