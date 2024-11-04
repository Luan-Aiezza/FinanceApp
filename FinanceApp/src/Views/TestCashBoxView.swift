//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//


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
                                .font(
                                    Font.custom("Pally-Bold", size: 30)
                                        .weight(.medium)
                                )
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
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x: 0, y: 6)
                                    )
                            
                            
                            
                            //TODO: Colocar botão de transferir moedas aqui
                            TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, viewModel: viewModel)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x:0,y: 6)
                                )
                            
                            
                        }
                        
                        
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
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
            }
            
        }
//        .background(
//            RoundedRectangle(cornerRadius: 24)
//                .fill(Color(red:0.85, green:0.76, blue:0.89))
//                .offset(x:0,y: 6)
                
        
        .popover(isPresented: $showNewPiggyBankPopover) {
            TestNewPiggyBankModal(isPresented: $showNewPiggyBankPopover, viewModel: viewModel)
                .frame(width: 500, height: 300)
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
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
            }
//            .padding()
//            .background(viewModel.goalBanks.isEmpty ? Color.gray : Color.white)
//            .cornerRadius(20)
//            .frame(width: 200, height: 40)
//            .shadow(color: viewModel.goalBanks.isEmpty ? Color.clear : Color.purple.opacity(0.4), radius: 8, x: 0, y: 4)
            }
        .disabled(viewModel.goalBanks.isEmpty) // Desativa o botão se não houver metas
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                .frame(width: 500, height: 300)
        }
        .padding(.trailing)
    }
}


struct TestLoadCashBoxesModal: View {
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var showEditDeleteOptions: UUID? = nil // Armazena o ID do card atualmente selecionado para exclusão
    @State private var showDeleteConfirmation: Bool = false // Controla a exibição do alerta de confirmação

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

                        // Mostra o botão de deletar quando o card é pressionado
                        if showEditDeleteOptions == goal.cashBox.id {
                            VStack {
                                Button(action: {
                                    showDeleteConfirmation = true
                                    showEditDeleteOptions = nil // Esconde o botão após pressionar "Delete"
                                }) {
                                    HStack {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                        Text("Delete")
                                            .foregroundColor(.red)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .shadow(radius: 5)
                                }
                            }
                            .transition(.scale)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .alert(isPresented: $showDeleteConfirmation) {
                        Alert(
                            title: Text("Confirm delete"),
                            message: Text("Do you want to delete this PigBank? You cannot undo this action."),
                            primaryButton: .destructive(Text("Delete")) {
                                deleteGoal(goal) // Chamando a função deleteGoal com o goal selecionado
                            },
                            secondaryButton: .cancel()
                        )

                    }
                }
            }
            .padding(.horizontal, 16)
        }
    }

    // Função para deletar o objetivo
    private func deleteGoal(_ goal: GoalBankModel) {
        viewModel.removeGoal(goalID: goal.cashBox.id)
    }
}




struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    var body: some View {
        VStack(spacing: 20) {
            // Cabeçalho com os botões de "Cancel" e "Done"
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .foregroundColor(.mediumPurple) // Cor personalizada para o botão Cancel
                //.font(.headline)
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                
                Spacer()
                
                Text("New Piggy Bank")
                    //.font(.headline)
                    .foregroundColor(.texts)
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                
                Spacer()
                
                Button("Done") {
                    if let amount = Int(goalAmount) {
                        viewModel.addGoal(name: goalName, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple) // Cor personalizada para o botão Done
                .bold()
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
            }
            .padding([.top, .horizontal])
            Divider()
            // Campos de entrada com ícones e estilo
            VStack(alignment: .leading, spacing: 8) {
                Text("What do you want to buy?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    TextField("Enter item", text: $goalName)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                        .overlay(
                            HStack {
                                Spacer()
                                if !goalName.isEmpty {
                                    Button(action: { goalName = "" }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .foregroundColor(.gray)
                                            .padding(.trailing, 8)
                                    }
                                }
                            }
                        )
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5))
                )
                Spacer()
                
                Text("How much does it cost?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image("blackIconCoin" )
                        .padding()
//                    Text("R$")
//                        .foregroundColor(.gray)
//                        .padding(.leading, 8)
                    
                    TextField("50,00", text: $goalAmount)
                        .keyboardType(.numberPad)
                        //.padding()
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.5))
                )
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6)) // Fundo para parecer mais com o estilo da imagem
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(width: 500, height: 300)
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
                .foregroundColor(.mediumPurple) // Substitua por uma cor personalizada se necessário
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                
                Spacer()
                
                Text("Transfer coincs")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("Done") {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        viewModel.addCoinsToGoal(goalID: goalID, amount: amount)
                        isPresented = false
                    }
                }
                .font(
                    Font.custom("Pally-Bold", size: 17)
                        .weight(.medium)
                )
                .foregroundColor(.mediumPurple)
                .bold()
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            .padding([.horizontal])
            .padding(.top, 40) // Ajuste de espaçamento superior
            
            Divider() // Linha divisória abaixo do cabeçalho
            
            VStack(alignment: .leading, spacing: 16) {
                // Campo de entrada para o valor a ser transferido
                Text("How many coincs do you want to transfer?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image(systemName: "magnifyingglass") // Use um ícone padrão ou substitua conforme necessário
                        .foregroundColor(.gray)
                    
                    TextField("Enter amount", text: $transferAmount)
                        .keyboardType(.numberPad)
                        .padding(.leading, 8)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                // Picker para selecionar a meta
                Text("Transfer to which piggy?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                TestPickerCash(selectedGoal: $selectedGoal, viewModel: viewModel)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 300)
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
    }
}

struct TestPickerCash: View {
    @Binding var selectedGoal: UUID?
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "arrowshape.turn.up.right.circle.fill")
                .foregroundColor(.backgroundDarkPurple) // Cor destacada para o ícone
            
            Picker("Select piggy bank", selection: $selectedGoal) {
                Text("Select piggy bank").tag(UUID?.none)
                ForEach(viewModel.child.goals) { goal in
                    Text(goal.cashBox.cashBoxDescription).tag(goal.cashBox.id)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.leading, 8)
            .foregroundColor(.backgroundDarkPurple) // Ajuste da cor do texto para maior contraste
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
