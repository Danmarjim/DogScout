struct DogList: DogListUseCase {
  private let dogRepository: DogRepository
  
  init(dogRepository: DogRepository) {
    self.dogRepository = dogRepository
  }
  
  func execute() async throws -> [Dog] {
    try await dogRepository.fetchBreeds()
  }
}
