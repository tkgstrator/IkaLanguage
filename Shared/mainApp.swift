//
//  mainApp.swift
//  Shared
//
//  Created by devonly on 2021/08/07.
//

import SwiftUI

@main
struct mainApp: App {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}
