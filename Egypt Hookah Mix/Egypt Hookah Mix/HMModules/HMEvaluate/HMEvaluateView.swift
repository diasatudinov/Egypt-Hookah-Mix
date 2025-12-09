//
//  HMEvaluateView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct HMEvaluateView: View {
    
    @ObservedObject var viewModel: FlavorViewModel
    
    private var flavor: CreatedFlavor {
        viewModel.createdFlavors.filter({ !$0.isEvaluated }).first ?? CreatedFlavor(
            selectedFlavors: [],
            title: "",
            productName: "",
            createdType: .fromList,
            isFavorite: false,
            isEvaluated: false,
            proportion: 0,
            fortress: 0,
            time: "",
            myRating: 0,
            notes: ""
        )
    }
    
    @State private var isEvaluating = false
    @State var proportion: Int = 0
    @State var fortress: Int = 0
    @State var time: String = ""
    @State var myRating: Int = 0
    @State var notes: String = ""
    
    var body: some View {
        VStack {
            
            if viewModel.createdFlavors.filter({ !$0.isEvaluated }).isEmpty {
                
                GradientStrokeText(text: "No products to\nevaluate", font: .system(size: 30, weight: .black))
                    .multilineTextAlignment(.center)
            } else {
               
                Spacer()
                GradientStrokeText(text: flavor.productName, font: .system(size: 30, weight: .black))
                    .textCase(.uppercase)
                GradientStrokeText(text: flavor.title, font: .system(size: 25, weight: .black))
                    .textCase(.uppercase)
                Spacer()
                if isEvaluating {
                    ScrollView(showsIndicators: false) {
                        HMEvaluateGroupView(
                            proportion: $proportion,
                            fortress: $fortress,
                            time: $time,
                            myRating: $myRating,
                            notes: $notes)
                        .overlay(alignment: .bottom) {
                            Button {
                                if checkData() {
                                    viewModel.evaluateFlavor(flavor, proportion: proportion, fortress: fortress, time: time, myRating: myRating, notes: notes)
                                    isEvaluating = false
                                    
                                    proportion = 0
                                    fortress = 0
                                    time = ""
                                    myRating = 0
                                    notes = ""
                                }
                            } label: {
                                ZStack {
                                    Image(checkData() ? .createBtnBgHM : .btnOffBgHM)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 75)
                                    
                                    StrokeText(text: "Save", font: .system(size: 25, weight: .black), color: checkData() ? .yellow : .white)
                                        .textCase(.uppercase)
                                }
                            }
                            .offset(y: 40)
                            
                            
                        }.padding(.bottom, 40)
                    }
                    Spacer()
                } else {
                    HStack {
                        let flavors = viewModel.getFlavors(for: flavor.productName)
                        
                        ForEach(flavor.selectedFlavors, id: \.self) { flavor in
                            if self.flavor.selectedFlavors.first != flavor {
                                StrokeText(text: "+", font: .largeTitle.bold(), color: .yellow)
                                    .padding(.bottom, 8)
                            }
                            
                            Image("\(flavor.rawValue)IconHM")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 170)
                        }
                    }
                    Spacer()
                    Button {
                        isEvaluating = true
                    } label: {
                        GradientStrokeText(text: "Evaluate and save", font: .system(size: 25, weight: .bold))
                            .textCase(.uppercase)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                Image(.darkBgHM)
                                    .resizable()
                                    .scaledToFit()
                            )
                    }
                    Spacer()
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
        
    }
    
    func checkData() -> Bool {
        proportion != 0 && fortress != 0 && !time.isEmpty && myRating != 0
    }
}

#Preview {
    HMEvaluateView(viewModel: FlavorViewModel())
}
