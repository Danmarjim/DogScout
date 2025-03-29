protocol DogListUseCase {
  func execute() async throws -> [Dog]
}
