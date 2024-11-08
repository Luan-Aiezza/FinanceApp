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
    
    @State var child: ChildModel?
    @State var wallet: CashBoxModel?
    
    init(id: UUID) {
        self.id = id
        //        showingView = TaskBoard(id: id)
    }
    
    func fetch(){
        do {
            let childDescriptor = FetchDescriptor<ChildModel>(sortBy: [SortDescriptor(\.name)])
            let children = (try? (modelContext?.fetch(childDescriptor) ?? [])) ?? []
            child = children.first(where: {$0.id == id}) ?? ChildModel(name: "No Kid")
            if let wallet = child?.cashBoxes.first(where: {$0.cashBoxDescription == "Wallet"}) {
                self.wallet = wallet
            } else {
                let newCashBox = CashBoxModel(cashBoxDescription: "Wallet")
                child?.cashBoxes.append(newCashBox)
                modelContext?.insert(newCashBox)
                try? modelContext?.save()
            }
        } catch {
            print("Fetch failed")
        }
    }
    
    @Published var actualView: PickerOptions = .profile
    //    @Published var showingView: any View
    
    
    @ViewBuilder
    func changeView(for newView: PickerOptions) -> some View{
        switch newView {
        case .cashBox:
//            CashBoxView2(id: id)
            TestCashBoxView(id: id)
        case .profile:
            TaskBoard(id: id)
        case .history:
            HistoryView(id: id)
        }
    }
    
    
}
