import SwiftUI

@MainActor
class DogDetailsViewModel: ObservableObject {
  @Published var details: DogDetail?
  @Published var isLoading = false
  private(set) var lastError: Error?
  
  private let dogDetails: DogDetailsUseCase
  
  init(dog: Dog,
       dogDetails: DogDetailsUseCase = DogService.shared.dogDetails) {
    self.dogDetails = dogDetails
    Task {
      await fetchDetails(for: dog)
    }
  }
  
  func fetchDetails(for dog: Dog) async {
    isLoading = true
    defer { isLoading = false }
    
    do {
      details = try await dogDetails.execute(for: dog)
    } catch {
      handleError(error: error)
    }
  }
}

// MARK: - Private methods
extension DogDetailsViewModel {
  
  private func handleError(error: Error) {
    lastError = error
  }
}
