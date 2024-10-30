//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//



import SwiftUI
import SwiftData

struct CashBoxView2: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = CashBoxViewModel()
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showNewPiggyBankModal = false
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundDarkPurple
                    .ignoresSafeArea()
                
                VStack {
                    // Toolbar com ícone da criança e caixa de moedas
                    HStack {
                        Button(action: {
                            // Ação do botão (ex: abrir perfil da criança)
                        }) {
                            Image("ChildAvatar")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .foregroundColor(.white)
                        }
                        .padding(.leading, 16)
                        
                        Spacer()
                        
                        HStack(spacing: 20) {
                            Button(action: { /* Ação 1 */ }) {
                                Image(systemName: "gearshape.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            Button(action: { /* Ação 2 */ }) {
                                Image(systemName: "bell.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                            Button(action: { /* Ação 3 */ }) {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                    .foregroundColor(.white)
                            }
                        }
                        
                        Spacer()
                        
                        ZStack {
                            Rectangle()
                                .foregroundColor(.yellowCoins)
                                .frame(width: 90, height: 60)
                                .cornerRadius(50.0)
                            
                            HStack {
                                Image("CoinsImage")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                Text("\(viewModel.wallet.coins)")
                                    .font(.title2)
                            }
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, 16)
                    
                    // Header e botão para adicionar novo objetivo
                    HStack {
                        Text("Active Piggy Banks")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding(.leading)
                        
                        Spacer()
                        
                        Button(action: {
                            showNewPiggyBankModal.toggle()
                        }) {
                            HStack {
                                Image(systemName: "plus")
                                Text("New Piggy Bank")
                            }
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.purple)
                            .cornerRadius(20)
                        }
                        .padding(.trailing)
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
                            }
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
            .sheet(isPresented: $showNewPiggyBankModal) {
                NewPiggyBankModal(isPresented: $showNewPiggyBankModal, viewModel: viewModel)
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
    CashBoxView2(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


