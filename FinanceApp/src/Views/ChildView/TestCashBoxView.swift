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
    @ScaledMetric(relativeTo: .largeTitle) var borderButton = 44
    
    init(viewModel: TestCashBoxViewModel){
        self.viewModel = viewModel
        
    }
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    
    var body: some View {
            ZStack {
                Text("")
                    .ignoresSafeArea()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.11, green: 0, blue: 0.16))
                    .ignoresSafeArea()
                VStack (spacing: 20){
                    
                    VStack {
                        //TODO: TIRAR ESSE VALOR DE COINCS WALLET
                        HStack (){
                            Text("Active Piggy Banks")
                                .font(
                                    Font.custom("Pally-Bold", size: 24)
                                        .weight(.medium)
                                )
                                .foregroundColor(.white)
                            Spacer()
                            //TODO: Colocar botão de transferir moedas aqui
                            TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, goals: $viewModel.goals, addCoinsToGoal: viewModel.addCoinsToGoal)
//                                .frame(minHeight: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .frame(height: borderButton)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x:0,y: 6)
                                )
                            
                            TestButtonCreatePiggyBank(showNewPiggyBankPopover: $showNewPiggyBankPopover, goals: $viewModel.goals, addGoal: viewModel.addGoal)
//                                .frame(minHeight: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .frame(height: borderButton)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red:0.73, green:0.57, blue:0.8))
                                        .offset(x: 0, y: 6)
                                    )
                            
                            
                        }
                        .padding(.horizontal,24)
                        .padding(.vertical,16)
                        .frame(height: border, alignment: .center)
                        .background(Color(red:0.36, green:0, blue:0.55))
                        .clipShape(.rect(cornerRadius: 24))
                        
                    }

                    // Lista de piggy banks
                    TestLoadCashBoxesModal(goals: $viewModel.goals)
                    Spacer()
                }
            }
            .onAppear {
                viewModel.setup(modelContext: modelContext)
                viewModel.fetch()
            }
    }
}


//#Preview {
//    TestCashBoxView(id: UUID())
//        .modelContainer(for: Item.self, inMemory: true)
//}

