import SnapshotTesting
import XCTest
import SwiftUI
@testable import DogScout

@MainActor
final class DogScoutSnapshotTests: XCTestCase {
  
  func test_dog_list_view() {
    let mockViewModel = DogListViewModel()
    mockViewModel.dogs = [
      .mockSubBreed,
      .mock
    ]
    
    let view = DogListView(viewModel: mockViewModel)
    let viewController = UIHostingController(rootView: view)
    
    assertSnapshot(
      of: viewController,
      as: .image(on: .iPhone13),
      record: false,
      testName: "DogListView"
    )
  }
  
  func test_dog_details_view() {
    let mockViewModel = DogDetailsViewModel(dog: Dog(breed: "hound"))
    mockViewModel.details = .mock
    
    let view = DogDetailsView(viewModel: mockViewModel)
    let viewController = UIHostingController(rootView: view)
    
    assertSnapshot(
      of: viewController,
      as: .image(on: .iPhone13),
      record: false,
      testName: "DogDetailsView"
    )
  }
}
