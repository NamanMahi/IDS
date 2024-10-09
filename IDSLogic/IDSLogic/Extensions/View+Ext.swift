//
//  View+Ext.swift
//  IDSLogic
//
//  Created by Rajshree Jaiswal on 09/10/24.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}
