import SwiftUI
import SwiftData

struct TestCashBoxView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: CashBoxViewModel
    
    @State private var goalName = ""
    @State private var goalAmount = ""
    @State private var transferAmountToGoal = ""
    @State private var addAmountToWallet = ""
    @State private var showNewPiggyBankModal = false
    @State private var showTransferCoinsPopover = false
    @State private var showNewPiggyBankPopover = false
    @State private var showEditDeleteOptions: UUID? = nil
    
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
                
                VStack(spacing: 20) {
                    VStack {
                        HStack {
                            Text("Active Piggy Banks: \(viewModel.wallet.coins)")
                                .font(Font.custom("Pally-Bold", size: 24).weight(.medium))
                                .foregroundColor(.white)
                            Spacer()
                            
                            TestButtonTransferCoins(showTransferCoinsPopover: $showTransferCoinsPopover, viewModel: viewModel)
                                .frame(height: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                        .offset(x: 0, y: 6)
                                )
                            
                            TestButtonCreatePiggyBank(showNewPiggyBankPopover: $showNewPiggyBankPopover, viewModel: viewModel)
                                .frame(height: 17)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(24)
                                .background(
                                    RoundedRectangle(cornerRadius: 24)
                                        .fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                        .offset(x: 0, y: 6)
                                )
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .frame(maxWidth: .infinity, minHeight: 64, maxHeight: 64, alignment: .center)
                    .background(Color(red: 0.36, green: 0, blue: 0.55))
                    .clipShape(.rect(cornerRadius: 24))
                    .background(
                        RoundedRectangle(cornerRadius: 24)
                            .fill(Color(red: 0.25, green: 0, blue: 0.39))
                            .offset(x: 0, y: 6)
                    )
                    
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
