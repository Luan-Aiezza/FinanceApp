import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var showDeleteAlert = false
    
    @Binding var selectedChild: ChildModel?
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var parentViewModel: ParentViewModel // Observar o ParentViewModel para atualizar a lista de crianças
    
    var body: some View {
        ZStack{
            VStack {
//                Text("Configurations")
//                    .font(Font.custom("Pally-Bold", size: 48).weight(.heavy))
//                    .foregroundColor(.white)
//                    .frame(maxWidth: .infinity, alignment: .center)
                //BOTAO 1
                Button(action: {
                    // Exibe o alerta quando o botão for pressionado
                }) {
                    HStack{
                        Text("Edit child")
                            .font(
                                Font.custom("Pally-Regular", size: 17)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "pencil.circle")
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(alignment: .leading)
                    }
                }
                .padding()
                
                Divider()
                //BOTAO 2
                Button(action: {
                    // Exibe o alerta quando o botão for pressionado
                    showDeleteAlert = true
                }) {
                    HStack{
                        Text("Remove child")
                            .font(
                                Font.custom("Pally-Regular", size: 17)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "person.crop.circle.badge.xmark")
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(alignment: .leading)
                    }
                }
                .alert(isPresented: $showDeleteAlert) {
                    Alert(
                        title: Text("Remove child"),
                        message: Text("Are you sure you want to delete this child?"),
                        primaryButton: .destructive(Text("Remove")) {
                            deleteChild()
                        },
                        secondaryButton: .cancel() // Botão de cancelar
                    )
                }
                .padding()
                
                Divider()
                //BOTAO 3
                Button(action: {
                    // Exibe o alerta quando o botão for pressionado
                }) {
                    HStack{
                        Text("Support")
                            .font(
                                Font.custom("Pally-Regular", size: 17)
                                    .weight(.medium)
                            )
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "questionmark.circle.fill")
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(alignment: .leading)
                    }
                }
                .padding()
                
            }
            .padding()
        }
    }
    
    // Função que deleta a criança selecionada
    func deleteChild() {
        guard let childToDelete = selectedChild else {
            print("No children selected to delete.")
            return
        }
        
        // Deleta a criança do modelo
        modelContext.delete(childToDelete)
        
        // Salva as alterações
        do {
            try modelContext.save()
            print("\(childToDelete.name) has been successfully deleted.")
            
            // Atualiza a lista de crianças no ParentViewModel
            parentViewModel.removeChild(childToDelete)
        } catch {
            print("Error saving context after deletion: \(error)")
        }
        
        // Limpa a criança selecionada após a exclusão
        selectedChild = nil
    }
}
