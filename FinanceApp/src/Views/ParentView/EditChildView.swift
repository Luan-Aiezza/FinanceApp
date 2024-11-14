import SwiftUI

struct EditChildView: View {
    @Environment(\.dismiss) private var dismiss
//    @ObservedObject var parentViewModel: ParentViewModel
    @State var child: ChildModel // Variável para acessar o modelo da criança
    
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 150
    @State private var newName: String
    @State private var selectedIcon: String
    var upDateChildProfile: (_ name: String, _ image: String) -> Void
    
    // Ícones disponíveis
    private let icons = ["Cat", "Dog", "Tiger", "Bird"]
    
    init(child: ChildModel, upDateChildProfile: @escaping (_ name: String, _ image: String) -> Void) {
        self.child = child
//        self.parentViewModel = parentViewModel
        _newName = State(initialValue: child.name)
        _selectedIcon = State(initialValue: child.profileImage ?? "Cat")
        self.upDateChildProfile = upDateChildProfile
    }
    
    var body: some View {
        VStack(spacing: 36) {
            Text("Edit \(child.name)'s profile")
                .font(Font.custom("Pally-Bold", size: 41).weight(.bold))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
            
            Text("Rename")
                .font(Font.custom("Pally-Regular", size: 34).weight(.medium))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
            
            HStack{
                TextField("Enter new name", text: $newName)
                    .font(Font.custom("Pally-Regular", size: 34).weight(.medium))
                    .opacity(0.5)
                Image(systemName: "Pencil.circle.fill")
                    .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
            }.background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.9, green: 0.9, blue: 0.9))
            )
            
            Text("Choose icon")
                .font(Font.custom("Pally-Regular", size: 34).weight(.medium))
                .foregroundColor(Color(red: 0.16, green: 0, blue: 0.25))
                .frame(minWidth: 198, maxWidth: .infinity, alignment: .leading)
            HStack {
                ForEach(icons, id: \.self) { icon in
                    Button(action: {
                        selectedIcon = icon
                    }) {
                        Image(icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: imageSize, height: imageSize)
                            .foregroundColor(.cyan)
                            .background(
                                selectedIcon == icon ? (Color(red: 0.73, green: 0.57, blue: 0.8)) : Color.clear,
                                in: Circle()
                            )
                            
                    }
                }
            }
            
            Spacer()
            
            Button("Save") {
                //TODO: Não esquecer de implementar
                upDateChildProfile(newName, selectedIcon)
                dismiss()
            }.font(Font.custom("Pally-Regular", size: 34).weight(.medium))
                .buttonStyle(.borderedProminent).tint(Color(red: 0.16, green: 0, blue: 0.25))
        }
        .padding()
    }
}
