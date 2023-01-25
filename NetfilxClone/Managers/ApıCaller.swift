//
//  ApıCaller.swift
//  NetfilxClone
//
//  Created by İbrahim Erdogan on 4.12.2022.
//

import Foundation

import Foundation
import Combine
class ServiceAPI
{
    //farklı sorgular için farklı endpointler gerekebilir diyerek url creationu farklı bir fonksiyon içerisinde yazdım.
    //burada page = 0 geldiği zaman sadece movie sorgusu yaptığımız ortaya çıkıyor ve page parametresini url içerisine almıyorum
    //api key info.plisy içerisine saklanabilir.
    //servide error enumu ile belli hataları kontrol ediğ ekrana veriyorum
    let ApiKey = "1f28ee049ce766acadb7f46eb0a9e2f0"
    let ImageUrlBase = "https://www.themoviedb.org/t/p/w600_and_h900_bestv2/"
    let baseURL = "https://api.themoviedb.org"
    let key = "1f28ee049ce766acadb7f46eb0a9e2f0"
    private var cancellable = Set<AnyCancellable>()
    
    func createUrl(endpoind : String,page : Int) -> URL?
    {
        let apiKey = ApiKey
        var componenets = URLComponents()
        componenets.scheme = "https"
        componenets.host = "api.themoviedb.org"
        componenets.path = "/3/movie/\(endpoind)"
        componenets.queryItems = [
        URLQueryItem(name: "api_key", value: apiKey),
        URLQueryItem(name: "language", value: "en-US")]
        
        if page != 0 {
            componenets.queryItems?.append(URLQueryItem(name: "page", value: "\(page)"))
        }
        let url = componenets.url
        return url
        
    }
    
    //3 ayrı sorgu sistemi için tek bir fonksiyon yazdım asıl api bağlantısını buradan saplıyorum
     private func fetch<T : Codable>(type : T.Type ,url : URL? , completion : @escaping (Result<T,Error>)->Void)
    {
        
       // if let url = url {
       //     URLSession.shared.dataTaskPublisher(for: url)
       //         .map({$0.data})
       //         .decode(type: T.self, decoder: JSONDecoder())
       //         .sink { receivedResult in
       //             switch receivedResult{
       //             case .failure(let error):
       //                 print(error.localizedDescription)
       //                 completion(.failure(error))
       //             case .finished:
       //                 print("finirs api call")
       //             }
       //         } receiveValue: { result in
       //             print(result)
       //             completion(.success(result))
       //         }
       //         .store(in: &cancellable)
//
       // }
        
        guard let url = url else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            else
            {
                if let data = data {
                    do{
                        let movieModel = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(movieModel))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
            }
        }
        .resume()

    }
    
  //  func getDatas(completion : @escaping (Result<[Movie],Error>)->Void)
  //  {
  //      guard let url = URL(string: //"https://api.themoviedb.org/3/movie/now_playing?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1")
  //      else {return}
  //
  //      URLSession.shared.dataTask(with: url) { data, response, error in
  //          if let error = error {
  //              print(error.localizedDescription)
  //          }
  //          else {
  //              if let data = data {
  //                  do{
  //                      let model = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
  //                      print("\(model.results.count)")
  //                      completion(.success(model.results))
  //                  }
  //                  catch{
  //                      print("decode error")
  //                  }
  //              }
  //          }
  //      }
  //      .resume()
  //  }
    
    
    //bu fonksiyon da viewmodellerden istenen bilgileri fetch fonksiyonuna iletiyor ver geri istenen itemleri döndürüyor
    
    func getTrendingMovies(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "\(baseURL)/3/trending/movie/day?api_key=\(key)") else {return}
       // let urlString = "https://api.themoviedb.org/3/trending/movie/day?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1"
       // let url = URL(string: urlString)!
        //let url = createUrl(endpoind: "now_playing",page: 1)
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
    
    func getPopulerMovies(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "\(baseURL)/3/movie/popular?api_key=\(key)&language=en-US&page=1") else {return}
       // let urlString = "https://api.themoviedb.org/3/movie/populer?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1"
       // let url = URL(string: urlString)!
       // let url = createUrl(endpoind: "popular",page: 1)
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
    
    func getTrendingTv(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "\(baseURL)/3/trending/tv/day?api_key=\(key)") else {return}
       // let urlString = "https://api.themoviedb.org/3/trending/tv/day?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1"
       // let url = URL(string: urlString)!
       // let url = createUrl(endpoind: "latest",page: 1)
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
    func getUpcomingMovies(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "\(baseURL)/3/movie/upcoming?api_key=\(key)&language=en-US&page=1") else {return}
       // let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1"
       // let url = URL(string: urlString)!
       // let url = createUrl(endpoind: "upcoming",page: page)
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
    
    func getTopRatedMovies(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "\(baseURL)/3/movie/top_rated?api_key=\(key)&language=en-US&page=1") else {return }
      //  let urlString = "https://api.themoviedb.org/3/movie/top_rated?api_key=1f28ee049ce766acadb7f46eb0a9e2f0&language=en-US&page=1"
      //  let url = URL(string: urlString)!
        //let url = createUrl(endpoind: "top_rated",page: 1)
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
    
    /**
     https://api.themoviedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate
     */
    func getDiscoverMovies(completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(key)&language=en-US&ort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_types=flatrate") else {return }
        
        fetch(type: TitleResponse.self, url: url, completion: completion)
    }
  
    func search(with query : String, completion : @escaping (Result<TitleResponse,Error>)->Void)
    {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=\(key)&query=\(query)") else {return }
    
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            else
            {
                if let data = data {
                    do{
                        let movieModel = try JSONDecoder().decode(TitleResponse.self, from: data)
                        completion(.success(movieModel))
                    }
                    catch{
                        completion(.failure(error))
                    }
                }
            }
        }
        .resume()
    }
   
    
}
