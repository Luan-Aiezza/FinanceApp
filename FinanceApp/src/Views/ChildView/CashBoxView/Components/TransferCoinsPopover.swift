import SwiftUI
struct TransferCoinsPopover: View {
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: CashBoxViewModel
    @State private var transferAmount = ""
    @State private var selectedGoal: UUID? = nil // Identificador para a meta selecionada

    var body: some View {
        VStack(spacing: 20) {
            // Cabeçalho com os botões de Cancel e Done
            HStack {
                Button("Cancel") {
                    isPresented = false
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
                
                Spacer()
                
                Text("Transfer coincs")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(.primary)
                
                Spacer()
                
                Button("Done") {
                    if let goalID = selectedGoal, let amount = Int(transferAmount) {
                        viewModel.addCoinsToGoal(goalID: goalID, amount: amount)
                        isPresented = false
                    }
                }
                .font(Font.custom("Pally-Bold", size: 17).weight(.medium)
                ).foregroundColor(Color(red: 0.36, green: 0.0, blue: 0.55))
                .disabled(selectedGoal == nil || transferAmount.isEmpty || Int(transferAmount) ?? 0 <= 0)
            }
            .padding([.bottom, .horizontal])
            
            Divider() // Linha divisória abaixo do cabeçalho
            
            VStack(alignment: .leading, spacing: 16) {
                // Campo de entrada para o valor a ser transferido
                Text("How many coincs do you want to transfer?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                HStack {
                    Image(systemName: "magnifyingglass") // Use um ícone padrão ou substitua conforme necessário
                        .foregroundColor(.gray)
                    
                    TextField("Enter amount", text: $transferAmount)
                        .keyboardType(.numberPad)
                        .padding(.leading, 8)
                        .font(
                            Font.custom("Pally-Bold", size: 17)
                                .weight(.medium)
                        )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.5)))
                
                // Picker para selecionar a meta
                Text("Transfer to which piggy?")
                    .font(
                        Font.custom("Pally-Bold", size: 17)
                            .weight(.medium)
                    )
                    .foregroundColor(Color.black.opacity(0.7))
                
                TestPickerCash(selectedGoal: $selectedGoal, viewModel: viewModel)
            }
            .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 300)
        .cornerRadius(20)
    }
}
