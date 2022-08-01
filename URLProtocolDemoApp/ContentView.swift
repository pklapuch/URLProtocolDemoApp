//
//  ContentView.swift
//  URLProtocolDemoApp
//
//  Created by Pawel Klapuch on 8/1/22.
//

import SwiftUI

class ViewModel: ObservableObject {
    private var session: URLSession?
    private var task: URLSessionDataTask?
    
    func triggerURLRequest() {
        print("trigger URL request")
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolStub.self]
        
        session = URLSession(configuration: configuration)
        task = session?.dataTask(with: URL(string: "https://google.com")!) { data, response, error in
            print("request completed: data: \(data?.count ?? 0), error: \(String(describing: error))")
        }
        
        task?.resume()
    }
    
    private func anyHTTPResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: nil)!
    }
    
    private func anyURL() -> URL {
        return URL(string: "https://google.com")!
    }
}

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Text("Hello, world!")
                .padding()
        }
        .onAppear {
            viewModel.triggerURLRequest()
        }
    }
}

class URLProtocolStub: URLProtocol {
    override class func canInit(with request: URLRequest) -> Bool {
        print("-- canInit: \(request.url?.absoluteString ?? "--")")
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        print("-- canonicalRequest: \(request.url?.absoluteString ?? "--")")
        return request
    }
    
    override func startLoading() {
        print("-- start loading: \(request.url?.absoluteString ?? "--")")
        client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {
        print("-- stop loading: \(request.url?.absoluteString ?? "--")")
    }
}
