//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 01/03/25.
//

import Foundation



class WebServiceAPI {
    
    static let apiKey = "29cd1faf-0e36-4fff-b3f8-9699787450ed"
    static let baseURL = "https://hades.tiagoaguiar.co/kingburguer"
    
    static let shared = WebServiceAPI()
    
    enum EndPoint: String {
        case createUser = "/users"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case feed = "/feed"
        case hightlights = "/highlight"
        case productDetail = "/products/%d" // para criacao da id que e dinamico % e o tipo no caso e numero entao e decimal = d
        case coupon = "/products/%d/coupon"
        case me = "/users/me"
        
    }
    
    enum Method: String {
        case post
        case put
        case get
        case delete
    }
    
    enum NetworkError: Error {
        case unauthorized
        case badRequest
        case notFound
        case internalError
        case unknown
    }
    
    enum Result {
        case success(Data?)
        case failure(NetworkError, Data?)
    }
    
    private func completUrl(path: String) -> URLRequest? {
        let endpoint = "\(WebServiceAPI.baseURL)\(path)"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return nil
        }
        return URLRequest(url: url)
        
    }
    
    
    // funcao de chamada de URL dinamica (pura) / product/1123455
    func call(path: String, method: Method, accessToken: String? = nil, completion: @escaping (Result) -> Void){
        makeRequest(path: path, body: nil, Method: method,accessToken: accessToken, completion: completion)
    }
    
    // funcao de chamada para a requisicao fixa -> ENDPOINT e Body
    func call<R: Encodable>(path: EndPoint, body: R?, Method: Method, accessToken: String? = nil, completion: @escaping (Result) -> Void) {
        makeRequest(path: path.rawValue, body: body, Method: Method,accessToken: accessToken, completion: completion)
    }
    
    
    // funcao de requisicao
    func makeRequest(path: String, body: Encodable?, Method: Method, accessToken: String? = nil, completion: @escaping (Result) -> Void) {
        do {
            
            guard var request = completUrl(path: path) else {return}
            
            request.httpMethod = Method.rawValue.uppercased()
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            
            if let accessToken = accessToken {
                request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            }
            
            if let body = body {
                let jsonRequest = try JSONEncoder().encode(body)
                request.httpBody = jsonRequest
            }
                
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                // asincrono
                print("Response is \(String(describing: response))")
                print("----------------------------\n\n")
                
                if let error = error {
                    print(error)
                    completion(.failure(.internalError, data))
                    return
                }
                
                if let r = response as? HTTPURLResponse {
                    switch r.statusCode {
                    case 200:
                        completion(.success(data))
                        break
                    case 401:
                        completion(Result.failure(NetworkError.unauthorized, data)) // pode ser assim com o result e com network
                        break
                    case 404:
                        completion(.failure(.notFound, data)) // ou assim, sem eles pois se trata de um enum
                        break
                    case 400:
                        completion(.failure(.badRequest, data))
                        break
                    case 500:
                        completion(.failure(.internalError, data))
                        break
                    default:
                        completion(.failure(.unknown, data))
                        break
                    }
                }
                
                return
            }
            task.resume()
        } catch {
            print(error)
            return
        }
        
        
    }
    
    
}
