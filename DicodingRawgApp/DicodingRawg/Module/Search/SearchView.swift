//
//  SearchView.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 17/12/22.
//

import SwiftUI
import Kingfisher
import Core
import Games

struct SearchView: View {
    @ObservedObject var presenter: SearchPresenter<
        GameListModel,
        SearchInteractor<
            [GameListModel],
            GameRepository<
                LocalsDataSource,
                RemotesDataSource,
                Games.Transformer>>>
    @State var text = ""
    var body: some View {
        NavigationView {
            ZStack {
                if presenter.isLoading {
                    ActivityIndicator()
                }
                VStack {
                    TextField("search", text: $text, onCommit: {
                        presenter.getSearch(query: text)
                    })
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .padding()
                    List(presenter.lists) { game in
                        linkBuilder(for: game) {
                            Item(games: game)
                        }
                    }
                }
            }.navigationBarTitle("Search", displayMode: .inline)
        }
    }
}

extension SearchView {
    func linkBuilder<Content: View>(
        for gameListModel: GameListModel,
        @ViewBuilder content: () -> Content
    ) -> some View {
        NavigationLink(
            destination: SearchRouter().makeDetailView(for: gameListModel)
        ) { content() }
    }
}
