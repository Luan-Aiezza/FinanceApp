import SwiftUI
import SwiftData

struct SettingsView: View {
    @State private var showDeleteAlert = false
    @State private var showEditView = false // Variável para controlar exibição da view de edição
    
    @Binding var selectedChild: ChildModel
    @Environment(\.modelContext) private var modelContext: ModelContext
//    @ObservedObject var parentViewModel: ParentViewModel
    
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
//                    let selectedChild = selectedChild {
                        EditChildView(child: selectedChild)
//                    }
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
                            print("Não implementado no SettingsView")
                        },
                        secondaryButton: .cancel()
                    )
                }
                .padding()
            }
            .padding()
        }
    }
    
}
