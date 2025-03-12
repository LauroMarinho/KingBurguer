//
//  WebServiceAPI.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 01/03/25.
//

import Foundation



class WebServiceAPI {
    
    static let apiKey = ""
    static let baseURL = "https://hades.tiagoaguiar.co/kingburguer"
    
    static let shared = WebServiceAPI()
    
    enum EndPoint: String {
        case createUser = "/users"
        case login = "/auth/login"
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
    
    private func completUrl(path: EndPoint) -> URLRequest? {
        let endpoint = "\(WebServiceAPI.baseURL)\(path.rawValue)"
        guard let url = URL(string: endpoint) else {
            print("ERROR: URL \(endpoint) malformed!")
            return nil
        }
        return URLRequest(url: url)
        
    }
    
    // funcao do login
    func login(request: SingInRequest, completion: @escaping(SignInResponse?, String?)-> Void){
        call(path: .login, body: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                let response = try? JSONDecoder().decode(SignInResponse.self, from: data)
                completion(response, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
                guard let data = data else { return }
                
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(SignUpResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                }
                break
            }
        }
    }
    
    
    // funcao para criar o usuario
    func createUser(request: SignUpRequest, completion: @escaping (Bool?, String?) -> Void){
        call(path: EndPoint.createUser, body: request) { result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                //let response = try? JSONDecoder().decode(SignUpResponse.self, from: data)
                completion(true, nil)
                break
                
            case .failure(let error, let data):
                print("ERROR: \(error)")
                
                guard let data = data else { return }
                switch error {
                case .unauthorized:
                    let response = try? JSONDecoder().decode(SignUpResponseUnauthorized.self, from: data)
                    completion(nil, response?.detail.message)
                    break
                    
                case .badRequest:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                default:
                    let response = try? JSONDecoder().decode(SignUpResponseError.self, from: data)
                    completion(nil, response?.detail)
                    break
                    
                }
                break
            }
        }
    }
    
    
    
    func call<R: Encodable>(path: EndPoint, body: R, completion: @escaping (Result) -> Void) {
        
        do {
            let jsonRequest = try JSONEncoder().encode(body)
            
            guard var request = completUrl(path: path) else {return}
            
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "accept")
            request.setValue(WebServiceAPI.apiKey, forHTTPHeaderField: "x-secret-key")
            
            request.httpBody = jsonRequest
            
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
                
                completion(.success(data))
            }
            task.resume()
        } catch {
            print(error)
            return
        }
        
        
    }
    
    
}
