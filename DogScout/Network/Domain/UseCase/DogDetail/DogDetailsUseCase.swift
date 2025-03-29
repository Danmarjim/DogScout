protocol DogDetailsUseCase {
  func execute(for dog: Dog) async throws -> DogDetail
}
