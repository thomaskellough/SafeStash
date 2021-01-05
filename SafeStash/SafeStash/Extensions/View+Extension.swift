//
//  View+Extension.swift
//  SafeStash
//
//  Created by Thomas Kellough on 12/20/20.
//

import Foundation
import SwiftUI

extension View {
    func border(width: CGFloat, edges: [Edge], color: Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
