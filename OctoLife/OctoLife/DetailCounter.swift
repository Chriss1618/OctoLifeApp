//
//  DetailCounter.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//

import SwiftUI
import SwiftData
import UIKit

struct DetailCounter: View {
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium) // Generatore di feedback aptico
        
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.modelContext) private var context
    @State private var progressValue : CGFloat = 0.0
    @State private var timer: Timer? = nil // Timer per la ripetizione
    @State private var isLongPressActive: Bool = false // Stato per il ritardo
        
    var selectedId: UUID?
        
    @Query private var counterResult: [Counter]
    
    private var counter : Counter { counterResult.first ?? placeholderCounter }
    
    init(selectedId: UUID?) {
        self.selectedId = selectedId
        if let selectedId = selectedId {
            _counterResult = Query(filter: #Predicate { $0.id == selectedId })
        } else {
            _counterResult = Query()
        }
        
        
    }
    
    var placeholderCounter : Counter = Counter(
        id: UUID(),
        title: "Inferno",
        type: "Book",
        typeGoal: TypeGoal.avgDaily,
        valueGoal: 100,
        numberCounter: 23,
        indexColor: 0
    )
    
    var body: some View {
        
        VStack {
            headerSection
            .onAppear {
                print("\(counter.title)")
                print("\(counter.numberCounter)")
                print("\(counter.valueGoal)")
            }
            Spacer( ).frame(height: 5)
            
            typeCounter
            Spacer( ).frame(height: 30)
            counterNumber
            Spacer( ).frame(height: 30)
            
            ProgressBarCounter(progress: $progressValue ,width:250 , height: 10 , valueMax : counter.valueGoal, isOpposite: counter.typeGoal == TypeGoal.max.rawValue)
                .padding(.horizontal, 20)
                .scaleEffect(1.2)
            Spacer()
        }
        .onAppear(){
            progressValue = Double(counter.numberCounter)/Double(counter.valueGoal)
        }
        .navigationBarBackButtonHidden(true)
    }
    
    var typeCounter : some View{
        Text(counter.type)
            .fontWeight(.bold)
            .padding( .horizontal,20 )
            .padding( .vertical, 10 )
            .font(.system(size: 14))
            .foregroundStyle(.white)
            .background(
                Rectangle()
                    .foregroundStyle(ColorsListCounters.colors[counter.indexColor])
                    .cornerRadius(30)
                    .shadow(color: Color.blue.opacity(0.5), radius: 2, x: 2, y: 2)
            )
            .frame(height: 20)
    }
    
    
    var counterNumber : some View{
        VStack{
            Button(action: {
                increment()
            }){
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundStyle(.blue)
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(90))
                    .frame(width: 120, height: 120)
                    .padding(10)
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onEnded { _ in
                        startTimer(isIncrementing: true)
                    }
            )
            .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                if !isPressing { stopTimer() }
            }) {
                // Vuoto, poiché il Timer viene gestito nella gesture simultanea
            }
            
            Text("\(counter.numberCounter)")
                .font(.system(size: 100, weight: .bold))
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .center)
            Button(action: {
                decrement()
            }){
                Image(systemName: "chevron.left")
                    .resizable()
                    .foregroundStyle(.blue)
                    .aspectRatio(contentMode: .fit)
                    .rotationEffect(.degrees(-90))
                    .frame(width: 120, height: 120)
                    .padding(10)
            }
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.1)
                    .onEnded { _ in
                        startTimer(isIncrementing: false)
                    }
            )
            .onLongPressGesture(minimumDuration: 0.1, pressing: { isPressing in
                if !isPressing { stopTimer() }
            }) {
                // Vuoto, poiché il Timer viene gestito nella gesture simultanea
            }
                  
        }
        
    }
    var headerSection : some View{
        HStack {
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                HStack {
                    Image(systemName: "chevron.left")
                    Text("Back")
                }
                .frame(maxWidth: 60)
            }
            
            Spacer()

            Text("\(counter.title)")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .center)
            
            Spacer()
            
            
            Spacer()
                .frame(width: 60) // Larghezza del pulsante "Back" per bilanciare
        }
        .padding( .horizontal, 10)
        .frame(height: 100)
        
    }
    
    
    func startTimer(isIncrementing: Bool) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            
            if isLongPressActive {
                timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
                    if isIncrementing {
                        increment()
                        
                    } else {
                        decrement()
                    }
                }
            }
        }
        isLongPressActive = true
    }
    
    func increment(){
        counter.increment()
        progressValue = (Double(counter.numberCounter)/Double(counter.valueGoal) )
        try! context.save()
        feedbackGenerator.impactOccurred()
    }
    
    func decrement(){
        counter.decrement()
        progressValue = (Double(counter.numberCounter)/Double(counter.valueGoal) )
        try! context.save()
        feedbackGenerator.impactOccurred()
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
        isLongPressActive = false
    }
}

#Preview {
    DetailCounter(selectedId: nil)
}
