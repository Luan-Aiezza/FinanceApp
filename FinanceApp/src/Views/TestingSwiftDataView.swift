//
//  TestingSwiftDataView.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 06/11/24.
//

import SwiftUI
import SwiftData

struct TestingSwiftDataView: View {
    
    @Environment(\.modelContext) var context
    @State var showSheet: Bool = false
    @Query var cashBoxes: [CashBoxModel]
    @Query var parents: [ParentModel]
    @Query var children: [ChildModel]
    
    var body: some View {
        VStack {
            Text("Goals")
            ForEach(children){ child in
                HStack {
                    Text("\(child.name) - \(child.id)")
                    ForEach(child.goals){ goal in
                        Text("- \(goal.cashBox.cashBoxDescription)")
                    }
                }.padding()
                    .background(Color.red)
            }
            Text("Childdren from parent")
            if let childs = parents.first?.childs {
                ForEach(childs){child in
                    HStack {
                        Text("\(child.name) - \(child.id)")
                        ForEach(child.goals){ goal in
                            Text("- \(goal.cashBox.cashBoxDescription)")
                        }
                    }.padding()
                        .background( Color.blue)
                }
            }
        }
    }
}

#Preview {
    TestingSwiftDataView()
}
