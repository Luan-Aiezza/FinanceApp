import SwiftUI
import SwiftData

struct OnboardingPage7: View {
    
    @State private var showIconSelection = false
    @AppStorage("selectedGuardianIcon") private var selectedGuardianIcon: String = "guardianIcon"
    
    @AppStorage("guardianName") private var guardianName: String = ""
    @AppStorage("password") private var password: String = "" // Armazenando o hash
    
    var body: some View {
        VStack(spacing: 36) {
            VStack(alignment: .leading) {
                Text("Create guardian profile")
                    .font(Font.custom("Pally-Bold", size: 30).weight(.medium))
                    .foregroundColor(.white)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 64, alignment: .leading)
            .background(Color(red: 0.36, green: 0, blue: 0.55))
            .cornerRadius(24)
            
            VStack(alignment: .center) {
                Text("Fill in the fields below, if you want you can also change the profile icon.")
                    .font(Font.custom("Pally-Regular", size: 24).weight(.medium))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Text("Guardian")
                    .font(Font.custom("Pally-Bold", size: 22).weight(.bold))
                    .frame(maxWidth: .infinity, alignment: .topLeading)
                
                HStack(alignment: .center, spacing: 40) {
                    Image(selectedGuardianIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 148)
                        .background(
                            Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                .offset(x: 0, y: 6)
                        )
                        .scaledToFit()
                        .onTapGesture {
                            showIconSelection = true
                        }
                        .gesture(
                            LongPressGesture().onEnded { _ in
                                showIconSelection = true
                            }
                        ).popover(isPresented: $showIconSelection) {
                            VStack(spacing: 20) {
                                Text("Choose an Icon")
                                    .font(Font.custom("Pally-Bold", size: 24))
                                    .padding()

                                HStack(spacing: 20) {
                                    ForEach(["Cat", "Dog", "Tiger", "Bird"], id: \.self) { iconName in
                                        Button(action: {
                                            selectedGuardianIcon = iconName
                                            showIconSelection = false
                                        }) {
                                            Image(iconName)
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 80, height: 80)
                                        }
                                    }
                                }
                                .padding()
                            }
                            .cornerRadius(20)
                            .padding()
                        }
                    
                    VStack(spacing: 10) {
                        TextField(" Enter your name", text: $guardianName)
                            .frame(minHeight: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                        
                        TextField(" Create 4-digit PIN", text: $password)
                            .keyboardType(.numberPad) // Limita a entrada para números
                            .frame(minHeight: 44)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0))
                            .font(Font.custom("Pally-Regular", size: 17).weight(.medium))
                            .onChange (of: password){ // Usando o novo onChange sem parâmetro explícito
                                // Limita a senha para 4 dígitos
                                if password.count > 4 {
                                    password = String(password.prefix(4))
                                }
                            }
                    }
                }
                .padding(.horizontal, 24)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(20)
            .background(Color(red: 0.94, green: 0.9, blue: 0.95))
            .cornerRadius(24)
            
            Spacer()
        }
    }
    
}

//struct AnotherView: View {
//    @AppStorage("guardianName") private var guardianName: String = ""
//    @AppStorage("password") private var password: String = ""
//
//    var body: some View {
//        VStack {
//            Text("Guardian Name: \(guardianName)")
//            Text("Password: \(password)")
//        }
//    }
//}
