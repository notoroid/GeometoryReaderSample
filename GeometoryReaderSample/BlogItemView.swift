//
//  BlogItemView.swift
//  GeometoryReaderSample
//
//  Created by 能登 要 on 2025/10/19.
//

import SwiftUI

struct BlogItemView: View {
    let data: BlogData
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header: Date and Author
            HStack(spacing: 12) {
                // Date
                Label {
                    Text(dateFormatter.string(from: data.publishDate))
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                } icon: {
                    Image(systemName: "calendar")
                        .foregroundColor(.secondary)
                }
                Spacer()
                // Author
                Text(data.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            // Category Badge
            Text(data.category)
                .font(.caption)
                .fontWeight(.medium)
                .padding(.horizontal, 12)
                .padding(.vertical, 6)
                .background(
                    Capsule()
                        .strokeBorder(Color.primary.opacity(0.3), lineWidth: 1.5)
                )
                .frame(maxWidth: .infinity, alignment: .leading)
            
            // Summary
            Text(data.summary)
                .font(.body)
                .foregroundColor(.primary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            // Tags Cluster
            if !data.tags.isEmpty {
                TagClusterView(tags: data.tags)
            }
        }
        .padding(16)
    }
}

// Tag Cluster Component
struct TagClusterView: View {
    let tags: [String]
    
    var body: some View {
        FlowLayout(spacing: 8) {
            ForEach(tags, id: \.self) { tag in
                HStack(spacing: 4) {
                    Text(tag)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .fill(Color.gray.opacity(0.1))
                )
            }
        }
    }
}

// Flow Layout for wrapping tags
struct FlowLayout: Layout {
    var spacing: CGFloat = 8
    
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        let result = FlowResult(
            in: proposal.replacingUnspecifiedDimensions().width,
            subviews: subviews,
            spacing: spacing
        )
        return result.size
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        let result = FlowResult(
            in: bounds.width,
            subviews: subviews,
            spacing: spacing
        )
        for (index, subview) in subviews.enumerated() {
            subview.place(at: CGPoint(x: bounds.minX + result.positions[index].x,
                                     y: bounds.minY + result.positions[index].y),
                         proposal: .unspecified)
        }
    }
    
    struct FlowResult {
        var size: CGSize = .zero
        var positions: [CGPoint] = []
        
        init(in maxWidth: CGFloat, subviews: Subviews, spacing: CGFloat) {
            var currentX: CGFloat = 0
            var currentY: CGFloat = 0
            var lineHeight: CGFloat = 0
            
            for subview in subviews {
                let size = subview.sizeThatFits(.unspecified)
                
                if currentX + size.width > maxWidth && currentX > 0 {
                    currentX = 0
                    currentY += lineHeight + spacing
                    lineHeight = 0
                }
                
                positions.append(CGPoint(x: currentX, y: currentY))
                lineHeight = max(lineHeight, size.height)
                currentX += size.width + spacing
            }
            
            self.size = CGSize(width: maxWidth, height: currentY + lineHeight)
        }
    }
}

// Preview
struct BlogItemView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 16) {
                BlogItemView(data: BlogData(
                    publishDate: {
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyy-MM-dd HH:mm"
                        return formatter.date(from: "2023-12-09 14:30") ?? Date()
                    }(),
                    author: "notoroid",
                    category: "プレゼン資料",
                    summary: "札幌iPhone開発勉強会でUVC(USB Video Class)についてのプレゼンテーションを行いました。iPadOS17以降でiPadがUVCに対応したことについて解説しています。",
                    tags: ["UVC", "USB Video Class", "iPadOS17", "プレゼン", "札幌iPhone開発勉強会"]
                ))
                
                BlogItemView(data: BlogData(
                    publishDate: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(),
                    author: "notoroid",
                    category: "技術メモ",
                    summary: "今日は最新のSwiftUIの動向について調査しました。iOS18のベータ版で新しいAPIがいくつか追加されているようです。",
                    tags: ["SwiftUI", "iOS18", "調査", "最新情報"]
                ))
            }
            .padding()
        }
        .background(Color(.systemGroupedBackground))
    }
}
