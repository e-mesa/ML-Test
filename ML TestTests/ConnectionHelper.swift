//
//  ConnectionHelper.swift
//  ML TestTests
//
//  Created by Emiliano Mesa on 7/1/20.
//

import Foundation

class ConnectionHelper: NSObject {
    static func pingServer(fullURL: String, completion: @escaping (Bool) -> Void) {
        let hostUrl: String = fullURL
        if let url = URL(string: hostUrl) {
            var request = URLRequest(url: url)
            request.httpMethod = "HEAD"
            URLSession(configuration: .default)
                .dataTask(with: request) { (_, response, error) -> Void in
                    guard error == nil else {
                        print("Error:", error ?? "")
                        return
                    }
                    guard (response as? HTTPURLResponse)?
                        .statusCode == 200 else {
                            print("The host is down")
                            return
                    }
                    print("The host is up and running")
            }
            .resume()
        }
    }
}
