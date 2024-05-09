//
//  APIManager.swift
//  BookSearchApp
//
//  Created by 유림 on 5/8/24.
//

import Foundation

class APIManager {
    
    static let shared = APIManager()
    
    var page: Int = 1
    
    func fetchLibraryData(query: String, page: Int, completion: @escaping (Library) -> ()) {
        // url
        var url = URL(string: "https://dapi.kakao.com/v3/search/book")!
        url = URL(string: url.absoluteString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
        url.append(queryItems: [URLQueryItem(name: "query", value: query)])
        url.append(queryItems: [URLQueryItem(name: "page", value: String(page))])
        
        // httpHeader
        let restAPIKey = "9c4fb90eba075659878d66ef7337ebcb"
        let httpHeader = "KakaoAK \(restAPIKey)"
        
        // urlRequest
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(httpHeader, forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // 응답 코드 확인
            let httpResponse = response as? HTTPURLResponse
            print("status:", httpResponse?.statusCode)
            
            // 데이터 받기
            guard let libraryData = data else {
                print("error: \(error)")
                return
            }
//            print("data: \(String(data: libraryData, encoding: .utf8))") // 데이터 출력
            
            // 데이터 디코딩
            guard let libraryResult = try? JSONDecoder().decode(Library.self, from: libraryData) 
            else {
                print("디코딩 실패")
                return
            }
//            print("🟡 result: \(libraryResult)")
            completion(libraryResult)
        }.resume()
    }
    
    func fetchUrlData(url: URL) async throws -> Data {
        let (data, _) = try await URLSession.shared.data(from: url)
//        print("data: \(data)")
        return data
    }
    
}
