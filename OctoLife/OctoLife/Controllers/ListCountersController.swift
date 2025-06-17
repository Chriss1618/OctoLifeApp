//
//  ListCountersController.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 16/10/24.
//
import SwiftData
class ListCountersController{
    
    let counters : ModelContainer
    
    init () {
        let schema = Schema( [Counter.self])
        self.counters = try! ModelContainer(for: schema, configurations: [])
    }
    
}
