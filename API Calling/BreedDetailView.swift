//
//  BreedDetailView.swift
//  API Calling
//
//  Created by Phillip Mantatsky on 3/13/24.
//

import SwiftUI

struct BreedDetailView: View {
    let breed: CatBreed

    var body: some View {
        ZStack {
            Color.red.opacity(0.7).ignoresSafeArea()
            VStack {
                Text(breed.name)
                    .bold()
                    .font(.largeTitle)
                Text(breed.description)
                    .padding()
                if let wikipediaUrl = breed.wikipediaUrl, let url = URL(string: wikipediaUrl) {
                    Link("Learn more on Wikipedia", destination: url)
                        .padding()
                }
            }
            .navigationTitle(breed.name)
        }
    }
}

struct BreedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetailView(breed: CatBreed(id: "1", name: "Test Breed", description: "This is a test breed description.", temperament: "Playful", wikipediaUrl: nil))
    }
}
