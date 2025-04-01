import Foundation


class ProfileScreenViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    @Published var isLoading: Bool = false
    let userRepository: UserRepository = UserRepositoryImpl.shared

    func onAppear() {
        Task {
            do {
                let cachedUser = await userRepository.getMeCached()
                if cachedUser != nil {
                    DispatchQueue.main.async {
                        self.user = cachedUser
                    }
                } 
                let user = try await userRepository.getMe()
                DispatchQueue.main.async {
                    self.user = user
                }
            } catch {
                print("Error fetching user: \(error)")
            }
        }
    }

    func onSave() {
        DispatchQueue.main.async {
            self.isLoading = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.isLoading = false
        }
    }
}
