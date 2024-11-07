//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//

import SwiftUI
import SwiftData

struct TestCashBoxView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: CashBoxViewModel
    
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showTransferCoinsPopover = false
    @State private var showNewPiggyBankPopover = false
    @State private var showEditDeleteOptions: UUID? = nil // Holds the ID of the currently selected card for edit/delete options
    
    init(id: UUID){
        viewModel = CashBoxViewModel(id: id)
    }
    
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background view
                Text("")
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .accessibilityHidden(true) // Decorative element
                
                VStack(spacing: 20) {
                    VStack {
                        // Display current piggy bank information
                        HStack {
                            Text(String(format: NSLocalizedString("Active Piggy Banks: %lld", comment: ""), viewModel.wallet.coins))
                                .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                                .foregroundColor(.white)
//                                .accessibilityLabel(NSLocalizedString("Active Piggy bank", comment: ""))
                                //.accessibilityValue("\(viewModel.wallet.coins) coins")
                            
                            Spacer()
                            
                            // Button for transferring coins
                            TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, viewModel: viewModel)
                                .frame(height: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x:0,y: 6)
                                )
                            
                            // Button for adding new piggy bank
                            TestButtonCreatePiggyBank(showNewPiggyBankPopover: $showNewPiggyBankPopover, viewModel: viewModel)
                                .frame(height: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x: 0, y: 6)
                                )
                        }
                    }
                    .padding(.horizontal,24)
                    .padding(.vertical,8)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                    .background(Color(red:0.36, green:0, blue:0.55))
                    .clipShape(.rect(cornerRadius: 24))
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red:0.25, green:0, blue:0.39))
                            .offset(x: 0, y: 6)
                    )
//                    .accessibilityLabel(NSLocalizedString("Active Piggy Banks", comment: ""))
                    
                    // List of piggy banks
                    TestLoadCashBoxesModal(viewModel: viewModel)
                    Spacer()
                }
            }
            .onAppear {
                viewModel.modelContext = modelContext
                viewModel.fetch()
            }
        }
    }
}

struct TestButtonCreatePiggyBank: View {
    @Binding var showNewPiggyBankPopover: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    
    var body: some View {
        Button(action: {
            showNewPiggyBankPopover.toggle()
            UIAccessibility.post(notification: .announcement, argument: NSLocalizedString("New Piggy Bank", comment: ""))
        }) {
            HStack {
                Image(systemName: "plus")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                Text(NSLocalizedString("New Piggy Bank", comment: ""))
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .multilineTextAlignment(.center)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
            }
        }
        .accessibilityLabel(NSLocalizedString("Add new piggy bank", comment: ""))
        .accessibilityHint(NSLocalizedString("Opens modal to create a new piggy bank", comment: ""))
        .popover(isPresented: $showNewPiggyBankPopover) {
            TestNewPiggyBankModal(
                isPresented: $showNewPiggyBankPopover,
                viewModel: viewModel
            )
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
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                Text(NSLocalizedString("Transfer Coincs", comment: ""))
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
            }
        }
        .accessibilityLabel(NSLocalizedString("Transfer coincs", comment: ""))
        .accessibilityHint(NSLocalizedString("Opens modal to transfer coins from wallet to a goal", comment: ""))
        .disabled(viewModel.goalBanks.isEmpty) // Disabled if there are no goals
        .popover(isPresented: $showTransferCoinsPopover) {
            TransferCoinsPopover(isPresented: $showTransferCoinsPopover, viewModel: viewModel)
                .frame(width: 500, height: 300)
        }
    }
}

