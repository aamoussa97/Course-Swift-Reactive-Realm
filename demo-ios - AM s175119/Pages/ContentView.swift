import SwiftUI
import RxSwift

struct ContentView: View {
    
    @State private var isAlert = false
    @State private var errorAlertMessage: String?
    
    var body: some View {
        VStack(spacing: 30) {
            Text(ShowCaseController.fetchAuthorName())
                .onAppear() {
                    ShowCaseController.run()
            }
    
            Button(action: {
                _ = ShowCaseController.Exercise2aAddPerson()
                _ = ShowCaseController.Exercise2bAddOptionalProperty()
            }) {
                Text("Exercise 2a + 2b")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise2cAddCarsToPerson()
            }) {
                Text("Exercise 2c")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3aPutPersonsToAPI()
            }) {
                Text("Exercise 3a")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3bPostPersonsToAPI()
            }) {
                Text("Exercise 3b")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3cAddAnimalToAnimalsAPI()
            }) {
                Text("Exercise 3c")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3dAddRelationshipBetweenPersonAndAnimal()
            }) {
                Text("Exercise 3d")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3eFetchPersonsFromAPIWithErrorMessage401().subscribe(
                    onError: {
                        self.errorAlertMessage = $0.localizedDescription
                        debugPrint("Error: \($0)")
                })
                self.isAlert = true
            }) {
                Text("Exercise 3e - 401")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise3eFetchPersonsFromAPIWithErrorMessage404().subscribe(
                    onError: {
                        self.errorAlertMessage = $0.localizedDescription
                        debugPrint("Error: \($0)")
                })
                self.isAlert = true
            }) {
                Text("Exercise 3e - 404")
                    .foregroundColor(Color.blue)
            }
            
            Button(action: {
                _ = ShowCaseController.Exercise4aFetchAnimalsFromAPIToLocalRealmDB()
            }) {
                Text("Exercise 4a")
                    .foregroundColor(Color.blue)
            }
            
            .alert(isPresented: $isAlert) { () -> Alert in
                Alert(title: Text("HTTP Error"), message: Text("\(errorAlertMessage ?? "Error")"), dismissButton: .default(Text("OK")))
            }
        
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
