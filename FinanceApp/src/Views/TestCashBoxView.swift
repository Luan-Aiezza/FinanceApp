//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//

//TODO: Sombreamento dos botoes
//TODO: tAMANHO DO ROXO- 64 pixels e 85 de margem
//TODO: FONTE DOS TEXTOS E COR DELES
//TODO: CARD TAMANHO 211 DE ALTURA
//TODO: FALTA A COR DO TESTO E DO CARD EM SI ASSIM COMO O SOMBREAMENTO DELE
//TODO: ADD O BOTAO DE TRSNFER COINCS E FAZER UM POP OVER

import SwiftUI
import SwiftData

struct TestCashBoxView: View {
    @Environment(\.modelContext) private var modelContext
    @State var viewModel: CashBoxViewModel
    
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showNewPiggyBankModal = false
    
    init(id: UUID){
        viewModel = CashBoxViewModel(id: id)
        
    }
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundDarkPurple
                //.ignoresSafeArea()
                VStack {
                    
                    VStack {
                        HStack {
                            Text("Active Piggy Banks")
                                .font(
                                    Font.custom("Pally Variable", size: 24)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button(action: {
                                showNewPiggyBankModal.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "plus")
                                        .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                                    Text("New Piggy Bank")
                                        .font(
                                            Font.custom("Pally Variable", size: 17)
                                                .weight(.medium)
                                        )
                                        .multilineTextAlignment(.center)
                                        .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                                    
                                }
                                .padding()
                                .background(Color.white)
                                .foregroundColor(.purple)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red: 0.25, green: 0, blue: 0.39))
                                        .offset(x:0, y: 6)
                                )
                            }
                            .padding(.trailing)
                        }.padding()
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                    .background(Color(red: 0.36, green: 0, blue: 0.55))
                    .clipShape(.rect(cornerRadius: 24.0))
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.25, green: 0, blue: 0.39))
                            .offset(x:0, y: 6)
                    )
                    // Lista de piggy banks
                    TestLoadCashBoxesModal(viewModel: viewModel)
                    Spacer()
                }
            }
            .padding(.horizontal, 70)
            .background(Color.backgroundDarkPurple)
            .onAppear {
                viewModel.modelContext = modelContext
                viewModel.fetch()
            }
        }
        .sheet(isPresented: $showNewPiggyBankModal) {
            TestNewPiggyBankModal(isPresented: $showNewPiggyBankModal, viewModel: viewModel)
        }
    }
}


struct TestLoadCashBoxesModal: View {
    @ObservedObject var viewModel: CashBoxViewModel
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.child.goals, id: \.cashBox.id) { goal in
                    GoalCardView(
                        goalName: goal.cashBox.cashBoxDescription,
                        goalAmount: Double(goal.goalAmount),
                        savedAmount: Double(goal.cashBox.coins)
                    )
                }.padding()
            }
            .padding(.horizontal, 16)
        }
    }
}


struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.purple)
                
                Spacer()
                
                Text("New Piggy Bank")
                    .font(.headline)
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
                        viewModel.addGoal(name: goalName, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.purple)
            }
            .padding()
            
            TextField("What do you want to buy?", text: $goalName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            
            TextField("How much does it cost?", text: $goalAmount)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .keyboardType(.numberPad)
            
            Spacer()
        }
        .padding()
    }
}

// Preview
#Preview {
    TestCashBoxView(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


