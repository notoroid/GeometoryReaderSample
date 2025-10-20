//
//  BlogListView.swift
//  GeometoryReaderSample
//
//  Created by 能登 要 on 2025/10/19.
//

import SwiftUI

struct BlogListView: View {
    @State private var showNavigationButton = false
    @State private var isCollapsed = false
    @State private var isFiltered = false
    

    var body: some View {
        ScrollView {
            // トップアンカー　ex. use .onChange() modifier
//            GeometryReader { geo in
//                let minY = geo.frame(in: .global).minY
//                Color.clear
//                    .onChange(of: minY) { _, newValue in
//                        withAnimation(.easeInOut(duration: 0.15)) {
//                            print("newValue=\(newValue)")
//                            isCollapsed = newValue < 100
//                        }
//                    }
//            }
            // トップアンカー
            Color.clear
                .frame(height: 1)
                .onGeometryChange(for: CGFloat.self) { proxy in
                    proxy.frame(in: .global).minY
                } action: { newMinY in
                    withAnimation(.easeInOut(duration: 0.15)) {
                        print("newValue=\(newMinY)")
                        isCollapsed = newMinY < 100
                    }
                }

            HStack {
                Spacer()
                ToggleButton(title: "プレゼン資料", isSelected: isFiltered) {
                    withAnimation(.easeInOut(duration: 0.15)) {
                        isFiltered = !isFiltered
                    }
                }
            }
            .padding(.horizontal)
            
            LazyVStack(spacing: 16) {
                ForEach(BlogData.sampleData(filtered: isFiltered), id: \.id) { item in
                    BlogItemView(data: item)
                    Divider()
                }
            }
            .padding(.horizontal)
        }
        .navigationTitle("Blog")
        .navigationBarTitleDisplayMode(isCollapsed ? .inline : .large)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                if isCollapsed {
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            isFiltered = !isFiltered
                        }
                    }) {
                        if isFiltered  {
                            Text("プレゼン資料のみ")
                        } else {
                            Text("全て")
                        }
                    }
                }
            }
        }
        
    }
}

#Preview {
    NavigationStack {
        BlogListView()
    }
}
