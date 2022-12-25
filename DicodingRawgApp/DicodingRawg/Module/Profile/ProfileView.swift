//
//  ProfileView.swift
//  DicodingRawg
//
//  Created by Muhammad Najwan Latief on 17/12/22.
//

import SwiftUI
import Games
import Core

struct ProfileView: View {
    @ObservedObject var presenter: ProfilePresenter<
        ProfileEntity,
        ProfileInteractor<
        [ProfileEntity],
            GameRepository<
            LocalsDataSource,
            RemotesDataSource,
            Transformer>>>
    var body: some View {
        NavigationView {
            ForEach(presenter.profile, id: \.self) { profiles in
                ProfileItem(profile: profiles)
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }.onAppear {
            presenter.getProfile()
        }
    }
}

struct ProfileItem: View {
    var profile: ProfileEntity
    var body: some View {
        VStack(alignment: .center) {
            Image(profile.imagePath)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100, height: 100, alignment: .center)
                .shadow(radius: 10)
            Text(profile.email)
                .multilineTextAlignment(.leading)
                .font(.title)
            Text(profile.name)
                .font(.footnote)
        }
    }
}
