import SwiftUI

public extension View {
    internal func swipeGesture(leading: [Slot] = [], trailing: [Slot] = []) -> some View {
        self
            .contentShape(Rectangle())
            .modifier(SwipeGestureModifier(leading: leading, trailing: trailing))
            
    }
}
