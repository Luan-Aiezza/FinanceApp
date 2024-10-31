//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//

//TODO: Sombreamento dos botoes
//TODO: FONTE DOS TEXTOS
//TODO: SOMBREAMENTO DELE
//TODO: ADD O BOTAO DE TRSNFER COINCS E FAZER UM POP OVER 

import SwiftUI
import SwiftData

struct CashBoxView2: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = CashBoxViewModel()
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showNewPiggyBankPopover = false
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundDarkPurple
                
                VStack {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.mediumPurple)
                            .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
                            .cornerRadius(50.0)
                        
                        HStack {
                            Text("Active Piggy Banks")
                                .font(.custom("Pally-Regular", size: 18))
                                .font(.title)
                                .foregroundColor(.white)
                                .padding(.leading)
                            
                            Spacer()
                            
                            Button(action: {
                                showNewPiggyBankPopover.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus").foregroundColor(.cardTextTP)
                                    Text("New Piggy Bank")
                                        .foregroundColor(.cardTextTP)
                                }
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(20)
                                .frame(width: 193, height: 48)
                            }
                            .padding(.trailing)
                            
                            .popover(isPresented: $showNewPiggyBankPopover) {
                                NewPiggyBankModal(isPresented: $showNewPiggyBankPopover, viewModel: viewModel)
                                    .frame(width: 400, height: 300)
                            }.foregroundColor(.backgroundLightPurple)
                        }
                        .padding()
                    }
                    
                    // Lista de piggy banks
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(viewModel.goalBanks, id: \.goalID) { goal in
                                GoalCardView(
                                    goalName: goal.goalName,
                                    goalAmount: Double(goal.goalAmount),
                                    savedAmount: Double(goal.coins)
                                )
                            }.padding()
                        }
                        .padding(.horizontal, 16)
                    }
                    Spacer()
                }
            }
            .padding(.horizontal, 70)
            .background(Color.backgroundDarkPurple)
            .onAppear {
                if let child = childs.first(where: { $0.id == id }) {
                    self.child = child
                }
            }
        }
    }
}


struct NewPiggyBankModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var goalName = ""
    @State private var goalAmount = ""

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text("New Piggy Bank")
                    .font(.headline)
                    .foregroundColor(.cardTextTP)
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
                        viewModel.addGoal(name: goalName, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
                .bold()
            }
            .padding([.top, .horizontal])
            
            
            VStack(alignment: .leading, spacing: 8) {
                Text("What do you want to buy?")
                    .font(.subheadline)
                    .foregroundColor(.cardTextTP)
                
                TextField("", text: $goalName)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
                    .padding()
                Text("How much does it cost?")
                    .font(.subheadline)
                    .foregroundColor(.cardTextTP)
                
                TextField("", text: $goalAmount)
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(8)
                    .keyboardType(.numberPad)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5)))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 400, height: 300)
        .foregroundColor(.backgroundLightPurple)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5) // Sombra suave para o efeito de profundidade
    }
}


// Preview
#Preview {
    CashBoxView2(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


