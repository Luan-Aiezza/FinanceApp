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
    
    @Published var child: ChildModel?
    @Published var wallet: CashBoxModel?
    
    @Published var cashBoxVM: TestCashBoxViewModel
    @Published var historyVM: TestHistoryViewModel
    
    init(id: UUID) {
        self.id = id
        cashBoxVM = .init(id: id)
        historyVM = .init(id: id)
        //        showingView = TaskBoard(id: id)
    }
    
    func setup(modelContext: ModelContext){
//        parentService = .init(modelContext: modelContext)
//        childService = .init(modelContext: modelContext)
        cashBoxVM.setup(modelContext: modelContext)
        historyVM.setup(modelContext: modelContext)
        
    }
    
    func fetch(){
        cashBoxVM.fetch()
        child = cashBoxVM.child
        wallet = cashBoxVM.wallet
    }
    
    @Published var actualView: PickerOptions = .profile
    //    @Published var showingView: any View
    
    
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
