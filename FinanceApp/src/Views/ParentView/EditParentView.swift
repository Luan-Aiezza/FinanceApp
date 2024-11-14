import SwiftUI

struct EditParentView: View {
    @AppStorage("selectedGuardianIcon") private var selectedGuardianIcon: String = "guardianIcon"
    @AppStorage("guardianName") private var guardianName: String = ""
    @Environment(\.dismiss) private var dismiss

    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 150
    @State private var newNameParent: String
    @State private var selectedIconParent: String
    
    private let icons = ["Cat", "Dog", "Tiger", "Bird"]
    
    init() {
        // Inicializa as variáveis com valores do AppStorage
        _newNameParent = State(initialValue: UserDefaults.standard.string(forKey: "guardianName") ?? "")
        _selectedIconParent = State(initialValue: UserDefaults.standard.string(forKey: "selectedGuardianIcon") ?? "guardianIcon")
    }

    var body: some View {
        VStack(spacing: 36) {
            Text("Edit \(guardianName)'s profile")
                .font(.custom("Pally-Bold", size: 41))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Rename")
                .font(.custom("Pally-Regular", size: 34))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                TextField("Enter new name", text: $newNameParent)
                    .font(.custom("Pally-Regular", size: 34))
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.2)))
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                    .opacity(0.5)
                Image(systemName: "pencil.circle.fill")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
            }
            
            Text("Choose icon")
                .font(.custom("Pally-Regular", size: 34))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                ForEach(icons, id: \.self) { icon in
                    Button(action: {
                        selectedIconParent = icon
                    }) {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .background(
                                selectedIconParent == icon ? Color(red: 0.73, green: 0.57, blue: 0.8) : Color.clear,
                                in: Circle()
                            )
                    }
                }
            }
            
            Spacer()
            
            Button("Save") {
                selectedGuardianIcon = selectedIconParent
                guardianName = newNameParent
                dismiss() // Fecha a view ao salvar
            }
            .font(.custom("Pally-Regular", size: 34))
            .buttonStyle(.borderedProminent)
            .tint(Color(red: 0.16, green: 0, blue: 0.25))
        }
        .padding()
    }
}
