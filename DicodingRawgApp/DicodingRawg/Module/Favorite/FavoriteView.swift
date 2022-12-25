//
//  FavoriteView.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 17/12/22.
//

import SwiftUI
import Kingfisher
import Games
import Core

struct FavoriteView: View {
    @ObservedObject var presenter: FavoritePresenter<
        FavoritesEntity,
        FavoriteInteractor<
            [FavoritesEntity],
            GameRepository<
                LocalsDataSource,
                RemotesDataSource,
                Games.Transformer>>>
    var body: some View {
        NavigationView {
            ZStack {
                if presenter.isLoading {
                    ActivityIndicator()
                }
                if presenter.isLoading == false {
                    if presenter.favorite.isEmpty {
                        Text("You dont Have Any Favorite")
                    } else {
                        List {
                            ForEach(presenter.favorite) { favorites in
                                linkBuilder(gameId: favorites.gameId, name: favorites.title, image: favorites.image, rating: favorites.rating, released: favorites.released) {
                                    FavoriteItem(backroundImage: favorites.image, released: favorites.released, rating: favorites.rating, name: favorites.title)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                presenter.getFavorite()
            }
            .navigationBarTitle("Favorite", displayMode: .inline)
        }
    }
}

struct FavoriteItem: View {
    var backroundImage: String
    var released: String
    var rating: Double
    var name: String
    var body: some View {
        HStack {
            KFImage(URL(string: backroundImage) ?? URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"))
                .resizable()
                .frame(width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        VStack(alignment: .leading) {
            Text(name)
                .padding(7)
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundColor(.yellow)
                Text(String(rating))
            }
        }
    }
}

extension FavoriteView {
    func linkBuilder<Content: View>(
        gameId: Int, name: String, image: String, rating: Double, released: String,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: FavoriteRouter().makeDetailView(for: GameListModel(gameId: gameId, name: name,
                                                                            released: released, backgroundImage: image, rating: rating))
        ) { content() }
    }
}
