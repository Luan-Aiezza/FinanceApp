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
    
    @ObservedObject var testParentVIewModel: TestParentViewModel
    
    init(){
        testParentVIewModel = .init()
    }
    
    var body: some View {
        VStack {
            Text("\(testParentVIewModel.parent?.name ?? "No Parent")")
            Spacer()
            Button(action: {testParentVIewModel.addChild(name: "Child \(children.count)")})
            {
                Text("Adicionar novo filho")
            }
            ForEach(testParentVIewModel.parent?.childs ?? []){ child in
                Button(action: {testParentVIewModel.addTaskChild(child: child, taskDescription: "\(child.name) varrer", value: "2", recurrent: true, effort: .easy, frequency: .daily)}){
                    Text("\(child.name)")
                }
               ForEach(child.tasks){ task in
                    Text("- \(task.taskDescription)")
                    
                }
            }
        }
        .onAppear {
            testParentVIewModel.setup(modelContext: context)
            testParentVIewModel.fetch()
        }
    }
}

//#Preview {
//    TestingSwiftDataView()
//}
