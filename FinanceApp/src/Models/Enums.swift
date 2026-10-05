//
//  Enums.swift
//  FinanceApp
//
//  Created by Joseph Pereira on 23/10/24.
//

import Foundation

public enum FrequencyTypes: String, Codable {
    case daily, weekly, monthly, none
}

enum EffortTypes: String, Codable, CaseIterable{
    case easy, medium, hard
}
// Enum para opções do Picker do filho
enum PickerOptions: String, CaseIterable, Identifiable {
    case profile = "Tasks"
    case cashBox = "Piggy bank"
    case history = "History"
    
    var id: Self { self }
}

// Enum para opções do Picker do pai
enum PickerOptions2: String, CaseIterable, Identifiable {
    case childs = "Childs"
    case createTasks = "Tasks"
    case history = "History"
    
    var id: Self { self }
}
