//
//  Navigation.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 12/11/24.
//

import Foundation
import SwiftUI

enum ProfileNav: Hashable {
    case home, parentProfile, childProfile(id: UUID)
}

class AppNavigation: ObservableObject {
//    @Environment(\.modelContext) var modelContext
    @Published var path: NavigationPath
    
    @ObservedObject var parentViewModel = ParentViewModel.shared
    static let shared = AppNavigation()
    
    private init() {
        path = NavigationPath()
//        parentViewModel.modelContext = modelContext
    }
    
    func reset(){
        path = .init()
        navigateTo(to: .home)
    }
    
    func navigateTo(to view: ProfileNav){
        path.append(view)
    }
    
    func getDestination(to view: ProfileNav) -> AnyView{
        switch view {
        case .home:
            return AnyView(ProfilesView(parentViewModel: parentViewModel))
        case .parentProfile:
            return AnyView(SelectedChild(parentViewModel: parentViewModel))
        case .childProfile(let id):
            return AnyView(TestProfileChildView(id: id))
        }
    }
}
