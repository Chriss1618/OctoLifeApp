//
//  CreateCounter.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//

import SwiftUI
import SwiftData

struct CreateCounter: View {
    @Environment(\.presentationMode) var presentationMode // Aggiungi questa riga

    @Environment(\.modelContext) private var context
    
    let colorTheme      : Color = .blue.opacity(0.4)
    let colorTheme_Text : Color = .blue.opacity(0.8)
    let colorTheme_BG   : Color = .blue.opacity(0.05)
    
    var createCounterController: CreateCounterController? = CreateCounterController()
    
    @State private var titleInput   : String = ""
    @State private var typeInput    : String = ""
    @State private var goalInput    : String = ""
    
    @State private var selectedOption = TypeGoal.min
    @State private var selectedColorIndex : Int = 0

    
    
    
    private let columns : [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        ZStack{   
           ScrollView {
               contentView
           }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
        }
        
            
   }

    var contentView: some View {
        
        VStack {
            headerSection
            titleSection
            typeSection
            goalSection
            colorSection
            Spacer()
            createButton
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

            
            Text("Create Counter")
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(.blue)
                .frame(maxWidth: .infinity)
                .frame(height: 100, alignment: .center)
            
            Spacer()
            
            Spacer()
                .frame(width: 60) // Larghezza del pulsante "Back" per bilanciare
        }.padding( .horizontal, 10)
        .frame(height: 100)
        
    }
    
    var titleSection: some View {
        VStack(alignment: .leading) {
            Text("Title")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .padding(.leading, 5)
                .foregroundStyle( colorTheme_Text )
            TextField("", text: $titleInput,prompt: Text("Title counter")
                .foregroundColor(.blue.opacity(0.4)))
                .foregroundStyle(colorTheme_Text)
                .padding(12)
                .background( colorTheme_BG )
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(colorTheme, lineWidth: 1)
                )
        }
        .padding([.leading, .bottom, .trailing], 16)
    }
    
    var typeSection: some View {
        VStack(alignment: .leading) {
            Text("Type Counter")
                .font(.system(size: 20))
                .padding(.leading, 5)
                .fontWeight(.semibold)
                .foregroundStyle(colorTheme_Text)
            TextField("", text: $typeInput ,prompt: Text("Ex. Book")
                .foregroundColor(.blue.opacity(0.4)))
                .foregroundStyle(colorTheme_Text)
                .padding(12)
                .background( colorTheme_BG )
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke( colorTheme , lineWidth: 1)
                )
        }
        .padding(16)
    }
    
    var goalSection: some View {
        VStack(alignment: .leading) {
            Text("Goal")
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .padding(.leading, 5)
                .foregroundStyle(colorTheme_Text)
            
            Menu {
                
                ForEach(Array(Counter.goalOptions.keys), id: \.self) { indexOption in
                   
                    
                    Button(action: {
                        selectedOption = indexOption
                    }) {
                        Text( Counter.goalOptions[indexOption]! )
                    }
                }
            
            } label: {
                HStack {
                    Text(Counter.goalOptions[selectedOption]!)
                        .padding([.top, .leading, .bottom], 14)
                        .padding(.leading,12)
                        .fontWeight( .medium)
                        .foregroundColor(.blue) // Colore del testo
                    Spacer() // Spinge la freccia a destra
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.blue.opacity(0.7))
                        .padding(.trailing, -10)// Colore della freccia
                }
                .padding(.trailing)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.blue.opacity(0.9), lineWidth: 1)
                        
                )
                
            }
            
        
            TextField("", text: $goalInput,prompt: Text("Value")
                .foregroundColor(.blue.opacity(0.4))
            )
            .foregroundStyle(colorTheme_Text)
                .padding(12)
                .background( colorTheme_BG)
                .cornerRadius(15)
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(colorTheme, lineWidth: 1)
                )
        }
        .padding(16)
    }
    
    var colorSection: some View {
        VStack(alignment: .leading) {
            Text("Colors")
                .fontWeight(.semibold)
                .font(.system(size: 20))
                .padding(.leading, 5)
                .foregroundStyle(colorTheme_Text)

            LazyVGrid(columns: columns, alignment: .leading, spacing: 10) {
                ForEach(ColorsListCounters.colors.indices, id: \.self) { index in
                    let currentColor = ColorsListCounters.colors[index].opacity(0.5) // Pre-computiamo il colore
                    let isSelected = selectedColorIndex == index // Calcoliamo la condizione separatamente

                    ZStack(alignment: .bottomTrailing) {
                        Rectangle()
                            .fill(currentColor)
                            .frame(width: 60, height: 60)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 5)
                            )
                            .shadow(radius: 2)

                        // Checkmark in basso a destra
                        if isSelected {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                                .padding(5)
                        }
                    }
                    .onTapGesture {
                        selectedColorIndex = index // Toggle dell'indice selezionato
                    }
                }
            }
        }
        .padding(16)
    }

    
    var createButton: some View {
        Button(action: {
            createCounter(
                titleInput: titleInput,
                typeInput: typeInput,
                valueInput:  Int(goalInput) ?? 0 ,
                indexColor: self.selectedColorIndex,
                typeCounterInput: selectedOption)
        }) {
            Text("Create")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: 250)
                .background(Color.blue.opacity(0.8))
                .cornerRadius(15)
                .shadow(radius: 5)
        }
        .padding(.bottom, 20)
    }
     
    func createCounter (titleInput: String, typeInput: String, valueInput: Int, indexColor : Int , typeCounterInput : TypeGoal ){
        
        let counter = Counter(
            title: titleInput, type: typeInput, typeGoal: typeCounterInput, valueGoal: valueInput, numberCounter: 0, indexColor: indexColor
        )
        
        self.context.insert(counter)
        print("Counter Creato")
        presentationMode.wrappedValue.dismiss()
    }
    
}


#Preview {
    CreateCounter()
}

