import XCTest
@testable import DogScout

final class DogDetailsViewModelSpec: XCTestCase {
  var viewModel: DogDetailsViewModel!
  var mockService: MockDogDetailsService!
  
  override func setUp() async throws {
    try await super.setUp()
    mockService = MockDogDetailsService()
    viewModel = await DogDetailsViewModel(dog: .mock, dogDetails: mockService)
  }
  
  override func tearDown() async throws {
    mockService = nil
    viewModel = nil
    try await super.tearDown()
  }
  
  func testFetchDogDetailSuccess() async {
    givenDogDetails()
    await whenFetchDogDetails()
    await thenFetchDogDetailSuccess()
  }
  
  func testFetchDogDetailsFailure() async {
    givenDogDetails()
    await givenFailureMockService()
    await whenFetchDogDetails()
    await thenFetchDogDetailFailure()
  }
}

// MARK: - GIVEN
extension DogDetailsViewModelSpec {
  
  private func givenDogDetails() {
    mockService.mockDogDetails = .mock
  }
  
  private func givenFailureMockService() async {
    mockService.shouldFail = true
    mockService.mockDogDetails = .mockNoURL
  }
}

// MARK: - WHEN
extension DogDetailsViewModelSpec {
  
  private func whenFetchDogDetails() async {
    await viewModel.fetchDetails(for: .mock)
  }
}

// MARK: - THEN
extension DogDetailsViewModelSpec {
  
  @MainActor
  private func thenFetchDogDetailSuccess() {
    XCTAssertNotNil(viewModel.details)
  }
  
  @MainActor
  private func thenFetchDogDetailFailure() {
    XCTAssertNotNil(viewModel.lastError)
  }
}
