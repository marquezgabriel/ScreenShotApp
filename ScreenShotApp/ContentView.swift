//
//  ContentView.swift
//  ScreenShotApp
//
//  Created by Gabriel Marquez on 2024-05-19.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm =  ScreencaptureViewModel()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 200, maximum: 300))]) {
                    ForEach(vm.images, id: \.self) { image in
                        Image(nsImage: image)
                            .resizable()
                            .scaledToFit()
                            .onDrag({ NSItemProvider(object: image) })
//                            .draggable(image)
                    }
                }
            }
            HStack {
                Button("Take a area screenshot") {
                    vm.takeScreenshot(for: .area)
                }
                Button("Take a windows screenshot") {
                    vm.takeScreenshot(for: .windows)
                }
                Button("Take a full screenshot") {
                    vm.takeScreenshot(for: .full)
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