struct TestLoadCashBoxesModal: View {
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var showEditDeleteOptions: UUID? = nil
    @State private var showDeleteConfirmation: Bool = false
    @State private var showEditPopover: Bool = false
    @State private var selectedGoal: GoalBankModel?
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.child.goals, id: \.cashBox.id) { goal in
                    ZStack {
                        GoalCardView(
                            goalName: goal.cashBox.cashBoxDescription,
                            goalAmount: Float(goal.goalAmount),
                            savedAmount: Float(goal.cashBox.coins)
                        )
                        .padding(.horizontal, -28)
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(String(format: NSLocalizedString("Goal: %@ with %lld of %lld coins saved", comment: ""), goal.cashBox.cashBoxDescription, goal.cashBox.coins, goal.goalAmount))
                        .onLongPressGesture {
                            showEditDeleteOptions = goal.cashBox.id
                        }

                        if showEditDeleteOptions == goal.cashBox.id {
                            HStack {
                                Button(action: {
                                    selectedGoal = goal
                                    showEditPopover = true
                                    showEditDeleteOptions = nil
                                }) {
                                    VStack {
                                        Image(systemName: "pencil")
                                            .foregroundColor(.purple)
                                        Text(NSLocalizedString("Edit", comment: ""))
                                            .foregroundColor(.purple)
                                    }
                                }
                                .accessibilityLabel(NSLocalizedString("Edit goal", comment: ""))
                                
                                Divider()
                                
                                Button(action: {
                                    showDeleteConfirmation = true
                                    showEditDeleteOptions = nil
                                }) {
                                    VStack {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                        Text(NSLocalizedString("Delete", comment: ""))
                                            .foregroundColor(.red)
                                    }
                                }
                                .accessibilityLabel(NSLocalizedString("Delete goal", comment: ""))
                                
                                Divider()
                                
                                Button(action: {
                                    showEditDeleteOptions = nil
                                }) {
                                    VStack {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.gray)
                                        Text(NSLocalizedString("Cancel", comment: ""))
                                            .foregroundColor(.gray)
                                    }
                                }
                                .accessibilityLabel(NSLocalizedString("Cancel editing", comment: ""))
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                        }
                    }
                    .padding()
                    .alert(isPresented: $showDeleteConfirmation) {
                        Alert(
                            title: Text(NSLocalizedString("Confirm delete", comment: "")),
                            message: Text(NSLocalizedString("Do you want to delete this Piggy Bank? You cannot undo this action.", comment: "")),
                            primaryButton: .destructive(Text(NSLocalizedString("Delete", comment: ""))) {
                                viewModel.removeGoal(goal: goal)
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
            }
            .padding(.horizontal, 16)
            .popover(isPresented: $showEditPopover) {
                if let goal = selectedGoal {
                    TestNewPiggyBankModal(
                        isPresented: $showEditPopover,
                        viewModel: viewModel,
                        goalToEdit: goal
                    )
                    .frame(width: 500, height: 300)
                }
            }
        }
    }
}

struct TestNewPiggyBankModal: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    var goalToEdit: GoalBankModel?
    @State private var goalName = ""
    @State private var goalAmount = ""
    
    init(isPresented: Binding<Bool>, viewModel: CashBoxViewModel, goalToEdit: GoalBankModel? = nil) {
        self._isPresented = isPresented
        self.viewModel = viewModel
        self.goalToEdit = goalToEdit
        _goalName = State(initialValue: goalToEdit?.cashBox.cashBoxDescription ?? "")
        _goalAmount = State(initialValue: "\(goalToEdit?.goalAmount ?? 0)")
    }
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(NSLocalizedString("Cancel", comment: "")) {
                    isPresented = false
                }
                .foregroundColor(.purple)
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Text(goalToEdit == nil ? NSLocalizedString("New Piggy Bank", comment: "") : NSLocalizedString("Edit Piggy Bank", comment: ""))
                    .foregroundColor(.primary)
                    .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                
                Spacer()
                
                Button(NSLocalizedString("Done", comment: "")) {
                    if let amount = Int(goalAmount) {
                        if let goal = goalToEdit {
                            viewModel.updateGoal(goal: goal, name: goalName, amount: amount)
                        } else {
                            viewModel.addGoal(name: goalName, amount: amount)
                        }
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
            }
            
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(NSLocalizedString("What do you want to buy?", comment: ""))
                    
                
                TextField(NSLocalizedString("Enter item", comment: ""), text: $goalName)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                
                Text(NSLocalizedString("How much does it cost?", comment: ""))
                    
                
                TextField("50,00", text: $goalAmount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .accessibilityLabel(NSLocalizedString("Goal amount input", comment: ""))
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
    }
}

struct TransferCoinsPopover: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var transferAmount = ""
    @State private var selectedGoal: UUID? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(NSLocalizedString("Cancel", comment: "")) {
                    isPresented = false
                }
                .foregroundColor(.purple)
                
                Spacer()
                
                Text(NSLocalizedString("Transfer Coincs", comment: ""))
                
                Spacer()
                
                Button(NSLocalizedString("Done", comment: "")) {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        viewModel.addCoinsToGoal(goalID: goalID, amount: amount)
                        isPresented = false
                    }
                }
                .foregroundColor(.mediumPurple)
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Text(NSLocalizedString("How many coincs do you want to transfer?", comment: ""))
                    
                
                TextField(NSLocalizedString("Enter amount", comment: ""), text: $transferAmount)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    
                
                Text(NSLocalizedString("Transfer to which piggy?", comment: ""))
                   
                
                TestPickerCash(selectedGoal: $selectedGoal, viewModel: viewModel)
                    .accessibilityLabel(NSLocalizedString("Select target piggy bank", comment: ""))

            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
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
                .foregroundColor(Color(red: 0.2, green: 0.17, blue: 0.25))
            
            Picker(NSLocalizedString("Select piggy bank", comment: ""), selection: $selectedGoal) {
                Text(NSLocalizedString("Select piggy bank", comment: "")).tag(UUID?.none)
                ForEach(viewModel.child.goals) { goal in
                    Text(goal.cashBox.cashBoxDescription).tag(goal.cashBox.id)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.leading, 8)
            
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
    }
}

#Preview {
    TestCashBoxView(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}
