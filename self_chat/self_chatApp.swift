//
//  self_chatApp.swift
//  self_chat
//
//  Created by Walid Ashik on 5/1/24.
//

import SwiftUI
import SwiftUI

@main
struct SelfChatApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .windowStyle(.hiddenTitleBar)
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .frame(width: 500, height: 500, alignment: .center)
        .background(TransparentWindowBackground())
    }
}

struct TransparentWindowBackground: NSViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject {
        
    }
    
    func makeNSView(context: Context) -> NSView {
        let view = NSView()
        DispatchQueue.main.async {
            let window = view.window
            window?.backgroundColor = NSColor.clear
            window?.level = .floating
            //            window?.styleMask.remove([.closable, .resizable])
        }
        return view
    }
    
    func updateNSView(_ nsView: NSView, context: Context) {
        
    }
    
    static func dismantleNSView(_ nsView: NSView, coordinator: Coordinator) {
        
    }
}
