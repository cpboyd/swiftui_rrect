//
//  ContentView.swift
//  Shared
//
//  Created by Christopher Boyd on 10/7/21.
//

import SwiftUI

// max pixel size for views is 8192
let maxSize = 8192.0
let size = maxSize / UIScreen.main.nativeScale

let rect = 8000.0 / UIScreen.main.nativeScale
let rectPadding = size - rect
let rectSize = rect * 2.0
let radius = rectSize / 4.0
let color: Color = .black

struct ContentView: View {
    var rrect: some View {
        RoundedRectangle(cornerRadius: radius, style: .continuous)
            .size(width: rectSize, height: rectSize)
            .padding(EdgeInsets(top: rectPadding, leading: rectPadding, bottom: 0.0, trailing: 0.0))
            .foregroundColor(color)
    }
    
    var body: some View {
        Button("Save") {
            rrect.saveAsImage(width: size, height: size) { image in
                if (image == nil) {
                    return
                }
                
                UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
            }
        }
        Button("Save to image") {
            guard let image = rrect.snapshot(width: size, height: size) else {
                return
            }

            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
