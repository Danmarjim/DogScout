import SwiftUI

@MainActor
class DogListViewModel: ObservableObject {
  @Published var dogs: [Dog] = []
  @Published var isLoading = false
  @Published var showErrorAlert = false
  private(set) var lastError: Error?
  
  private let dogList: DogListUseCase
  
  init(dogList: DogListUseCase = DogService.shared.dogList) {
    self.dogList = dogList
    task()
  }
  
  func fetchDogs() async {
    isLoading = true
    defer { isLoading = false }
    
    do {
      dogs = try await dogList.execute()
    } catch {
      handleError(error: error)
    }
  }
  
  func retry() {
    task()
  }
}

// MARK: - Private methods
extension DogListViewModel {
 
  private func task() {
    Task {
      await fetchDogs()
    }
  }
  
  private func handleError(error: Error) {
    lastError = error
    showErrorAlert = true
  }
}
