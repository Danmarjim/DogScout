import Foundation

final class DogApiDataSource: DogDataSource {
  
  func fetchBreeds() async throws -> [Dog] {
    let url = URL(string: "https://dog.ceo/api/breeds/list/all")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(DogListReponse.self, from: data)
    
    var dogs = [Dog]()
    
    for (breed, subBreeds) in decodedResponse.message {
      if subBreeds.isEmpty {
        dogs.append(Dog(breed: breed))
      } else {
        dogs.append(contentsOf: subBreeds.map { subBreed in
          Dog(breed: breed, subBreed: subBreed)
        })
      }
    }
    
    return dogs
  }
  
  func fetchBreedDetails(for dog: Dog) async throws -> DogDetail {
    var urlString: String
    if let subBreed = dog.subBreed {
      urlString = "https://dog.ceo/api/breed/\(dog.breed)/\(subBreed)/images/random"
    } else {
      urlString = "https://dog.ceo/api/breed/\(dog.breed)/images/random"
    }
    let url = URL(string: urlString)!
    
    let (data, _) = try await URLSession.shared.data(from: url)
    let decodedResponse = try JSONDecoder().decode(DogDetailsResponse.self, from: data)
    return DogDetail(breed: dog.fullBreedName, imageURL: decodedResponse.message)
  }
}
