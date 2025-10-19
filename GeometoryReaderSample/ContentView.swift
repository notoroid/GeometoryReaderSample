//
//  ContentView.swift
//  GeometoryReaderSample
//
//  Created by 能登 要 on 2025/10/19.
//

import SwiftUI

struct Item: Identifiable {
    let id = UUID()
    let title: String
    let icon: String
    let color: Color
}

struct ContentView: View {
    let items = [
        Item(title: "Blog", icon: "person.circle", color: .blue)
    ]
    
    var body: some View {
        
        NavigationStack {
            List {
                Section(header: Text("コンテンツ")) {
                    ForEach(items) { item in
                        NavigationLink(destination: BlogListView()) {
                            HStack {
                                Text(item.title)
                            }
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("ホーム")
        }
    }
}

#Preview {
    ContentView()
}
