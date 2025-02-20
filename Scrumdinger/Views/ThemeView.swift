//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Aleksei Morozow on 07.02.2025.
//

import SwiftUI

struct ThemeView: View {
    let theme: Theme
    
    var body: some View {
        Text(theme.name)
            .padding(4)
            .foregroundStyle(theme.accentColor)
            .frame(maxWidth: .infinity)
            .background(theme.mainColor)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ThemeView(theme: .orange)
}
