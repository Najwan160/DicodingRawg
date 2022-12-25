//
//  Injection.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 18/12/22.
//

import Foundation
import Games
import Core
import RealmSwift
import UIKit

final class Injection: NSObject {
    func provideRealm() -> Realm? {
        let realm = try? Realm()
        return realm
    }
    func provideHome<U: HomeUseCase>() -> U where U.Lists == [GameListModel] {
        let locale = LocalsDataSource(realm: provideRealm())
        let remote = RemotesDataSource()
        let mapper = Transformer()
        let repository = GameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return HomeInteractor(repository: repository) as! U
    }
    func provideSearch<U: SearchUseCase>() -> U where U.Lists == [GameListModel] {
        let locale = LocalsDataSource(realm: provideRealm())
        let remote = RemotesDataSource()
        let mapper = Transformer()
        let repository = GameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return SearchInteractor(repository: repository) as! U
    }
    func provideDetail<U: DetailUseCase>() -> U where U.Detail == [GameDetailModel], U.ListInput == GameListModel {
        let locale = LocalsDataSource(realm: provideRealm())
        let remote = RemotesDataSource()
        let mapper = Transformer()
        let repository = GameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return DetailInteractor(repository: repository) as! U
    }
    func provideProfile<U: ProfileUseCase>() -> U where U.Profile == [ProfileEntity] {
        let locale = LocalsDataSource(realm: provideRealm())
        let remote = RemotesDataSource()
        let mapper = Transformer()
        let repository = GameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return ProfileInteractor(repository: repository) as! U
    }
    func provideFavorite<U: FavoriteUseCase>() -> U where U.Favorite == [FavoritesEntity] {
        let locale = LocalsDataSource(realm: provideRealm())
        let remote = RemotesDataSource()
        let mapper = Transformer()
        let repository = GameRepository(localeDataSource: locale, remoteDataSource: remote, mapper: mapper)
        return FavoriteInteractor(repository: repository) as! U
    }
}
