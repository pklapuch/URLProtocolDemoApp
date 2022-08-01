//
//  URLProtocolDemoAppApp.swift
//  URLProtocolDemoApp
//
//  Created by Pawel Klapuch on 8/1/22.
//

import SwiftUI

@main
struct URLProtocolDemoAppApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ViewModel())
        }
    }
}
