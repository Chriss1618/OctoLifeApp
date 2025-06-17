//
//  ProgressBarCounter.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 17/10/24.
//

import SwiftUI

struct ProgressBarCounter: View {
    @Binding var progress: CGFloat
    
    var width   : CGFloat = 300
    var height  : CGFloat = 30
    var radius  : CGFloat = 20
    
    var valueMax : Int = 100
    var color : Color = .gray
    var isOpposite: Bool
    
    var body: some View {
        
        let color = isOpposite ?  getColorReverse(for: progress) : getColor(for: progress)
        
        VStack ( alignment: .center){
            
            HStack(alignment: .center){
                Text("0")
                    .fontWeight(.bold)
                    .frame(width: 60, alignment: .trailing) // Allinea a destra
                Spacer()
                Text("\(valueMax)")
                    .fontWeight(.bold)
                    .frame(width: 80, alignment: .leading)
            }
            
            ZStack (alignment: .leading){
                RoundedRectangle( cornerRadius: radius)
                    .frame(width: width + 20, height: height + 15)
                    .foregroundStyle(Color.blue.opacity(0.2))
                RoundedRectangle( cornerRadius: radius)
                    .frame(width: progress * width, height: height )
                    .foregroundStyle(color)
                    .offset(x: 10)
                
            }
        }
        
    }
    
    func getColor(for progress: CGFloat) -> Color {
        switch progress {
        case 0.0...0.3:
            return .bad1
        case 0.3...0.5:
            return .bad2
        case 0.5...0.7:
            return .good1
        case 0.7...0.99999999:
            return .good2
        case 1.0:
            return .done
        default:
            return .gray
        }
    }
    
    func getColorReverse(for progress: CGFloat) -> Color {
        switch progress {
        case 0.0...0.3:
            return .done
        case 0.3...0.5:
            return .good2
        case 0.5...0.7:
            return .good1
        case 0.7...0.99999999:
            return .bad2
        case 1.0:
            return .bad1
        default:
            return .gray
        }
    }
}

#Preview {
    ProgressBarCounter( progress: .constant(1), isOpposite: false)
}
