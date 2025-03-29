protocol DogDataSource {
  func fetchBreeds() async throws -> [Dog]
  func fetchBreedDetails(for dog: Dog) async throws -> DogDetail
}
