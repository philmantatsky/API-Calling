//
//  ContentView.swift
//  API Calling
//
//  Created by Phillip Mantatsky on 3/11/24.
//

import SwiftUI

struct ContentView: View {
    @State private var catBreeds = [CatBreed]()
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            Color.gray.opacity(0.7).ignoresSafeArea()
            NavigationView {
                List(catBreeds) { breed in
                    NavigationLink(destination: BreedDetailView(breed: breed)) {
                        VStack(alignment: .leading) {
                            Text(breed.name)
                                .fontWeight(.bold)
                            Text(breed.temperament)
                                .font(.subheadline)
                        }
                    }
                }
                .navigationTitle("Cat Breeds")
                .toolbar {
                    Button {
                        Task {
                            await loadData()
                        }
                    } label: {
                        Image(systemName: "arrow.clockwise")
                    }
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Loading Error"),
                  message: Text("There was a problem loading the cat breeds"),
                  dismissButton: .default(Text("OK")))
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://api.thecatapi.com/v1/breeds") else {
            showingAlert = true
            return
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode([CatBreed].self, from: data)
            catBreeds = decodedResponse
        } catch {
            showingAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CatBreed: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let temperament: String
    let wikipediaUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case temperament
        case wikipediaUrl = "wikipedia_url"
    }
}
