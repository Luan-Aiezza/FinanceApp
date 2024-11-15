//
//  Untitled.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI
import SwiftUI

struct TestLoadCashBoxesModal: View {
    @Binding var goals: [GoalBankModel]
    @State private var showEditDeleteOptions: UUID? = nil // Stores the ID of the card currently selected for editing/deleting
    @State private var showDeleteConfirmation: Bool = false // Controls the display of the confirmation alert
    @State private var showEditPopover: Bool = false // Controls the display of the edit popover
    @State private var selectedGoal: GoalBankModel? // Stores the selected goal for editing

    // Define a grid layout with 3 columns
    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) { // Adjust spacing as needed
                ForEach(goals, id: \.cashBox.id) { goal in
                    ZStack {
                        CashBoxCardView(
                            goalName: goal.cashBox.cashBoxDescription,
                            goalAmount: Float(goal.goalAmount),
                            savedAmount: Float(goal.cashBox.coins)
                        )
                        .frame(width: 290, height: 340) // Adjust width and height as needed
                        .background(Color.white) // Ensures a white background within each card
                        .cornerRadius(16) // Rounded corners for each card
                        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 4) // Shadow for a floating effect
                        .padding(.horizontal, 8)
                        .onLongPressGesture {
                            showEditDeleteOptions = goal.cashBox.id
                        }

                        // Show edit, delete, and cancel buttons when the card is pressed
                        if showEditDeleteOptions == goal.cashBox.id {
                            HStack {
                                Button(action: {
                                    // Opens the edit popover and loads data of the selected goal
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

                                Divider() // Divider between the buttons

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

                                Divider() // Divider between the buttons

                                Button(action: {
                                    // Hides options without taking any action
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
                            .frame(width: 300) // Adjust width as needed
                        }
                    }
                    .padding()
                }
            }
            .padding(.horizontal, 16)
        }
    }
}
