//
//  ToggleButton.swift
//  GeometoryReaderSample
//
//  Created by 能登 要 on 2025/10/19.
//

import SwiftUI

import SwiftUI

struct ToggleButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: "line.3.horizontal.decrease")
                    .font(.body)
                
                Text(title)
                    .font(.body)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .foregroundColor(isSelected ? .white : .gray)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .fill(isSelected ? Color.gray : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.black, lineWidth: isSelected ? 0 : 1.5)
            )
        }
    }
}

// プレビュー
#Preview("選択状態") {
    ToggleButton(
        title: "プレゼン資料",
        isSelected: true
    ) {

    }
}

#Preview("未選択状態") {
    ToggleButton(
        title: "プレゼン資料",
        isSelected: false
    ) {

    }
}
