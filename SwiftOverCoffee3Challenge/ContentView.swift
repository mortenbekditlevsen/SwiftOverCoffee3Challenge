//
//  ContentView.swift
//  SwiftOverCoffee3Challenge
//
//  Created by Morten Bek Ditlevsen on 01/03/2020.
//  Copyright © 2020 Ka-ching. All rights reserved.
//

import SwiftUI

func rotation(count: Int, index: Int) -> Angle {
    Angle(degrees: Double(360) / Double(count) * Double(index))
}

struct ContentView: View {
    @State var minimumSize: CGFloat = 100
    @State var maximumSize: CGFloat = 200
    @State var collapsed = true
    @State var maxRotation: Double = 360
    @State var animationSpeed: Double = 0.1
    @State var repeats: Bool = false

    // TODO: Add a color picker
    let color = Color(red: 0.7, green: 0.8, blue: 1)

    // TODO: Add count slider
    var count: Int = 5

    var body: some View {
        VStack {
            ZStack {
                ForEach(0 ..< count) { index in
                    Circle()
                        .frame(width: self.collapsed ? self.minimumSize : self.maximumSize,
                               height: self.collapsed ? self.minimumSize : self.maximumSize)
                        .foregroundColor(self.color)
                        .offset(CGSize(width: 0, height: self.collapsed ? 0 : self.maximumSize / 2))
                        .rotationEffect(rotation(count: self.count, index: index))
                        .blendMode(.hardLight)
                }
                .rotationEffect(self.collapsed ? .zero : Angle(degrees: self.maxRotation))
            }
            .frame(minWidth: nil,
                   maxWidth: .infinity,
                   minHeight: nil,
                   maxHeight: .infinity,
                   alignment: .center)
                .animation(
                    repeats ?
                        Animation.default.speed(animationSpeed).repeatForever(autoreverses: true)
                    :
                    Animation.default.speed(animationSpeed)
                    )

            Form {
                Button("Toggle") {
                    self.collapsed.toggle()
                }
                Toggle(isOn: $repeats) {
                    Text("Animation repeats")
                }
                Text("Minimum size")
                Slider(value: $minimumSize, in: CGFloat(10) ... 250)
                Text("Maximum size")
                Slider(value: $maximumSize, in: CGFloat(10) ... 250)
                Text("Maximum rotation")
                Slider(value: $maxRotation, in: Double(0) ... 720)
                Text("Animation speed")
                Slider(value: $animationSpeed, in: Double(0) ... 1)
            }
        }
        .background(Color.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .dark)
    }
}
