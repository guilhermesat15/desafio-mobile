//
//  NetworkManager.swift
//  GuilhermeTestApp
//
//  Created by Guilherme Sathler on 16/12/21.
//

import Foundation

class NetworkManager
{
    func fetchFilms(completionHandler: @escaping ([Movie]) -> Void, typeMove:String) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=4095e12b49ba2a56675435ca2ae84ddc")!
       
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
          if let error = error {
            print("Error with fetching films: \(error)")
            return
          }
          
          guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
            print("Error with the response, unexpected status code: \(response)")
            return
          }

          if let data = data,
            let movieSummary = try? JSONDecoder().decode(Popular.self, from: data) {
              completionHandler(movieSummary.results ?? [])
          }
        })
        task.resume()
      }
}
