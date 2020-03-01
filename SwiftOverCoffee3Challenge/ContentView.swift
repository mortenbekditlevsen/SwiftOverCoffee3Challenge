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

enum MyBlendMode: String, CaseIterable {
    case color
    case colorBurn
    case colorDodge
    case darken
    case destinationOut
    case destinationOver
    case difference
    case exclusion
    case hardLight
    case hue
    case lighten
    case luminosity
    case multiply
    case normal
    case overlay
    case plusDarker
    case plusLighter
    case saturation
    case screen
    case softLight
    case sourceAtop

    var blendMode: BlendMode {
        switch self {
        case .color: return .color
        case .colorBurn: return .colorBurn
        case .colorDodge: return .colorDodge
        case .darken: return .darken
        case .destinationOut: return .destinationOut
        case .destinationOver: return .destinationOver
        case .difference: return .difference
        case .exclusion: return .exclusion
        case .hardLight: return .hardLight
        case .hue: return .hue
        case .lighten: return .lighten
        case .luminosity: return .luminosity
        case .multiply: return .multiply
        case .normal: return .normal
        case .overlay: return .overlay
        case .plusDarker: return .plusDarker
        case .plusLighter: return .plusLighter
        case .saturation: return .saturation
        case .screen: return .screen
        case .softLight: return .softLight
        case .sourceAtop: return .sourceAtop
        }
    }
}

extension Slider where ValueLabel == EmptyView {
    init<T: BinaryInteger>(value: Binding<T>, in range: ClosedRange<T>, @ViewBuilder label: () -> Label) {
        self = Slider(value: .init(get: {
            Double(value.wrappedValue)
        }, set: { (newValue: Double) in
            value.wrappedValue = T(newValue)
        }),
                      in: .init(uncheckedBounds: (lower: Double(range.lowerBound), upper: Double(range.upperBound))),
                      label: label)
    }
}


struct ContentView: View {
    @State var minimumSize: CGFloat = 100
    @State var maximumSize: CGFloat = 200
    @State var collapsed = true
    @State var maxRotation: Double = 360
    @State var animationSpeed: Double = 0.1
    @State var repeats: Bool = false
    @State var blendMode: Int = MyBlendMode.allCases.firstIndex(of: .hardLight)!
    @State var hue: Double = 0.55
    @State var saturation: Double = 0.33
    @State var brightness: Double = 1
    @State var opacity: Double = 0.8
    @State var count: Int = 5
    @State var offsetRatio: CGFloat = 0.5

    var body: some View {
        NavigationView {

        VStack {
            ZStack {
                ForEach(0 ..< count, id: \.self) { index in
                    Circle()
                        .frame(width: self.collapsed ? self.minimumSize : self.maximumSize,
                               height: self.collapsed ? self.minimumSize : self.maximumSize)
                        .foregroundColor(Color(hue: self.hue,
                                               saturation: self.saturation,
                                               brightness: self.brightness,
                                               opacity: self.opacity)
                    )
                        .offset(CGSize(width: 0, height: self.collapsed ? 0 : self.maximumSize * self.offsetRatio))
                        .rotationEffect(rotation(count: self.count, index: index))
                        .blendMode(MyBlendMode.allCases[self.blendMode].blendMode)
                }
                .rotationEffect(self.collapsed ? .zero : Angle(degrees: self.maxRotation))
            }
            .frame(minWidth: nil,
                   maxWidth: .infinity,
                   minHeight: nil,
                   maxHeight: .infinity,
                   alignment: .center)

            Form {
                Group {
                    HStack {
                        Button("Toggle") {
                            withAnimation(
                                self.repeats ?
                                    Animation.default.speed(self.animationSpeed).repeatForever(autoreverses: true)
                                    :

                            Animation.default.speed(self.animationSpeed)

                            ) {
                                self.collapsed.toggle()
                            }
                        }
                        Spacer(minLength: 100)
                        Toggle(isOn: $repeats) {
                            Text("Repeats")
                        }
                    }
                    Text("Petal count: \(count)")
                    Slider(value: $count.animation(Animation.default.speed(0.5)), in: 1...24) {
                        Text("")
                    }

                    Text("Minimum size")
                    Slider(value: $minimumSize, in: 10...250)
                    Text("Maximum size")
                    Slider(value: $maximumSize, in: 10...250)

                    Text("Maximum rotation")
                    Slider(value: $maxRotation, in: 0...720)
                }
                Group {
                    Text("Offset ratio")
                    Slider(value: $offsetRatio, in: 0...10)

                    Text("Animation speed")
                    Slider(value: $animationSpeed, in: Double(0) ... 1)

                }
                Group {
                    Text("Hue: \(hue)")
                    Slider(value: $hue, in: 0...1)
                    Text("Saturation: \(saturation)")
                    Slider(value: $saturation, in: 0...1)
                    Text("Brightness: \(brightness)")
                    Slider(value: $brightness, in: 0...1)
                    Text("Opacity: \(opacity)")
                    Slider(value: $opacity, in: 0...1)
                }
                Group {
                    Picker("Blend mode", selection: $blendMode) {
                        ForEach(0 ..< MyBlendMode.allCases.count) {
                            Text(MyBlendMode.allCases[$0].rawValue)
                        }
                    }.pickerStyle(DefaultPickerStyle())
                }
            }
        }
        .background(Color.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.colorScheme, .dark)
    }
}
