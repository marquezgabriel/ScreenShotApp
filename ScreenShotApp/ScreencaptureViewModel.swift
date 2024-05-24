//
//  ScreencaptureViewModel.swift
//  ScreenShotApp
//
//  Created by Gabriel Marquez on 2024-05-19.
//

import SwiftUI

class ScreencaptureViewModel: ObservableObject {
    
    enum ScreenshotTypes {
        case full
        case windows
        case area
        
        var processArgument: [String] {
            switch self {
            case .full:
                ["-c"]
            case .windows:
                ["-cw"]
            case .area:
                ["-ic"]
            }
        }
    }
    
    @Published var images = [NSImage]()
    
    func takeScreenshot(for type: ScreenshotTypes) {
        let task = Process()
        task.executableURL = URL(fileURLWithPath: "/usr/sbin/screencapture")
        task.arguments = type.processArgument
        
        
        do {
            try task.run()
            task.waitUntilExit()
            getImageFromPasteboard()
        } catch {
            print("I could not take screenshot: \(error)")
        }
    }
    
    private func getImageFromPasteboard() {
        guard NSPasteboard.general.canReadItem(withDataConformingToTypes: NSImage.imageTypes) else { return }
        guard let image = NSImage(pasteboard: NSPasteboard.general) else { return }
        self.images.append(image)
    }
}
