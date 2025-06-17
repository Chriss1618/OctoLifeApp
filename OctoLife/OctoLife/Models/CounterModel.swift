//
//  CounterModel.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//
import SwiftUI
import SwiftData

@Model
class Counter : Identifiable {
    
    static let goalOptions: [TypeGoal: String] = [
        .min        : "Minimum",
        .max        : "Maximum",
        .avgDaily   : "Daily/Average"
    ]
    
    var id = UUID()
    
    var title           : String
    var type            : String
    var typeGoal        : String
    var valueGoal       : Int
    var numberCounter   : Int
    var indexColor      : Int
    
    init(id: UUID = UUID(), title: String, type: String, typeGoal: TypeGoal, valueGoal: Int, numberCounter: Int, indexColor: Int) {
        self.id = id
        self.title = title
        self.type = type
        self.typeGoal = typeGoal.rawValue
        self.valueGoal = valueGoal
        self.numberCounter = numberCounter
        self.indexColor = indexColor
    }
    
    func increment() {
        if(self.numberCounter < self.valueGoal){
            self.numberCounter += 1
        }
        
    }
    
    func decrement() {
        if(self.numberCounter > 0){
            self.numberCounter -= 1
        }
    }
    
}

enum TypeGoal: String {
    case min = "Minimum"
    case max = "Maximum"
    case avgDaily = "Average/Daily"
}

struct ColorsListCounters {
    static public let colors : [Color] = [
        
        .purpleCounter,
        .blueCounter,
        .greenCounter,
        .orangeCounter,
        .redCounter
    ]
}
