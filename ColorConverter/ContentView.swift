//
//  ContentView.swift
//  YouTab
//
//  Created by Aleksey on 18.03.2022.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    // MARK: - Proporties
    @StateObject
    private var model = ContentViewModel()
    
    @FocusState
    private var focusField: FieldType?
    
    // MARK: - UI
    var body: some View {
        GeometryReader { proxy in
            ScrollView(.vertical, showsIndicators: false) {
                Spacer(minLength: proxy.size.height/5)
                // Root VStack
                VStack(alignment: .leading) {
                    Text("RGB to Hex")
                        .foregroundColor(.white)
                        .font(Font.system(.largeTitle))
                    
                    Spacer(minLength: 50)
                    
                    TextField(model.rgbTextValue, text: model.rgbText, prompt: Text("rgb (0,0,0)"))
                        .padding([.top, .bottom, .trailing], 4)
                        .padding([.leading], 25)
                        .background(.white)
                        .cornerRadius(proxy.size.width/2)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .focused($focusField, equals: FieldType.rgb)
                    
                    Spacer(minLength: 20)
                    
                    TextField(model.hexTextValue,text: model.hexText, prompt: Text("hex (FFFFFF)"))
                        .padding([.top, .bottom, .trailing], 4)
                        .padding([.leading], 25)
                        .background(.white)
                        .cornerRadius(proxy.size.width/2)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                        .submitLabel(.done)
                        .focused($focusField, equals: FieldType.hex)
                }
                .padding(16)
                .background(.black.opacity(0.2))
                .background(.white.opacity(0.2))
                .cornerRadius(6)
            }
            .padding([.leading, .trailing], 16)
            .background(model.backgroundColor)
        }
        .onAppear {
            self.setup()
        }
    }
    
    // MARK: - Methods
    private func setup() {
        model.delegate = self
    }
}

extension ContentView: ContentViewModelDelegate {
    func focusState() -> FieldType? {
        return focusField
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
