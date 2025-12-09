//
//  HMHomeView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct HMHomeView: View {
    @ObservedObject var viewModel: FlavorViewModel
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 4
    )
    
    var body: some View {
        VStack(spacing: 16) {
            
            GradientStrokeText(text: "Create your mix", font: .system(size: 35, weight: .bold))
                .textCase(.uppercase)
            
            // ГРИД С ВКУСАМИ
            LazyVGrid(columns: columns, spacing: 8) {
                ForEach(FlavorType.allCases) { flavor in
                    let isSelected = viewModel.selectedFlavors.contains(flavor)
                    
                    Button {
                        withAnimation {
                            viewModel.toggleSelection(flavor)
                        }
                    } label: {
                        
                        Image(isSelected ? "\(flavor.rawValue)SelectedHM" : "\(flavor.rawValue)UnselectedHM")
                            .resizable()
                            .scaledToFit()
                        
                    }.buttonStyle(.plain)
                }
            }
            
            // КНОПКА CREATE
            Button {
                viewModel.createFlavor(createdType: .fromList)
            } label: {
                GradientStrokeText(text: "Create", font: .system(size: 25, weight: .bold))
                    .textCase(.uppercase)
                    .frame(maxWidth: .infinity)
                    .padding(20)
                    .background(
                        Image(.createBtnBgHM)
                            .resizable()
                            .scaledToFit()
                    )
                    .foregroundColor(.yellow)
            }
            .disabled(viewModel.selectedFlavors.isEmpty)
            
            Divider()
            
            // СПИСОК СОЗДАННЫХ ВКУСОВ
            if viewModel.createdFlavors.isEmpty {
                Spacer()
                Text("No blends yet")
                    .foregroundColor(.black)
                    .bold()
                Spacer()
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(viewModel.createdFlavors) { item in
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    StrokeText(text: item.title, font: .system(size: 20, weight: .bold), color: .red)
                                        .textCase(.uppercase)
                                    StrokeText(text: item.productName, font: .system(size: 15, weight: .bold), color: .orange)
                                        .textCase(.uppercase)
                                }.frame(maxWidth: .infinity, alignment: .leading)
                                
                                Button {
                                    viewModel.toggleIsFavorite(item)
                                } label: {
                                    Image(systemName: item.isFavorite ? "heart.fill" : "heart")
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
                    }.padding(.bottom, 80)
                }
            }
        }
        .padding()
        .background(
            ZStack {
                Image(.bgHM)
                Color.black.opacity(0.5)
            }
        )
    }
}

#Preview {
    HMHomeView(viewModel: FlavorViewModel())
}
