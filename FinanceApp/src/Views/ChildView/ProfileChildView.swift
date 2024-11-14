import SwiftUI
import SwiftData

struct ProfileChildView: View {
    @Environment(\.modelContext) private var modelContext
    let id: UUID
    @State var child: ChildModel?
    @Query private var childs: [ChildModel]
    @ObservedObject var profileChildViewModel: ProfileChildViewModel
    @ScaledMetric(relativeTo: .largeTitle) var imageSize = 48
    //    @State var view: some View = HistoryView()
    init(id: UUID) {
        self.id = id
        profileChildViewModel = .init(id: id)
    }
    
        
    var body: some View {
        ZStack {
            Text("")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.11, green: 0, blue: 0.16))
                .ignoresSafeArea()
            VStack(spacing: 32) {
                // Toolbar com ícone da criança e caixa de moedas
                HStack(alignment: .center){
                    //Image("Property 1=b1")
                    Image(child?.profileImage ?? "Cat")
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageSize, height: imageSize)
                        .background(
                            Circle().fill(Color(red: 0.73, green: 0.57, blue: 0.8))
                                .offset(x: 0, y: 6)
                        )
                    
                    Spacer(minLength: 20)
                    
                    ProfileChildPicker(viewModel: profileChildViewModel)
                    Spacer(minLength: 20)
                    
                    HStack{
                        Image("TrueCoinIcon")
                            .resizable()
                            .scaledToFill()
                            .frame(width: imageSize-4, height: imageSize-4)
                        Text("\(String(profileChildViewModel.wallet?.coins ?? 0))")
                            .font(
                                Font.custom("Pally-Bold", size: 24)
                                    .weight(.medium)
                            )
                            .foregroundStyle(Color(red: 1, green: 0.83, blue: 0.21))
                        
                    }.frame(minWidth: 83, minHeight: 44)
                    .scaledToFit()
                    
                }
                
                profileChildViewModel.changeView(for: profileChildViewModel.actualView)
                    .id(profileChildViewModel.actualView)
                    .transition(.opacity)
                
            }
            .padding(.horizontal, 32)
            .onAppear(){
                if let child = childs.first(where: { $0.id == id }){
                    self.child = child
                }
                profileChildViewModel.setup(modelContext: modelContext)
                profileChildViewModel.fetch()
            }
            .onChange(of: profileChildViewModel.actualView){
                //                print(profileChildViewModel.actualView)
            }
            //        }
        }
    }
    
    #Preview {
        ProfileChildView(id:UUID())
            .modelContainer(for: Item.self, inMemory: true)
    }
}
