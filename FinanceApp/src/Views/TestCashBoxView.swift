//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//

//TODO: Sombreamento dos botoes

//TODO: FONTE DOS TEXTOS

//TODO:  CARD EM SI ASSIM COMO O SOMBREAMENTO DELE


import SwiftUI
import SwiftData

struct TestCashBoxView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: CashBoxViewModel
    
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
//    @State private var showNewPiggyBankModal = false
    @State private var showTransferCoinsPopover = false
    @State private var showNewPiggyBankPopover = false
    @State private var showEditDeleteOptions: UUID? = nil // Armazena o ID do card atualmente selecionado para edição/exclusão
    
    init(id: UUID){
        viewModel = CashBoxViewModel(id: id)
        
    }
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Text("")
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                VStack {
                    
                    VStack {
//                        Rectangle()
//                            .foregroundColor(.mediumPurple)
//                            .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .leading)
//                            .cornerRadius(50.0)
                        
                        HStack {
                            Text("Active Piggy Banks \(viewModel.wallet.coins)")
                                .font(.title)
                                .foregroundColor(.white)
                               // .padding(.leading)
                            
                            //Text("\(viewModel.child.cashBoxes.count)")
                            //Text("\(viewModel.wallet.cashBoxDescription)")
                            //Button(action: {viewModel.addCoinsOnWallet(amount: 2)}){
                            //    Text("Add 2 coins")
                            //}
                            
                            Spacer()
                            //TODO: Colocar botão de adicionar meta aqui
//                            Button(action: {
//                                showNewPiggyBankModal.toggle()
//                            }) {
//                                HStack {
//                                    Image(systemName: "plus")
//                                    Text("New Piggy Bank")
//                                }
//                                .padding()
//                                .background(Color.white)
//                                .foregroundColor(.purple)
//                                .cornerRadius(20)
//                            }
//                            .padding(.trailing)
                            TestButtonCreatePiggyBank(showNewPiggyBankPopover: $showNewPiggyBankPopover, viewModel: viewModel)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 24)
//                                        .fill(Color(red:0.85, green:0.76, blue:0.89))
//                                        .offset(x:0,y: 6)
//                                        
//                                )
                            
                            
                            
                            //TODO: Colocar botão de transferir moedas aqui
                            TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, viewModel: viewModel)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.85, green:0.76, blue:0.89))
                                        .offset(x:0,y: 6)
                                        
                                )
                        }.padding(.trailing)
                    }
                    .padding(.horizontal,24)
                    .padding(.vertical,8 )
                    .frame(maxWidth: .infinity,minHeight:64,maxHeight: 64, alignment: .center)
                    .background(Color(red:0.36, green:0, blue:0.55))
                    .clipShape(.rect(cornerRadius: 24))
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                        .fill(Color(red:0.25, green:0, blue:0.39))
                    
                        .offset(x: 0, y: 6)
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
//        .sheet(isPresented: $showNewPiggyBankModal) {
//            TestNewPiggyBankModal(isPresented: $showNewPiggyBankModal, viewModel: viewModel)
//        }
    }
}

struct TestButtonCreatePiggyBank: View {
    @Binding var showNewPiggyBankPopover: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        Button(action: {
            showNewPiggyBankPopover.toggle()
        }) {
            
            HStack {
                Image(systemName: "plus").foregroundColor(.cardTextTP)
                Text("New Piggy Bank")
                    .foregroundColor(.cardTextTP)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .frame(width: 200, height: 40)
            
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red:0.73, green:0.57, blue:0.8))
                    .offset(x:0,y: 6)
            )
            
            
        }
//        .background(
//            RoundedRectangle(cornerRadius: 24)
//                .fill(Color(red:0.85, green:0.76, blue:0.89))
//                .offset(x:0,y: 6)
                
        
        .popover(isPresented: $showNewPiggyBankPopover) {
            TestNewPiggyBankModal(isPresented: $showNewPiggyBankPopover, viewModel: viewModel)
                .frame(width: 500, height: 400)
        }
        
    }
}

