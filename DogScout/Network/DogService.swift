class DogService {
  static let shared = DogService()
}

extension DogService {
  var dogList: DogListUseCase {
    return DogList(dogRepository: dogRepository)
  }
  
  var dogDetails: DogDetailsUseCase {
    return DogDetails(dogRepository: dogRepository)
  }
  
  var dogRepository: DogRepository {
    return DogRepository(apiDataSource: DogApiDataSource())
  }
}
