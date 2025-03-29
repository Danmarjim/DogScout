import Foundation
@testable import DogScout

class MockDogListService: DogListUseCase {
  var mockDogs: [Dog] = []
  var shouldFail = false
  
  func execute() async throws -> [Dog] {
    if shouldFail {
      throw URLError(.notConnectedToInternet)
    }
    return mockDogs
  }
}

class MockDogDetailsService: DogDetailsUseCase {
  var mockDogDetails: DogDetail?
  var shouldFail = false
  
  func execute(for dog: Dog) async throws -> DogDetail {
    if shouldFail {
      throw URLError(.notConnectedToInternet)
    }
    return mockDogDetails ?? .mockNoURL
  }
}
