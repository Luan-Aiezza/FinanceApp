import SwiftUI
import SwiftData

struct SettingsView: View {
    @AppStorage("selectedGuardianIcon") private var selectedGuardianIcon: String = "guardianIcon"
    @AppStorage("guardianName") private var guardianName: String = ""
    @AppStorage("password") private var password: String = ""

    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteAlert = false
    @State private var showEditChildView = false // Controla exibição da edição da criança
    @State private var showEditParentView = false // Controla exibição da edição do responsável
    var updateChildProfile: (_ name: String, _ image: String) -> Void
    var deleteChildProfile: () -> Void

    @Binding var selectedChild: ChildModel
    @Environment(\.modelContext) private var modelContext: ModelContext

    var body: some View {
        VStack {
            // Botão para editar a criança
            Button(action: {
                showEditChildView = true
            }) {
                HStack {
                    Text("Edit this child")
                        .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "pencil.circle")
                        .foregroundStyle(.black)
                }
            }
            .sheet(isPresented: $showEditChildView) {
                EditChildView(child: selectedChild, upDateChildProfile: updateChildProfile)
            }

            Divider()

            // Botão para editar o responsável
            Button(action: {
                showEditParentView = true
            }) {
                HStack {
                    Text("Edit your profile")
                        .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "person.fill")
                        .foregroundStyle(.black)
                }
            }
            .sheet(isPresented: $showEditParentView) {
                EditParentView()
            }

            Divider()

            // Botão para excluir o perfil da criança
            Button(action: {
                showDeleteAlert = true
            }) {
                HStack {
                    Text("Remove this child")
                        .font(Font.custom("Pally-Bold", size: 17).weight(.medium))
                        .foregroundStyle(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    Image(systemName: "person.crop.circle.badge.xmark")
                        .foregroundStyle(.black)
                }
            }
            .alert(isPresented: $showDeleteAlert) {
                Alert(
                    title: Text("Remove child"),
                    message: Text("Are you sure you want to delete this child?"),
                    primaryButton: .destructive(Text("Remove")) {
                        deleteChildProfile()
                        dismiss()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .padding()
    }
}
