//
//  ProfileChildViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 29/10/24.
//
import Foundation
import SwiftUI
import SwiftData

class ProfileChildViewModel: ObservableObject{
    let id: UUID
    var modelContext: ModelContext? = nil
    
    private var parentService: Service<ParentModel>?
    private var childService: Service<ChildModel>?
    
    @Published var actualView: PickerOptions = .profile
    
    @Published var child: ChildModel?
    @Published var wallet: CashBoxModel?
    
    @Published var cashBoxVM: TestCashBoxViewModel
    @Published var historyVM: TestHistoryViewModel
    
    init(id: UUID) {
        self.id = id
        cashBoxVM = .init(id: id)
        historyVM = .init(id: id)
        
    }
    
    func setup(modelContext: ModelContext){
        cashBoxVM.setup(modelContext: modelContext)
        historyVM.setup(modelContext: modelContext)
        
    }
    
    func fetch(){
        cashBoxVM.fetch()
        child = cashBoxVM.child
        wallet = cashBoxVM.wallet
        print("Instancia ProfileCHild")
        print("ProfileChildVM - \(actualView) atualmente")
    }
    
    
    @ViewBuilder
    func changeView(for newView: PickerOptions) -> some View{
        switch newView {
        case .cashBox:
//            CashBoxView2(id: id)
            TestCashBoxView(viewModel: cashBoxVM)
        case .profile:
            TaskBoard(id: id)
        case .history:
            HistoryView(viewModel: historyVM)
            
        }
    }
    
    
}
