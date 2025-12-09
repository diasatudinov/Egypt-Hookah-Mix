//
//  HMMenuContainerView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct HMMenuContainerView: View {
        var body: some View {
            NavigationStack {
                ZStack {
                    BBMenuView()
                }
            }
        }
    }

    struct BBMenuView: View {
        @State var selectedTab = 1
        @StateObject private var viewModel = FlavorViewModel()
        private let tabs = ["My dives", "Calendar", "Stats", "Stats"]
        
        var body: some View {
            ZStack {
                
                switch selectedTab {
                case 0:
                    HMFavoritesView(viewModel: viewModel)
                case 1:
                    HMHomeView(viewModel: viewModel)
                case 2:
                    HMCreateView(viewModel: viewModel)
                case 3:
                    HMEvaluateView(viewModel: viewModel)
                default:
                    Text("default")
                }
                VStack(spacing: 0) {
                    Spacer()
                    
                    HStack(spacing: 35) {
                        ForEach(0..<tabs.count) { index in
                            Button(action: {
                                selectedTab = index
                            }) {
                                VStack {
                                    Image(selectedTab == index ? selectedIcon(for: index) : icon(for: index))
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 60)
                                }
                                
                            }
                            
                        }
                    }
                    .padding(.vertical, 13)
                    .padding(.horizontal, 22)
                    .frame(maxWidth: .infinity)
                    .background(.clear)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 10, bottomLeadingRadius: 25, bottomTrailingRadius: 25, topTrailingRadius: 10))
                    .padding(.bottom, 35)
                    
                    
                    
                    
                }
                .ignoresSafeArea()
                
                
            }
        }
        
        private func icon(for index: Int) -> String {
            switch index {
            case 0: return "tab1IconHM"
            case 1: return "tab2IconHM"
            case 2: return "tab3IconHM"
            case 3: return "tab4IconHM"
            default: return ""
            }
        }
        
        private func selectedIcon(for index: Int) -> String {
            switch index {
            case 0: return "tab1IconSelectedHM"
            case 1: return "tab2IconSelectedHM"
            case 2: return "tab3IconSelectedHM"
            case 3: return "tab4IconSelectedHM"
            default: return ""
            }
        }
        
        private func text(for index: Int) -> String {
            switch index {
            case 0: return "Home"
            case 1: return "Expenses"
            case 2: return "Statistics"
            case 3: return "Statistics"
            default: return ""
            }
        }
    }

#Preview {
    HMMenuContainerView()
}
