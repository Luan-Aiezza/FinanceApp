import SwiftUI
import SwiftData


struct TestCashBoxView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: TestCashBoxViewModel
    
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showNewPiggyBankModal = false
    @State private var showTransferCoinsPopover = false
    @State private var showNewPiggyBankPopover = false
    @State private var showEditDeleteOptions: UUID? = nil // Armazena o ID do card atualmente selecionado para edição/exclusão
    
    @ScaledMetric(relativeTo: .largeTitle) var imageWidth = 272
    @ScaledMetric(relativeTo: .largeTitle) var imageHeight = 17
    @ScaledMetric(relativeTo: .largeTitle) var border = 64
    @ScaledMetric(relativeTo: .largeTitle) var borderButtonH = 44
    @ScaledMetric(relativeTo: .largeTitle) var borderButtonW = 156
    
    let columns = [
            GridItem(.flexible(), spacing: 16),
            GridItem(.flexible(), spacing: 16)
        ]
    
    init(viewModel: TestCashBoxViewModel) {
        self.viewModel = viewModel
    }
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    
    
    var body: some View {
        ZStack {
            Color(red: 0.11, green: 0, blue: 0.16)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(alignment: .center) {
                    HStack {
                        Text("Active Piggy Banks")
                            .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                            .foregroundColor(.white)
                        Spacer()
                        
                        // Botão de transferir moedas
                        TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, goals: $viewModel.goals, addCoinsToGoal: viewModel.addCoinsToGoal)
                            .frame(minWidth: borderButtonW, minHeight: borderButtonH)
                            .background(Color.white)
                            .cornerRadius(24)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                    .offset(x: 0, y: 6)
                            )
                            .padding(.bottom, 4)
                        
                        // Botão de criar novo cofrinho
                        TestButtonCreatePiggyBank(showNewPiggyBankPopover: $showNewPiggyBankPopover, goals: $viewModel.goals, addGoal: viewModel.addGoal)
                            .frame(minWidth: borderButtonW, minHeight: borderButtonH)
                            .background(Color.white)
                            .cornerRadius(24)
                            .background(
                                RoundedRectangle(cornerRadius: 24)
                                    .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                    .offset(x: 0, y: 6)
                            )
                            .padding(.bottom, 4)
                    }
                    .padding(.horizontal, 24)
                    .frame(height: border, alignment: .center)
                    .background(Color(red: 0.36, green: 0, blue: 0.55))
                    .clipShape(RoundedRectangle(cornerRadius: 24))
                }
                
                // Lista de cofrinhos
                TestLoadCashBoxesModal(goals: $viewModel.goals, deleteGoal: viewModel.deleteGoal)
                Spacer()
            }
        }
        .onAppear {
            viewModel.setup(modelContext: modelContext)
            viewModel.fetch()
        }
    }
}