struct TestButtonTransferCoins: View {
    @Binding var showTransferCoinsPopover: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        Button(action: {
            showTransferCoinsPopover.toggle()
        }) {
            HStack {
                Image(systemName: "arrow.right.arrow.left")
                    .foregroundColor(.cardTextTP)
                Text("Transfer Coincs")
                    .foregroundColor(.cardTextTP)
            }
//            .padding()
//            .background(viewModel.goalBanks.isEmpty ? Color.gray : Color.white)
//            .cornerRadius(20)
//            .frame(width: 200, height: 40)
//            .shadow(color: viewModel.goalBanks.isEmpty ? Color.clear : Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
            .padding()
            .background(Color.white)
            .cornerRadius(20)
            .frame(width: 200, height: 40)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(Color(red:0.73, green:0.57, blue:0.8))
                    .offset(x:0,y: 6)
            )
            }
        .disabled(viewModel.goalBanks.isEmpty) // Desativa o botão se não houver metas
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                .frame(width: 500, height: 400)
        }
        .padding(.trailing)
    }
}


struct TestLoadCashBoxesModal: View {
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var showEditDeleteOptions: UUID? = nil // Armazena o ID do card atualmente selecionado para edição/exclusão

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(viewModel.child.goals, id: \.cashBox.id) { goal in
                    ZStack {
                        GoalCardView(
                            goalName: goal.cashBox.cashBoxDescription,
                            goalAmount: Double(goal.goalAmount),
                            savedAmount: Double(goal.cashBox.coins)
                        )
                        .onLongPressGesture {
                            showEditDeleteOptions = goal.cashBox.id
                        }

                        // Mostra os botões de editar e deletar quando o card é pressionado
                        if showEditDeleteOptions == goal.cashBox.id {
                            VStack {
                                Button(action: {
                                    // Lógica para editar o card
                                    //editGoal(goal)
                                    showEditDeleteOptions = nil // Fecha o modo de edição após uso
                                }) {
                                    Text("Edit")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.blue)
                                        .cornerRadius(10)
                                }
                                .padding(.bottom, 5)

                                Button(action: {
                                    // Lógica para deletar o card
                                   // deleteGoal(goal)
                                    showEditDeleteOptions = nil // Fecha o modo de exclusão após uso
                                }) {
                                    Text("Delete")
                                        .foregroundColor(.white)
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(10)
                                }
                            }
                            .transition(.scale)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // Funções para editar e deletar o objetivo
//    private func editGoal(_ goal: GoalModel) {
//        // Implementação da lógica de edição do objetivo
//    }
//
//    private func deleteGoal(_ goal: GoalModel) {
//        viewModel.removeGoal(goal)
//    }
}



struct TestNewPiggyBankModal: View {
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
                        .padding(.bottom)
                    
                    Text("How much does it cost?")
                        .font(.subheadline)
                        .foregroundColor(.cardTextTP)
                    
                    //.padding()
    
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
            .frame(width: 500, height: 350)
            .foregroundColor(.backgroundLightPurple)
            .cornerRadius(20)
    
        }
    }


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
                    
                    //TODO: Adicionar aqui o picker
                    TestPickerCash(selectedGoal: $selectedGoal, viewModel: viewModel)
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

struct TestPickerCash: View {
    @Binding var selectedGoal: UUID?
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "arrowshape.turn.up.right.circle.fill")
                .foregroundColor(.purple)

            Picker("Select piggy bank", selection: $selectedGoal) {
                Text("Select piggy bank").tag(UUID?.none)
                ForEach(viewModel.child.goals) { goal in
                    Text(goal.cashBox.cashBoxDescription).tag(goal.cashBox.id)
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
}
#Preview {
    TestCashBoxView(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


