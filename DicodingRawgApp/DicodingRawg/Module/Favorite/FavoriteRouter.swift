//
//  FavoriteRouter.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 17/12/22.
//

import Foundation
import UIKit
import Core
import Games
import SwiftUI

class FavoriteRouter {
    public func makeDetailView(for detail: GameListModel) -> some View {
        let useCase: DetailInteractor<
            GameListModel,
            [GameDetailModel],
            GameRepository<
            LocalsDataSource,
            RemotesDataSource,
            Transformer>> = Injection.init().provideDetail()
        let presenter = DetailPresenter(useCase: useCase)
        return DetailView(presenter: presenter, games: detail, isFavorite: true)
    }
}
