//
//  ProfileChildViewModel.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 29/10/24.
//
import Foundation
import SwiftUI

class ProfileChildViewModel: ObservableObject{
    let id: UUID
    init(id: UUID) {
        self.id = id
        //        showingView = TaskBoard(id: id)
    }
    @Published var actualView: PickerOptions = .profile
    //    @Published var showingView: any View
    
    
    @ViewBuilder
    func changeView(for newView: PickerOptions) -> some View{
        switch newView {
        case .cashBox:
            CashBoxView()
        case .profile:
            TaskBoard(id: id)
        case .history:
            HistoryView()
        }
    }
    
    
}
