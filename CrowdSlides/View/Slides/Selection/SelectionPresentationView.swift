//
//  SelectionPresentationView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 08/12/2024.
//

import SwiftUI

struct SelectionPresentationView: View {
    
    @EnvironmentObject var selectionVM: SelectionSlideViewModel
    
    let slide: SelectionSlide
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: geometry.size.height * 0.1) { 
                Text(slide.text)
                    .selectionTextStyle()
                
                Text(selectionVM.settings.preparePromptText)
                    .selectionPromptTextStyle()
                
                VStack {
                    ForEach(slide.options.indices, id: \.self) { index in
                        VStack(spacing: geometry.size.height * 0.01) {
                            Text(slide.options[index].text)
                                .optionTextStyle()
                            
                            if index < slide.options.indices.count - 1 {
                                Text(selectionVM.settings.orText)
                                    .bodyTextStyle()
                                    .padding(geometry.size.height * 0.01 )
                            }
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            .onAppear() {
                selectionVM.handleSound()
            }
        }
    }
}

#Preview {
    SelectionPresentationView(slide: SelectionSlide(id: "1",
                                                    nextSlideId: nil,
                                                    backgroundImage: nil,
                                                    sound: nil,
                                                    stopAllSounds: nil,
                                                    text: "What should the cat do?",
                                                    backgroundUnderText: nil,
                                                    clientText: "choose cat behavior",
                                                    selectionDuration: 20,
                                                    options: [SelectionSlideOption(text: "jump on human", clientText: "jump on human", nextSlideId: "slide3")
                                                              ]))
        .environmentObject(SelectionSlideViewModel())
}
