//
//  CashBoxView.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 21/10/24.
//

import SwiftUI


//:TODO naO CONSEGUIR ADD UM NUMERO DE MOEDAS MAIOR DO QUE A META PORTA

struct CashBoxView: View {
    @ObservedObject var viewModel = CashBoxViewModel()
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    
    var body: some View {
        VStack(spacing: 20) {
            
            // WALLET
            VStack {
                HStack {
                    Text("Wallet Balance: \(viewModel.wallet.coins) coins")
                        .font(.title2)
                        .padding()
                    
                    TextField("Add coins to wallet", text: $addAmountToWallet)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        if let amount = Int(addAmountToWallet), amount > 0 {
                            viewModel.addCoinsToWallet(amount: amount)
                            addAmountToWallet = ""
                        }
                    }) {
                        Text("Add to Wallet")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding(.leading, 10)
                }
                .padding(.top, 10)
                
                // METAS
                Text("Goal Savings")
                    .font(.title)
                    .padding()
                
                List {
                    ForEach(viewModel.goalBanks, id: \.goalName) { goal in
                        
                        let progress = Double(goal.coins) / Double(goal.goalAmount)
                        let backgroundColor: Color = {
                            switch progress {
                            case 0..<0.30:
                                return Color.red.opacity(0.3)
                            case 0.31..<0.65:
                                return Color.yellow.opacity(0.3)
                            case 0.66..<0.99:
                                return Color.green.opacity(0.3)
                            case 1.0:
                                return Color.yellow.opacity(0.7)
                            default:
                                return Color.gray.opacity(0.1)
                            }
                        }()
                        
                        VStack(alignment: .leading) {
                            Text(goal.goalName)
                                .font(.headline)
                            Text("Goal Amount: \(goal.goalAmount) coins")
                            Text("Saved: \(goal.coins) coins")
                            
                            if progress >= 1.0 {
                                Text("🎉 Congratulations, goal achieved! 🎉")
                                    .font(.subheadline)
                                    .foregroundColor(.black)
                                    .padding(.top, 5)
                            } else {
                                HStack {
                                    TextField("Transfer Coins", text: $transferAmountToGoal)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .keyboardType(.numberPad)
                                    
                                    Button(action: {
                                        if let amount = Int(transferAmountToGoal), amount > 0 {
                                            if amount <= viewModel.wallet.coins {
                                                viewModel.addCoinsToGoal(goalName: goal.goalName, amount: amount)
                                                transferAmountToGoal = ""
                                            } else {
                                                print("Erro: valor a transferir é maior que o saldo da Wallet")
                                            }
                                        }
                                    }) {
                                        Text("Add to Goal")
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .padding(.leading, 10)
                                }
                                .padding(.top, 10)
                            }
                            
                            
                            Button(action: {
                                viewModel.removeGoal(goalName: goal.goalName)
                            }) {
                                Text("Delete Goal")
                                    .foregroundColor(.red)
                            }
                            .padding(.top, 5)
                        }
                        .padding()
                        .background(backgroundColor)
                        .cornerRadius(10)
                    }
                }
                
                
                VStack {
                    TextField("Goal Name", text: $goalName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Goal Amount", text: $goalAmount)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.numberPad)
                    
                    Button(action: {
                        if let amount = Int(goalAmount), !goalName.isEmpty {
                            viewModel.addGoal(name: goalName, amount: amount)
                            goalName = ""
                            goalAmount = ""
                        }
                    }) {
                        Text("Add Goal")
                    }
                    .buttonStyle(.borderedProminent)
                    .padding()
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
        }
        .padding()
    }
}

struct CashBoxView_Previews: PreviewProvider {
    static var previews: some View {
        CashBoxView(viewModel: CashBoxViewModel())
    }
}
