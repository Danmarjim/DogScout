import Foundation

struct Dog: Identifiable, Comparable {
  var id = UUID()
  let breed: String
  let subBreed: String?
  
  var fullBreedName: String {
    if let subBreed = subBreed {
      return "\(subBreed) \(breed)".lowercased()
    } else {
      return breed.lowercased()
    }
  }
  
  static func < (lhs: Dog, rhs: Dog) -> Bool {
    return lhs.breed.lowercased() < rhs.breed.lowercased()
  }
  
  init(breed: String) {
    self.id = UUID()
    self.breed = breed
    self.subBreed = nil
  }
  
  init(breed: String, subBreed: String) {
    self.id = UUID()
    self.breed = breed
    self.subBreed = subBreed
  }
}

// MARK: - Mockable
extension Dog {
  
  static var mock: Dog {
    return Dog(breed: "hound")
  }
  
  static var mockSubBreed: Dog {
    return Dog(breed: "Bulldog", subBreed: "French")
  }
}
