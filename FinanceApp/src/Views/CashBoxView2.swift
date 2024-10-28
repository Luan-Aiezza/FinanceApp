//
//  CashBoxView2.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 27/10/24.
//
import SwiftUI
import SwiftData

// Modelo da meta (Goal)
struct Goal: Identifiable {
    let id = UUID()
    let name: String
    let price: Double
    let requiredCoins: Int
    var savedCoins: Int
    
    var remainingCoins: Int {
        requiredCoins - savedCoins
    }
    
    var progress: Double {
        Double(savedCoins) / Double(requiredCoins)
    }
}

// Visualização de cada meta
struct GoalView: View {
    let goal: Goal
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(goal.name)
                    .font(.headline)
                Spacer()
                Text("Price  R$\(String(format: "%.2f", goal.price))")
                    .font(.subheadline)
            }
            
            Text("You need \(goal.requiredCoins) coins")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            // Barra de progresso
            ProgressView(value: goal.progress)
                .accentColor(.purple)
            
            HStack {
                if goal.savedCoins >= goal.requiredCoins {
                    Text(" You have saved \(goal.savedCoins) coins by now")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                } else {
                    Text("You have saved \(goal.savedCoins) coins by now")
                        .font(.subheadline)
                        .foregroundColor(.purple)
                    
                    Spacer()
                    
                    Text("🔍 You still need \(goal.remainingCoins) to complete")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding()
        .background(Color.purple.opacity(0.1))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

struct CashBoxView2: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel = CashBoxViewModel()
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    // Lista de metas de exemplo
    @State private var goals: [Goal] = [
        Goal(name: "New bike 🚴‍♀️", price: 500.00, requiredCoins: 500, savedCoins: 250),
        Goal(name: "Vacation 🌴", price: 1200.00, requiredCoins: 1200, savedCoins: 800),
        Goal(name: "Laptop 💻", price: 3000.00, requiredCoins: 3000, savedCoins: 1000)
    ]
    
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
                            Image("CoinsImage")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                        .padding(.trailing, 16)
                    }
                    .padding(.top, 16)
                    
                    // Rectangle roxo médio
                    Rectangle()
                        .foregroundColor(.mediumPurple)
                        .frame(width: 870, height: 80)
                        .cornerRadius(30.0)
                        .padding()
                    
                    // Lista de metas
                    ScrollView {
                        VStack(spacing: 20) {
                            ForEach(goals) { goal in
                                GoalView(goal: goal)
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
        }
    }
}

// Preview
#Preview {
    CashBoxView2(id: UUID())
        .modelContainer(for: Item.self, inMemory: true)
}


