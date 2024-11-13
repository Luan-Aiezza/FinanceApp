import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var showDeleteAlert = false
    @State private var showEditView = false // Variável para controlar exibição da view de edição
    
    @Binding var selectedChild: ChildModel?
    @Environment(\.modelContext) private var modelContext: ModelContext
    @ObservedObject var parentViewModel: ParentViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    // Exibe a view de edição
                    showEditView = true
                }) {
                    HStack {
                        Text("Edit child")
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
                        Spacer()
                        Image(systemName: "pencil.circle")
                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                            .frame(alignment: .leading)
                    }
                }
                .padding()
                .sheet(isPresented: $showEditView) {
                    if let selectedChild = selectedChild {
                        EditChildView(child: selectedChild, parentViewModel: parentViewModel)
                    }
                }
                .background(Color(red: 0.7, green: 0.7, blue: 0.7))
                    .preferredColorScheme(.light)
                
                Divider()
                
                Button(action: {
                    showDeleteAlert = true
                }) {
                    HStack {
                        Text("Remove this child")
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
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
                        secondaryButton: .cancel()
                    )
                }
                .padding()
                
//                Divider()
//                
//                Button(action: {
//
//                }) {
//                    HStack {
//                        Text("Edit your profile")
//                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
//                        Spacer()
//                        Image(systemName: "questionmark.circle")
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(alignment: .leading)
//                    }
//                }.padding()
//                
//                Divider()
//                
//                Button(action: {
////
//                }) {
//                    HStack {
//                        Text("Edit password")
//                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
//                        Spacer()
//                        Image(systemName: "questionmark.circle")
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(alignment: .leading)
//                    }
//                }.padding()
//                
//                Divider()
//                
//                Button(action: {
////
//                }) {
//                    HStack {
//                        Text("Support")
//                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
//                        Spacer()
//                        Image(systemName: "questionmark.circle")
//                            .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
//                            .frame(alignment: .leading)
//                    }
//                }.padding()
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
//            parentViewModel.removeChild(childToDelete)
        } catch {
            print("Error saving context after deletion: \(error)")
        }
        
        // Limpa a criança selecionada após a exclusão
        selectedChild = nil
    }
}
