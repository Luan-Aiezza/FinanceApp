//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//

//TODO: Texto dentro do textfield ficar preto
//TODO: FONTE DOS TEXTOS
//TODO: SOMBREAMENTO DELE


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
    @State private var showTransferCoinsPopover = false // Novo estado para o popover de transferência
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
                                .foregroundColor(.white)
                                .padding(.leading)
                            
                            Spacer()
                            
                            // Botão para criar novo Piggy Bank
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
                                .cornerRadius(20)
                                .frame(width: 150, height: 40)
                                .shadow(color: Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
                            }
                            .popover(isPresented: $showNewPiggyBankPopover) {
                                NewPiggyBankModal(isPresented: $showNewPiggyBankPopover, viewModel: viewModel)
                                    .frame(width: 500, height: 400)
                            }
                            
                            
                            // Botão de Transfer Coins
                            Button(action: {
                                showTransferCoinsPopover.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "arrow.right.arrow.left")
                                        .foregroundColor(.cardTextTP)
                                    Text("Transfer Coins")
                                        .foregroundColor(.cardTextTP)
                                }
                                .padding()
                                .background(viewModel.goalBanks.isEmpty ? Color.gray : Color.white)
                                .cornerRadius(20)
                                .frame(width: 150, height: 40)
                                .shadow(color: viewModel.goalBanks.isEmpty ? Color.clear : Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
                            }
                            .disabled(viewModel.goalBanks.isEmpty) // Desativa o botão se não houver metas
                            .popover(isPresented: $showTransferCoinsPopover) {
                                TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                                    .frame(width: 500, height: 400)
                            }
                            .padding(.trailing)
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

// Novo popover para Transfer Coins
struct TransferCoinsPopover: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var transferAmount = ""
    @State private var selectedGoal: UUID? = nil // Identificador para a meta selecionada

    var body: some View {
        VStack(spacing: 20) {
            // Cabeçalho com os botões de Cancel e Done
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.mediumPurple)
                
                Spacer()
                
                Text("Transfer coins")
                    .font(.headline)
                    .foregroundColor(.cardTextTP)
                
                Spacer()
                
                Button("Done") {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        viewModel.addCoinsToGoal(goalID: goalID, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
                .bold()
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            .padding([.top, .horizontal])

            Divider() // Linha divisória abaixo do cabeçalho

            VStack(alignment: .leading, spacing: 16) {
                // Campo de entrada para o valor a ser transferido
                Text("How many coins do you want to transfer?")
                    .font(.subheadline)
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image("blackIconCoin")
                        .foregroundColor(.purple)
                    
                    TextField("Enter amount", text: $transferAmount)
                        .keyboardType(.numberPad)
                        .padding(.leading, 8)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                // Picker para selecionar a meta
                Text("Transfer to which piggy?")
                    .font(.subheadline)
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .foregroundColor(.purple)
                    
                    Picker("Select piggy bank", selection: $selectedGoal) {
                        Text("Select piggy bank").tag(UUID?.none)
                        ForEach(viewModel.goalBanks) { goal in
                            Text(goal.goalName).tag(goal.goalID)
                        }.foregroundColor(.cardTextTP)
                    }
                    .pickerStyle(MenuPickerStyle())
                    .padding(.leading, 8)
                    .foregroundColor(.cardTextTP)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 400)
        .foregroundColor(.backgroundLightPurple)
        .cornerRadius(20)
        //.shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
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
        .frame(width: 500, height: 400)
        .foregroundColor(.backgroundLightPurple)
        .cornerRadius(20)
        
    }
}




// Preview
#Preview {
    CashBoxView2(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


