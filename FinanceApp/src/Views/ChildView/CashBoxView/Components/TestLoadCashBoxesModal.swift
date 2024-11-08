//
//  Untitled.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI
struct TestLoadCashBoxesModal: View {
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var showEditDeleteOptions: UUID? = nil // Armazena o ID do card atualmente selecionado para edição/exclusão
    @State private var showDeleteConfirmation: Bool = false // Controla a exibição do alerta de confirmação
    @State private var showEditPopover: Bool = false // Controla a exibição do popover de edição
    @State private var selectedGoal: GoalBankModel? // Armazena o objetivo selecionado para edição
    
    var body: some View {
        ScrollView {
            VStack() {
                ForEach(viewModel.child.goals, id: \.cashBox.id) { goal in
                    ZStack {
                        GoalCardView(
                            goalName: goal.cashBox.cashBoxDescription,
                            goalAmount: Float(goal.goalAmount),
                            savedAmount: Float(goal.cashBox.coins)
                        ).padding(.horizontal, -28)
                        .onLongPressGesture {
                            showEditDeleteOptions = goal.cashBox.id
                        }

                        // Mostra os botões de editar, deletar e cancelar quando o card é pressionado
                        if showEditDeleteOptions == goal.cashBox.id {
                            HStack {
                                Button(action: {
                                    // Abre o popover de edição e carrega os dados do objetivo selecionado
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

                                Divider() // Linha divisória entre os botões

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

                                Divider() // Linha divisória entre os botões

                                Button(action: {
                                    // Oculta as opções sem realizar nenhuma ação
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
                            .frame(width: 300) // Ajuste a largura conforme necessário
                        }
                    }
                    .padding()
                    .alert(isPresented: $showDeleteConfirmation) {
                        Alert(
                            title: Text("Confirm delete"),
                            message: Text("Do you want to delete this Piggy Bank? You cannot undo this action."),
                            primaryButton: .destructive(Text("Delete")) {
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
                        goalToEdit: goal // Passa o objetivo para edição
                    )
                }
            }
        }
    }
}

