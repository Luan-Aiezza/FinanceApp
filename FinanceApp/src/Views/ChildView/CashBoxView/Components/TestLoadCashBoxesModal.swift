//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI
struct TestLoadCashBoxesModal: View {
    @Binding var goals: [GoalBankModel]
    @State private var showEditDeleteOptions: UUID? = nil
    @State private var showEditPopover: Bool = false
    @State private var selectedGoal: GoalBankModel?
    @ScaledMetric(relativeTo: .body) var dynamicSpacing: CGFloat = 32
    var deleteGoal: (_ id: UUID) -> Void

    var body: some View {
        ZStack {
            
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 250))], spacing: dynamicSpacing) {
                    ForEach(goals, id: \.cashBox.id) { goal in
                        ZStack {
                            CashBoxCardView(
                                goalName: goal.cashBox.cashBoxDescription,
                                goalAmount: Float(goal.goalAmount),
                                savedAmount: Float(goal.cashBox.coins)
                            )
                            .frame(maxWidth:.infinity)
                            .padding(8)
                            .cornerRadius(16)
                            .onTapGesture {
                                showEditDeleteOptions = goal.cashBox.id
                            }

                            // Exibir as opções de Editar/Excluir
                            if showEditDeleteOptions == goal.cashBox.id {
                                HStack(spacing: 16) {
                                    Button(action: {
                                        selectedGoal = goal
                                        showEditPopover = true
                                        showEditDeleteOptions = nil
                                    }) {
                                        VStack {
                                            Image(systemName: "pencil")
                                                .foregroundColor(.purple)
                                                .font(.system(size: 24))
                                            Text("Edit")
                                                .foregroundColor(.purple)
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                    }
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8, corners: [.topLeft, .bottomLeft])

                                    Divider()
                                        .frame(width: 1, height: 48)
                                        .background(Color.gray.opacity(0.5))

                                    Button(action: {
                                        deleteGoal(goal.cashBox.id)
                                        showEditDeleteOptions = nil
                                    }) {
                                        VStack {
                                            Image(systemName: "trash")
                                                .foregroundColor(.red)
                                                .font(.system(size: 24))
                                            Text("Delete")
                                                .foregroundColor(.red)
                                                .font(.system(size: 16, weight: .medium))
                                        }
                                        .frame(maxWidth: .infinity)
                                        .padding(.vertical, 16)
                                    }
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(8, corners: [.topRight, .bottomRight])
                                }
                                .frame(width: 250, height: 80)
                                .background(Color(UIColor.systemGray6))
                                .cornerRadius(10)
                                .shadow(radius: 4)
                                .padding(.top, 8)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
            }

                        if showEditPopover, let selectedGoal = selectedGoal {
                ZStack {
                    // Fundo escuro para destacar o modal
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            showEditPopover = false
                        }

                    // Modal centralizado
                    TestNewPiggyBankModal(
                        isPresented: $showEditPopover,
                        goalToEdit: selectedGoal
                    ) { name, amount in
                        
                        if let index = goals.firstIndex(where: { $0.cashBox.id == selectedGoal.cashBox.id }) {
                            goals[index].cashBox.cashBoxDescription = name
                            goals[index].goalAmount = amount
                        }
                    }
                    .frame(width: 500, height: 300)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(radius: 10)
                }
                .transition(.opacity)
                .zIndex(1)
            }
        }
    }
}

// Extensão para arredondar bordas específicas
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = 0.0
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
