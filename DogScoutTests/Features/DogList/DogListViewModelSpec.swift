import XCTest
@testable import DogScout

@MainActor
final class DogListViewModelSpec: XCTestCase {
  var viewModel: DogListViewModel!
  var mockService: MockDogListService!
  
  private var expectedDogs: [Dog] = []
  
  override func setUp() async throws {
    try await super.setUp()
    mockService = MockDogListService()
    viewModel = DogListViewModel(dogList: mockService)
  }
  
  override func tearDown() async throws {
    mockService = nil
    viewModel = nil
    try await super.tearDown()
  }
  
  func testFetchDogsSuccess() async {
    givenDog()
    await whenFetchDog()
    thenFetchDogSuccess()
  }
  
  func testFetchDogsFailure() async {
    givenDog()
    await givenFailureMockService()
    await whenFetchDog()
    thenFetchDogFailure()
  }
}

// MARK: - GIVEN
extension DogListViewModelSpec {
  
  private func givenDog() {
    expectedDogs = [.mock]
    mockService.mockDogs = expectedDogs
  }
  
  private func givenFailureMockService() async {
    mockService.shouldFail = true
  }
}

// MARK: - WHEN
extension DogListViewModelSpec {
  
  private func whenFetchDog() async {
    await viewModel.fetchDogs()
  }
}

// MARK: - THEN
extension DogListViewModelSpec {
  
  private func thenFetchDogSuccess() {
    XCTAssertEqual(viewModel.dogs, expectedDogs)
    XCTAssertFalse(viewModel.showErrorAlert)
  }
  
  private func thenFetchDogFailure() {
    XCTAssertTrue(viewModel.dogs.isEmpty)
    XCTAssertTrue(viewModel.showErrorAlert)
    XCTAssertNotNil(viewModel.lastError)
  }
}
