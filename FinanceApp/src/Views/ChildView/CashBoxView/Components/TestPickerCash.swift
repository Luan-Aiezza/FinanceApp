//
//  TestPickerCash.swift
//  FinanceApp
//
//  Created by Grecia Cristina on 08/11/24.
//
import SwiftUI

struct TestPickerCash: View {
    @Binding var selectedGoal: UUID?
    @State var goals: [GoalBankModel]
    
    var body: some View {
        HStack {
            Text("Select piggy bank")
                .font(
                    Font.custom("Pally-Regular", size: 17)
                        .weight(.medium)
                )
                .foregroundColor(Color.black)
                .opacity(0.5)
            Spacer()
            Picker("", selection: $selectedGoal) {
                ForEach(goals) { goal in
                    Text(goal.cashBox.cashBoxDescription).tag(goal.cashBox.id)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding(.leading, 8)
            .foregroundColor(Color.black)
        }
        .frame(minHeight: 40)
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
    }
}
