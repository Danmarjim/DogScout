struct DogDetails: DogDetailsUseCase {
  private let dogRepository: DogRepository

  init(dogRepository: DogRepository) {
    self.dogRepository = dogRepository
  }
  
  func execute(for dog: Dog) async throws -> DogDetail {
    try await dogRepository.fetchBreedDetails(for: dog)
  }
}
