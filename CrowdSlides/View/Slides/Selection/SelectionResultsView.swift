//
//  SelectionResultsView.swift
//  CrowdSlides
//
//  Created by Nimrod Yizhar on 15/12/2024.
//

import SwiftUI

struct SelectionResultsView: View {
    
    @EnvironmentObject var selectionVM: SelectionSlideViewModel
    
    let slide: SelectionSlide
    
    var body: some View {
        
        ZStack {
            
            
            RoundedRectangle(cornerRadius: 15)
                .stroke(StyleGuide.Color.primary, lineWidth: 2)
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .fill(StyleGuide.Color.panelBackground) 
                )

            
            VStack {
                if selectionVM.selectedOptionIndex == -1 {
                    Text(selectionVM.settings.tieAnnouncementText)
                        .selectionPromptTextStyle()
                        .padding(.vertical,50)
                    
                    Text(selectionVM.settings.tieOperatorChooseText)
                        .selectionPromptTextStyle()
                }
                else {
                    Text(selectionVM.settings.announcementText)
                        .selectionPromptTextStyle()
                        .padding(.vertical,50)
                    Text(slide.options[selectionVM.selectedOptionIndex].text)
                        .selectedOptionTextStyle()
                }
            }
            .padding(60)
        }
        .fixedSize(horizontal: true, vertical: true)
        .onAppear() {
            selectionVM.handleSound()
        }
    }
}

