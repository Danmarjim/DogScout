import SwiftUI

struct DogDetailsView: View {
  @StateObject private var viewModel: DogDetailsViewModel
  private let imageLoader: ImageLoader
  
  init(dog: Dog,
       imageLoader: ImageLoader = RemoteImageLoader()) {
    _viewModel = StateObject(wrappedValue: DogDetailsViewModel(dog: dog))
    self.imageLoader = imageLoader
  }
  
  // MARK: - Custom init for snapshot testing
  init(viewModel: DogDetailsViewModel,
       imageLoader: ImageLoader = MockImageLoader()) {
    _viewModel = StateObject(wrappedValue: viewModel)
    self.imageLoader = imageLoader
  }
  
  var body: some View {
    if let details = viewModel.details {
      VStack(alignment: .leading) {
        imageLoader.loadImage(from: URL(string: details.imageURL))
          .clipped()
          .cornerRadius(10)
          .padding([.horizontal, .vertical], 20)
    
        Text(details.breed.capitalized)
          .font(.largeTitle)
          .padding([.leading, .bottom], 10)
        
        Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.")
          .padding([.horizontal], 10)
        Spacer()
      }
    }
  }
}

#Preview {
  DogDetailsView(dog: Dog(breed: "hound"))
}
