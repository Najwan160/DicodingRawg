//
//  HomeView.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 17/12/22.
//

import SwiftUI
import Kingfisher
import Core
import Games

struct HomeView: View {
    @ObservedObject var presenter: HomePresenter<
        GameListModel,
        HomeInteractor<
            [GameListModel],
            GameRepository<
                LocalsDataSource,
                RemotesDataSource,
                Games.Transformer>>>
    var body: some View {
        NavigationView {
            ZStack {
                if presenter.isLoading {
                    Text("Loading")
                    ActivityIndicator()
                } else {
                    List(presenter.list) { game in
                        linkBuilder(for: game) {
                            Item(games: game)
                        }
                    }
                }
            }.onAppear {
                presenter.getList()
            }
            .navigationBarTitle("Games", displayMode: .inline)
        }
    }
}
struct Item: View {
    var games: GameListModel
    var body: some View {
        HStack {
            KFImage(URL(string: games.backgroundImage ?? "") ??
                    URL(string:
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/640px-No_image_available.svg.png"))
            .resizable()
            .frame(width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
        .aspectRatio(contentMode: .fit)
        .cornerRadius(15)
        VStack(alignment: .leading) {
            Text(games.name ?? "Unknown")
                .padding(7)
            HStack {
                Image(systemName: "star.fill")
                    .imageScale(.small)
                    .foregroundColor(.yellow)
                Text(String(games.rating ?? 0))
            }
        }
    }
}

extension HomeView {
    func linkBuilder<Content: View>(
        for gameListModel: GameListModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: HomeRouter().makeDetailView(for: gameListModel)
        ) { content() }
    }
}
