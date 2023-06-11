//
//  TextInputAutocomplete.swift
//  Tender
//
//  Created by Agfid Prasetyo on 11/06/23.
//

import SwiftUI

struct TextInputAutocomplete: View {
    @Binding var data: [String]
    @Binding var text: String
    @State var predictData: [String] = []
    @State private var isBeingEdited: Bool = false
    @State var predictionInterval: Double?
    var placeholder: String = ""
    
    private func realTimePrediction(status: Bool) {
        isBeingEdited = status
        if status == true {
            Timer.scheduledTimer(withTimeInterval: predictionInterval ?? 1, repeats: true) { timer in
                makePrediction()
                
                if isBeingEdited == false {
                    timer.invalidate()
                }
            }
        }
    }
    
    private func capitalizeFirstLetter(smallString: String) -> String {
        return smallString.prefix(1).capitalized + smallString.dropFirst()
    }
    
    private func makePrediction() {
        self.predictData = []
        if !text.isEmpty{
            for value in data {
                if text.split(separator: " ").count > 1 {
                    makeMultiPrediction(value: value)
                }else {
                    if value.contains(text) || value.contains(capitalizeFirstLetter(smallString: text)){
                        if !predictData.contains(String(value)) {
                            predictData.append(String(value))
                        }
                    }
                }
            }
        }
        print(predictData)
    }
    
    private func makeMultiPrediction(value: String) {
        for subString in text.split(separator: " ") {
            if value.contains(String(subString)) || value.contains(capitalizeFirstLetter(smallString: String(subString))){
                if !predictData.contains(value) {
                    predictData.append(value)
                }
            }
        }
    }
    
    
    var body: some View {
        VStack {
            TextField(placeholder, text: $text, onEditingChanged: { editing in realTimePrediction(status: editing)}, onCommit: { makePrediction()})
            ZStack {
                if predictData.count > 0 && data.filter({$0 == text}).isEmpty {
                    ScrollView {
                        ForEach(predictData, id: \.self) { skill in
                            VStack(alignment: .leading) {
                                
                                Text(skill).padding(.init(top: 5, leading: 20, bottom: 5, trailing: 20))
                                Divider()
                            }.onTapGesture {
                                text = skill
                            }
                        }
                    }
                    .frame(maxHeight: 200)
                    .border(Color("purpleColor"))
                }
            }
        }
    }
}

struct TextInputAutocomplete_Previews: PreviewProvider {
    static var previews: some View {
        TextInputAutocomplete(data: .constant(RolesViewModel().roles.map {$0.name}), text: .constant("iOS"))
    }
}
