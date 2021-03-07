//
//  File.swift
//  
//
//  Created by Soren SAMAMA on 07/03/2021.
//

import SwiftUI

struct SwipeGestureModifier: ViewModifier {
    
    @State var leading: [Slot]
    @State var trailing: [Slot]
    
    
    @State private var location: CGFloat = .zero
    
    
    
    private func flushState() {
        self.location = .zero
    }
    
    func body(content: Content) -> some View {

        
        ZStack(alignment: .trailing) {
            content
                .offset(x: location)
                .onDisappear {
                    flushState()
                }
                
            leadingSlotsView
            
            trailingSlotsView
            
        }
        .gesture(
            DragGesture()
                .onChanged({ value in
                    if value.translation.width < (-75 * CGFloat(trailing.count)) {
                        self.location = -75 * CGFloat(trailing.count)
                    } else if value.translation.width > (75 * CGFloat(leading.count)) {
                        self.location = 75 * CGFloat(leading.count)
                    } else {
                        self.location = value.translation.width
                    }
                })
                .onEnded({ value in
                    if value.translation.width < -75 {
                        self.location = -75 * CGFloat(trailing.count)
                    } else if value.translation.width > 75 {
                        self.location = 75 * CGFloat(leading.count)
                    } else {
                        flushState()
                    }
                })
        )
        .animation(.interactiveSpring())
        
    }
    
    
    var leadingSlotsView: some View {
        HStack {
            ZStack() {
                ForEach(leading) { slot in
                    let index = leading.firstIndex(where: { $0.id == slot.id })!
                    ZStack {
                        Rectangle()
                            .foregroundColor(slot.backgroundColor)
                        VStack(spacing: 3) {
                            if slot.image != nil {
                                slot.image!
                                    .foregroundColor(.white)
                            }
                            if slot.text != nil {
                                Text(slot.text!)
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .padding(.vertical, 5)
                    }
                    .offset(x: -75 + location / CGFloat(leading.count))
                    .offset(x: location / CGFloat(leading.count) * CGFloat(index))
                    .frame(width: 75)
                    .onTapGesture {
                        flushState()
                    }
                    .zIndex(Double(-index))

                }
            }
            Spacer()
        }
        .padding(.vertical, -6)
        .padding(.leading, -20)
    }
    
    var trailingSlotsView: some View {
        HStack {
            Spacer()
            ZStack() {
                ForEach(trailing) { slot in
                    let index = trailing.firstIndex(where: { $0.id == slot.id })!
                    ZStack {
                        Rectangle()
                            .foregroundColor(slot.backgroundColor)
                        VStack(spacing: 3) {
                            if slot.image != nil {
                                slot.image!
                                    .foregroundColor(.white)
                            }
                            if slot.text != nil {
                                Text(slot.text!)
                                    .foregroundColor(.white)
                            }
                        }
                        .font(.system(size: 17, weight: .medium, design: .rounded))
                        .padding(.vertical, 5)
                    }
                    .offset(x: 75 + location / CGFloat(trailing.count))
                    .offset(x: location / CGFloat(trailing.count) * CGFloat(index))
                    .frame(width: 75)
                    .onTapGesture {
                        flushState()
                    }
                    .zIndex(Double(-index))

                }
            }
        }
        .padding(.vertical, -6)
        .padding(.trailing, -20)
    }
    
}
