//
//  ContentView.swift
//  self_chat
//
//  Created by Walid Ashik on 5/1/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var pressedKeys: String = ""
    
    
    var body: some View {
        HStack{
            Rectangle()
                .foregroundColor(Color.black.opacity(0.5))
                .frame(width: 140, alignment: .leadingFirstTextBaseline)
            VStack {
                Group {
                    if !pressedKeys.isEmpty {
                        Text(pressedKeys)
                            .padding(10)
                            .lineSpacing(3)
                            .foregroundColor(.black)
                            .background(RoundedCorners(color: .white, tl: 25, tr: 25, bl: 0, br: 25))
                    }
                }
            }
            Spacer()
        }
        .frame(width: 500, height: 300)
        .background(TransparentWindowBackground())
        .focusable(true)
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
            NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
                handleKeyEvent(event)
                return nil
            }
        }
        
    }
    
    private func handleKeyEvent(_ event: NSEvent) {
        if event.keyCode == 36 { // Enter key
            if event.modifierFlags.contains(.shift) {
                pressedKeys += "\n"
            } else {
                pressedKeys = ""
            }
        } else if let characters = event.characters {
            if event.keyCode == 51 { // Check if the delete key is pressed
                pressedKeys = String(pressedKeys.dropLast())
            } else {
                pressedKeys += characters
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct RoundedCorners: View {
    var color: Color = .blue
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                
                let w = geometry.size.width
                let h = geometry.size.height
                
                // Make sure we do not exceed the size of the rectangle
                let tr = min(min(self.tr, h/2), w/2)
                let tl = min(min(self.tl, h/2), w/2)
                let bl = min(min(self.bl, h/2), w/2)
                let br = min(min(self.br, h/2), w/2)
                
                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
                path.closeSubpath()
            }
            .fill(self.color)
        }
    }
}
