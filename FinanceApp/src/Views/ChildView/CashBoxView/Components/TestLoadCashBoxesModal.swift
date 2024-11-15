//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//

import SwiftUI
struct TestLoadCashBoxesModal: View {
    @Binding var goals: [GoalBankModel]
    @State private var showEditDeleteOptions: UUID? = nil
    @State private var showDeleteConfirmation: Bool = false
    @State private var showEditPopover: Bool = false
    @State private var selectedGoal: GoalBankModel?

    // Define a grid layout with 3 columns and reduced row spacing
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) { // Reduced spacing to 12 for tighter rows
                ForEach(goals, id: \.cashBox.id) { goal in
                    ZStack {
                        CashBoxCardView(
                            goalName: goal.cashBox.cashBoxDescription,
                            goalAmount: Float(goal.goalAmount),
                            savedAmount: Float(goal.cashBox.coins)
                        )
                        .frame(width: 270, height: 340) // Ensuring consistent width and height across cards
                        .cornerRadius(16)
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
                                        Text("Edit")
                                            .foregroundColor(.purple)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                }

                                Divider()

                                Button(action: {
                                    showDeleteConfirmation = true
                                    showEditDeleteOptions = nil
                                }) {
                                    VStack {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                        Text("Delete")
                                            .foregroundColor(.red)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                }

                                Divider()

                                Button(action: {
                                    showEditDeleteOptions = nil
                                }) {
                                    VStack {
                                        Image(systemName: "xmark")
                                            .foregroundColor(.gray)
                                        Text("Cancel")
                                            .foregroundColor(.gray)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(10)
                                }
                            }
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            .frame(width: 270)
                        }
                    }
                }
            }
            .padding(.horizontal, 16) // Adjust as necessary
        }
    }
}
