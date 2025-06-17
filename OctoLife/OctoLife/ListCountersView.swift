//
//  ListCountersView.swift
//  OctoLife
//
//  Created by Cristofor Doamre on 14/10/24.
//

import SwiftUI
import SwiftData

struct ListCountersView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var counters : [Counter]
    
    var countersViewModel : CountersViewModel = CountersViewModel()
    
    var body: some View {
        
            NavigationView{
                ZStack{
                      VStack{
                          Spacer().frame(height: 50)
                        HStack{
                            Text("Counters")
                                .fontWeight(.bold)
                                .font(.system(size: 30))
                                .foregroundStyle(.blue)
                            
                            Spacer()
                            NavigationLink(
                                destination: CreateCounter()
                            ) {
                                Image (systemName: "plus.circle.fill")
                                    .font(.system(size: 27))
                                    .foregroundStyle(.blue)
                            }
                            
                        }.padding([.top, .leading, .trailing], 20)
                    
                          if( self.counters.isEmpty ){
                              Text("No Counters here, lets create one!")
                                .padding(.top, 20)
                                .foregroundStyle( Color.gray)
                          }else{
                                List{
                                    ForEach( self.counters ) { counter in
                                       
                                        CounterRow(counter: counter)
                                            .background(
                                            NavigationLink(
                                                destination: DetailCounter( selectedId: counter.id )
                                            ) {
                                                EmptyView()
                                            }.opacity(0)
                                        )
                                       .listRowSeparator(.hidden)
                                        
                                    }.onDelete{
                                        indexes in for index in indexes {
                                            self.deleteItem(self.counters[index])
                                        }
                                        
                                    }
                                    
                                }
                          }
                          
                          Spacer()
                    }
                      .listStyle(PlainListStyle())
                      .padding(.horizontal,16)
                    VStack {
                        
                        Spacer()
                            
                        HStack{
                            Spacer()
                            Image("OctoLife_Icon")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 170, height: 170)
                                    .padding(.trailing, -8)
                        }
                    }
                }.ignoresSafeArea()
        }  
        
    }
    
    func deleteItem ( _ item : Counter){
        context.delete(item)
        
    }
}

#Preview {
    ListCountersView()
}
