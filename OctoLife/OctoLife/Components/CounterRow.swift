//
//  CounterRow.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//

import SwiftUI

struct CounterRow: View {
    
    var counter : Counter = Counter(
        title: "Name Counter",
        type: "Type Counter",
        typeGoal: TypeGoal.avgDaily,
        valueGoal: 400,
        numberCounter: 388,
        indexColor: 0
    )
   
    var body: some View {
        HStack {
            VStack(alignment: .leading){
                
                Text(counter.type)
                    .fontWeight(.bold)
                    .padding(7)
                    .font(.system(size: 10))
                    .foregroundStyle(.white)
                    .background(
                        Rectangle()
                            .foregroundStyle(ColorsListCounters.colors[counter.indexColor])
                            .cornerRadius(15)
                            .shadow(radius: 15)
                        
                    ).frame(height: 20)
                Text(counter.title)
                    .font(.system(size: 24))
                    .padding([.leading, .bottom], 4.0)
                    .fontWeight(.bold)
                
                Spacer().frame(height: 10)
            }
            .padding([.top, .leading], 14)
            
            Spacer()
            ZStack{
               
                Rectangle()
                    .foregroundStyle(ColorsListCounters.colors[counter.indexColor])
                    .cornerRadius(15)
                    .shadow(color: Color.blue.opacity(0.2), radius: 2, x: -2, y: 0)
                    .frame(width: 140, height: 90, alignment: .trailing)
                
                VStack{
                    Text("\(counter.typeGoal)")
                        .font(  .system(size: 16))
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                    Spacer()
                    HStack ( alignment: .center){
                        Text("\(counter.numberCounter)")
                            .font(  .system(size: 24))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                        Text("/\(counter.valueGoal)")
                            .font(  .system(size: 30))
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                    
                }.padding(.vertical, 15)
                
            }
                
        }
        
        .background(
            Rectangle()
                .foregroundStyle(Color.white)
                .cornerRadius(15)
                .shadow(color: Color.gray.opacity(0.4), radius: 5, x: 0, y: 2)
        )
        .frame(height: 90)
        
    }
}

#Preview {
    CounterRow()
}
