//
//  HMFavoritesView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

enum FilterTypes {
    case all
    case my
    case basic
}

struct HMFavoritesView: View {
    @ObservedObject var viewModel: FlavorViewModel

    @State private var filterType: FilterTypes = .all
    var body: some View {
        VStack {
            HStack {
                Image(.filterIconHM)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
                    .opacity(0)
                GradientStrokeText(text: "favorites", font: .system(size: 30, weight: .black))
                    .textCase(.uppercase)
                
                Image(.filterIconHM)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
            }
            
            HStack {
                Button {
                    filterType = .all
                } label: {
                    Image(filterType == .all ? .smallBtnBgHMOn : .smallBtnBgHMOff)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            GradientStrokeText(text: "all", font: .system(size: 20, weight: .black))
                                .textCase(.uppercase)
                                .opacity(filterType == .all ? 1:0.5)
                        }
                }
                
                Button {
                    filterType = .my
                } label: {
                    Image(filterType == .my ? .smallBtnBgHMOn : .smallBtnBgHMOff)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            GradientStrokeText(text: "my", font: .system(size: 20, weight: .black))
                                .textCase(.uppercase)
                                .opacity(filterType == .my ? 1:0.5)
                        }
                }
                
                Button {
                    filterType = .basic
                } label: {
                    Image(filterType == .basic ? .smallBtnBgHMOn : .smallBtnBgHMOff)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            GradientStrokeText(text: "basic", font: .system(size: 20, weight: .black))
                                .textCase(.uppercase)
                                .opacity(filterType == .basic ? 1:0.5)
                        }
                }
            }
            
            ScrollView(showsIndicators: false) {
                VStack {
                    ForEach(filteredArray(), id: \.self) { flavors in
                        HStack {
                            VStack(alignment: .leading, spacing: 4) {
                                StrokeText(text: flavors.productName, font: .system(size: 15, weight: .bold), color: .orange)
                                    .textCase(.uppercase)
                                
                                HStack {
                                    ForEach(Range(1...5)) { num in
                                        Image(flavors.myRating >= num ? .starHMOn : .starHMOff)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 28)
                                            
                                    }
                                }
                                
                            }.frame(maxWidth: .infinity, alignment: .leading)
                            
                            Button {
                                viewModel.toggleIsFavorite(flavors)
                            } label: {
                                Image(systemName: flavors.isFavorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 32)
                                    .foregroundStyle(.red)
                                    
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(
                            Image(.cellBgHM)
                                .resizable()
                                .scaledToFit()
                        )
                        
                    }
                }
            }
        }
        .padding(.bottom, 80)
        .padding()
        .background(
            ZStack {
                Image(.bgHM)
                Color.black.opacity(0.5)
            }
        )
    }
    
    private func filteredArray() -> [CreatedFlavor] {
        switch filterType {
        case .all:
            return viewModel.createdFlavors.filter({ $0.isFavorite })
        case .my:
            return viewModel.createdFlavors.filter({ $0.isFavorite && $0.createdType == .own })
        case .basic:
            return viewModel.createdFlavors.filter({ $0.isFavorite && $0.createdType == .fromList })
        }
    }
}

#Preview {
    HMFavoritesView(viewModel: FlavorViewModel())
}
