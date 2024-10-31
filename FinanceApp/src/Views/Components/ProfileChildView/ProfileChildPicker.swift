import SwiftUI

struct ProfileChildPicker: View {
    // Estado de seleção do Picker
    @ObservedObject var viewModel: ProfileChildViewModel
    
    var body: some View {
        VStack {
            // Picker no topo
            Picker("Selecione uma opção", selection: $viewModel.actualView) {
                ForEach(PickerOptions.allCases) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
        }
    }
}
