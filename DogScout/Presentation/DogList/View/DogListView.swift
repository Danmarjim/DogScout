import SwiftUI

struct DogListView: View {
  @StateObject private var viewModel = DogListViewModel()
  @State private var searchText = ""
  
  var filteredDogs: [Dog] {
    if searchText.isEmpty {
      return viewModel.dogs
    } else {
      return viewModel.dogs.filter { $0.fullBreedName.lowercased().contains(searchText.lowercased()) }
    }
  }
  
  init() {
    _viewModel = StateObject(wrappedValue: DogListViewModel())
  }
  
  // MARK: -  Custom init for snapshot testing
  init(viewModel: DogListViewModel) {
    _viewModel = StateObject(wrappedValue: viewModel)
  }
  
  var body: some View {
    NavigationStack {
      Group {
        if viewModel.isLoading {
          loadingView
        } else if viewModel.dogs.isEmpty {
          emptyView
        } else {
          listView
        }
      }
      .navigationTitle("Dog")
      .searchable(
        text: $searchText,
        placement: .navigationBarDrawer(displayMode: .automatic),
        prompt: "Search"
      )
      .disableAutocorrection(true)
      .textInputAutocapitalization(.never)
    }
  }
  
  private var loadingView: some View {
    HStack(spacing: 10) {
      ProgressView()
      Text("Loading firulais...")
        .font(.callout)
    }
  }

  private var emptyView: some View {
    ContentUnavailableView(
      "No firulais found",
      systemImage: "pawprint.fill"
    )
  }
  
  private var listView: some View {
    VStack {
      List(viewModel.dogs.sorted().filter { dog in
        searchText.isEmpty || dog.fullBreedName.localizedCaseInsensitiveContains(searchText)
      }) { dog in
        NavigationLink(destination: DogDetailsView(dog: dog)) {
          Text(dog.fullBreedName.capitalized)
            .padding(.vertical, 10)
        }
      }
    }
    .alert("Error", isPresented: $viewModel.showErrorAlert) {
      Button("Retry", action: viewModel.retry)
      Button("Cancel", role: .cancel) {}
    } message: {
      Text(viewModel.lastError?.localizedDescription ?? "Unknown error")
    }
  }
}

#Preview {
  DogListView()
}
