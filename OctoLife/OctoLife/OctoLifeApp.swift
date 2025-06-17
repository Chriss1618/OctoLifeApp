//
//  OctoLifeApp.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//

import SwiftUI
import SwiftData

@main
struct OctoLifeApp: App {
    
//    let container : ModelContainer = {
//        let schema = Schema( [Counter.self])
//        var container  = try! ModelContainer(for: schema, configurations: [])
//        return container
//    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView() .preferredColorScheme(.light)
        }.modelContainer( for: Counter.self )
    }
}
