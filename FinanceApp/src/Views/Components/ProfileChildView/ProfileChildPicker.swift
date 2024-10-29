import SwiftUI

struct ProfileChildPicker: View {
    // Enum para opções do Picker
    enum TopBarOption: String, CaseIterable, Identifiable {
        case profile = "Tasks"
        case cashBox = "Piggy bank"
        case history = "History"
        
        var id: Self { self }
    }
    
    // Estado de seleção do Picker
    @State private var selectedOption: TopBarOption = .profile
    
    var body: some View {
        VStack {
            // Picker no topo
            Picker("Selecione uma opção", selection: $selectedOption) {
                ForEach(TopBarOption.allCases) { option in
                    Text(option.rawValue)
                        .tag(option)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal)
            
            // Navegação condicional com base na seleção do Picker
            if selectedOption == .profile {
                NavigationLink(destination: ProfileChildContent()) {
                    EmptyView()
                }
                .frame(width: 0, height: 0) // NavigationLink oculto para navegação automática
            } else if selectedOption == .history {
                NavigationLink(destination: HistoryView()) {
                    HistoryView()
                }
                .frame(width: 0, height: 0) // NavigationLink oculto para navegação automática

            } else if selectedOption == .cashBox {
                NavigationLink(destination: CashBoxView()) {
                    CashBoxView()
                }
                .frame(width: 0, height: 0)
            }
        }
    }
}

struct ProfileChildContent: View {
    var body: some View {
        VStack {
            HStack {
                // Ícone da criança no canto superior esquerdo
                Button(action: {
                    // Ação do botão (ex: abrir perfil da criança)
                }) {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                }
                .padding(.leading, 16)
                
            }
            .padding(.top, 16)
            
            // Calendário simples (indicando mês)
            Text("Outubro 2024")
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding()
        }
    }
}

// Visualização de teste
#Preview {
    ProfileChildPicker()
}
