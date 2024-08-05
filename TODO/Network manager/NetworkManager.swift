//
//  NetworkManager.swift
//  TODO
//
//  Created by Shashi Gupta on 02/08/24.
//

import Foundation

enum TestError:Error{
    case decodingError
    case noData
    case badURL
}

class NetworkManager:NSObject{
    
    let requestHandler: RequestHandler
    let responseHandler: ResponseHandler
    
    init(requestHandler: RequestHandler = RequestHandler(), responseHandler: ResponseHandler = ResponseHandler()) {
        self.requestHandler = requestHandler
        self.responseHandler = responseHandler
    }
    
    /// Implemented by Closure with GEneric Type
    func fetchRequest<T: Codable>(type:T.Type ,url:String, completion:@escaping(Result<T, TestError>) -> Void){
        requestHandler.makeRequest(url: url) { data in
            
            self.responseHandler.fetchModal(type: type, data: data) { result in
                completion(result)
            }
        }
    }
    
    /// Implemented by using of Async Await Concept only available in Swift 5.5
    func fetchRequestAsyncAwait<T: Codable>(type:T.Type ,url:String, method:String) async throws -> T{
        
        do{
            let data = try await requestHandler.makeRequestAsyncAwait(url: url, method: method)
            let modal = try await responseHandler.fetchModalAsyncAwait(type: type, data: data)
            return modal
        }
        catch let error{
            throw error
        }
    }
    
}


class RequestHandler{
    
    /// Implemented by Closure
    func makeRequest(url:String, completion: @escaping (_ data:Data) -> Void) {
        
        guard let url = URL(string: url) else{
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil{
                print(error?.localizedDescription ?? "")
                return
            }
            
            guard let data = data else{
                print("Data parsing errror")
                return
            }
            
            completion(data)
        }.resume()
        
    }
    
    /// Implemented by using of Async Await Concept only available in Swift 5.5
    func makeRequestAsyncAwait(url:String, method: String) async throws -> Data {
        
        guard let url = URL(string: url) else{
            throw TestError.badURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        do{
            let (data, _) = try await URLSession.shared.data(for: request)
            return data
        }
        catch let error{
            throw error
        }
        
    }
    
}

class ResponseHandler{
    
    /// Implemented by Closure with GEneric Type
    func fetchModal<T: Codable>(type:T.Type, data:Data, completion:(_ result:Result<T, TestError>) -> Void){
        
        do{
            let modal = try JSONDecoder().decode(T.self, from: data)
            completion(.success(modal))
        }
        catch {
            completion(.failure(.decodingError))
        }
    }
    
    /// Implemented by using of Async Await Concept only available in Swift 5.5
    func fetchModalAsyncAwait<T: Codable>(type:T.Type, data:Data) async throws -> T{
        
        do{
            let modal = try JSONDecoder().decode(T.self, from: data)
            return modal
        }
        catch let error{
            throw error
        }
    }
}

