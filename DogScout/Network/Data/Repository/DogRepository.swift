struct DogRepository {
  private let apiDataSource: DogDataSource

  init(apiDataSource: DogDataSource) {
    self.apiDataSource = apiDataSource
  }
  
  func fetchBreeds() async throws -> [Dog] {
    try await apiDataSource.fetchBreeds()
  }
  
  func fetchBreedDetails(for dog: Dog) async throws -> DogDetail {
    try await apiDataSource.fetchBreedDetails(for: dog)
  }
}
