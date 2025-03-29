struct DogDetail {
  let breed: String
  let imageURL: String
}

// MARK: - Mockable
extension DogDetail {
  static var mock: DogDetail {
    return DogDetail(
      breed: "hound",
      imageURL: "https://images.dog.ceo/breeds/hound-walker/n02089867_2295.jpg"
    )
  }
  
  static var mockNoURL: DogDetail {
    return DogDetail(
      breed: "hound",
      imageURL: ""
    )
  }
}
