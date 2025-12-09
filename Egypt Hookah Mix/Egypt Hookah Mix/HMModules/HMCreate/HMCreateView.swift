//
//  HMCreateView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct HMCreateView: View {
    @ObservedObject var viewModel: FlavorViewModel
    
    private let columns: [GridItem] = Array(
        repeating: GridItem(.flexible(), spacing: 8),
        count: 4
    )
    
    @State private var ownName = ""
    @State private var isEvaluating = false
    @State var proportion: Int = 0
    @State var fortress: Int = 0
    @State var time: String = ""
    @State var myRating: Int = 0
    @State var notes: String = ""
    
    var body: some View {
        VStack {
            ScrollView(showsIndicators: false) {
                GradientStrokeText(text: "Create NEW mix", font: .system(size: 30, weight: .black))
                    .textCase(.uppercase)
                
                if isEvaluating {
                    
                    HMEvaluateGroupView(
                        proportion: $proportion,
                        fortress: $fortress,
                        time: $time,
                        myRating: $myRating,
                        notes: $notes)
                    
                    
                } else {
                    VStack(spacing: 40) {
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
                        
                        ZStack {
                            Image(.darkBgHM)
                                .resizable()
                            
                            TextField("NAME", text: $ownName)
                                .foregroundStyle(.yellow)
                                .font(.system(size: 25, weight: .bold))
                                .padding()
                            
                        }.frame(height: 70)
                            .frame(maxHeight: .infinity, alignment: .top)
                        
                        
                    }
                }
                
                Button {
                    if isEvaluating {
                        if checkData() {
                            viewModel.createFlavor(
                                createdType: .own,
                                ownProductName: ownName,
                                newProportion: proportion,
                                newFortress: fortress,
                                newTime: time,
                                newMyRating: myRating,
                                newNotes: notes
                            )
                            isEvaluating = false
                            
                            proportion = 0
                            fortress = 0
                            time = ""
                            myRating = 0
                            notes = ""
                            ownName = ""
                            
                        }
                        
                        
                    } else {
                        if checkData() {
                            isEvaluating = true
                        }
                    }
                } label: {
                    ZStack {
                        Image(checkData() ? .createBtnBgHM : .btnOffBgHM)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 100)
                        
                        StrokeText(text: isEvaluating ? "Add" : "Next", font: .system(size: 25, weight: .black), color: checkData() ? .yellow : .white)
                            .textCase(.uppercase)
                        
                    }
                }
            }
        }
        .padding(.bottom, 80)
        .padding()
        .background(
            ZStack {
                Image(.bgHM)
            }
        )
        .hideKeyboardOnTap()
    }
    
    func checkData() -> Bool {
        if isEvaluating {
            return proportion != 0 && fortress != 0 && !time.isEmpty && myRating != 0
        } else {
            return !viewModel.selectedFlavors.isEmpty && !ownName.isEmpty
        }
    }
}

#Preview {
    HMCreateView(viewModel: FlavorViewModel())
}
