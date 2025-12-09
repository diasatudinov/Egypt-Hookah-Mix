//
//  HMEvaluateGroupView.swift
//  Egypt Hookah Mix
//
//

import SwiftUI

struct HMEvaluateGroupView: View {
    @Binding var proportion: Int
    @Binding var fortress: Int
    @Binding var time: String
    @Binding var myRating: Int
    @Binding var notes: String
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 35) {
                HStack {
                    StrokeText(text: "Proportions", font: .system(size: 25, weight: .black), color: .red)
                        .textCase(.uppercase)
                    Spacer()
                    HStack {
                        Button {
                            if proportion > 0 {
                                proportion -= 1
                            }
                        } label: {
                            Image(.minusHM)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                        }.buttonStyle(.plain)
                        
                        StrokeText(text: "\(proportion)", font: .system(size: 25, weight: .black), color: .yellow)
                        
                        Button {
                            if proportion < 10 {
                                proportion += 1
                            }
                        } label: {
                            Image(.plusHM)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 32)
                        }.buttonStyle(.plain)
                    }
                }
                
                HStack {
                    StrokeText(text: "Fortress", font: .system(size: 25, weight: .black), color: .red)
                        .textCase(.uppercase)
                    Spacer()
                    HStack {
                        ForEach(Range(1...5)) { num in
                            Image(fortress >= num ? .starHMOn : .starHMOff)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                                .onTapGesture {
                                    fortress = num
                                }
                        }
                    }
                }
                
                HStack {
                    StrokeText(text: "Time of smoke", font: .system(size: 20, weight: .black), color: .red)
                        .textCase(.uppercase)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    ZStack {
                        Image(.darkBgHM)
                            .resizable()
                            
                        TextField("", text: $time)
                            .keyboardType(.numberPad)
                            .foregroundStyle(.yellow)
                            .font(.system(size: 25, weight: .bold))
                            .padding(5)
                        
                    }.frame(width: 112, height: 48)
                        
                }
                
                HStack {
                    StrokeText(text: "My rating", font: .system(size: 25, weight: .black), color: .red)
                        .textCase(.uppercase)
                    
                    Spacer()
                    HStack {
                        ForEach(Range(1...5)) { num in
                            Image(myRating >= num ? .starHMOn : .starHMOff)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 28)
                                .onTapGesture {
                                    myRating = num
                                }
                        }
                    }
                }
                
                ZStack {
                    Image(.darkBgHM)
                        .resizable()
                        
                    TextField("Notes", text: $notes)
                        .foregroundStyle(.yellow)
                        .font(.system(size: 25, weight: .bold))
                        .padding()
                    
                }.frame(height: 70)
            }
            .frame(maxWidth: .infinity)
            .padding()
            
        }
        .padding(.vertical, 30)
        .background(
            Image(.evaluateBgHM)
                .resizable()
        )
        .hideKeyboardOnTap()
    }
}

