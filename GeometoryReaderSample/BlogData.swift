//
//  BlogData.swift
//  GeometoryReaderSample
//
//  Created by 能登 要 on 2025/10/19.
//

import Foundation

struct BlogData: Identifiable {
    let id: UUID = UUID()
    let publishDate: Date
    let author: String
    let category: String
    let summary: String
    let tags: [String]
}

extension BlogData {
    static func sampleData(filtered: Bool) ->[BlogData] {
        guard filtered else {
            return sampleData.sorted(by: { lhs, rhs in lhs.publishDate > rhs.publishDate })
        }
        return sampleData.filter({ $0.category == "プレゼン資料"}).sorted(by: { lhs, rhs in lhs.publishDate > rhs.publishDate })
    }
    
    
    static let sampleData: [BlogData] = [
        BlogData(
            publishDate: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: "2023-12-09 14:30") ?? Date()
            }(),
            author: "notoroid",
            category: "プレゼン資料",
            summary: "札幌iPhone開発勉強会でUVC(USB Video Class)についてのプレゼンテーションを行いました。iPadOS17以降でiPadがUVCに対応したことについて解説しています。",
            tags: ["UVC", "USB Video Class", "iPadOS17", "プレゼン", "札幌iPhone開発勉強会"]
        ),
        BlogData(
            publishDate: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: "2023-08-06 15:00") ?? Date()
            }(),
            author: "notoroid",
            category: "プレゼン資料",
            summary: "SwiftUI向けに整理された状態監視についてのプレゼン資料です。iOS17から利用可能となるSwiftUIの新しいObservation機能について解説しました。",
            tags: ["SwiftUI", "Observation", "iOS17", "状態管理", "札幌iPhone開発勉強会"]
        ),
        BlogData(
            publishDate: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: "2023-06-28 14:00") ?? Date()
            }(),
            author: "notoroid",
            category: "プレゼン資料",
            summary: "WWDC23で発表されたSwift5.9の新機能についてまとめたプレゼンテーション資料です。よせあつめSwiftシリーズとして札幌iPhone開発勉強会で発表しました。",
            tags: ["Swift5.9", "WWDC23", "プレゼン", "Swift言語仕様"]
        ),
        BlogData(
            publishDate: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: "2022-12-20 16:30") ?? Date()
            }(),
            author: "notoroid",
            category: "プレゼン資料",
            summary: "WWDC22で発表されたTransferableについてのプレゼン資料です。SwiftUIでのデータ転送を簡単にする新しいプロトコルについて解説しました。",
            tags: ["Transferable", "SwiftUI", "WWDC22", "データ転送"]
        ),
        BlogData(
            publishDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date(),
            author: "notoroid",
            category: "トラブルシューティング",
            summary: "Xcodeインストール後にXPC connection interruptedエラーが発生する問題について。手動でXcodeをインストールする際、最初のディレクトリ以外に移動すると発生します。",
            tags: ["Xcode", "トラブルシューティング", "XPC", "インストール"]
        ),
        BlogData(
            publishDate: Calendar.current.date(byAdding: .day, value: -45, to: Date()) ?? Date(),
            author: "notoroid",
            category: "トラブルシューティング",
            summary: "macOS MontereでiMovieがアップデートできない問題の対処法について。NVMとiMovieを併用する際に発生するトラブルの解決方法をまとめました。",
            tags: ["macOS", "iMovie", "アップデート", "NVM", "トラブル解決"]
        ),
        BlogData(
            publishDate: Calendar.current.date(byAdding: .day, value: -60, to: Date()) ?? Date(),
            author: "notoroid",
            category: "SwiftUI100行チャレンジ",
            summary: "SwiftUIベースのプッシュ通知テストベッドコードを100行で実装しました。アプリ表示中での通知も有効にしています。",
            tags: ["SwiftUI", "プッシュ通知", "100行チャレンジ", "テストコード"]
        ),
        BlogData(
            publishDate: {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm"
                return formatter.date(from: "2022-06-25 13:30") ?? Date()
            }(),
            author: "notoroid",
            category: "プレゼン資料",
            summary: "WWDC22で発表されたSwift5.7の言語仕様について整理したプレゼン資料です。anyとsomeキーワードを中心に解説しました。",
            tags: ["Swift5.7", "WWDC22", "any", "some", "言語仕様"]
        ),
        BlogData(
            publishDate: Calendar.current.date(byAdding: .hour, value: -5, to: Date()) ?? Date(),
            author: "notoroid",
            category: "技術メモ",
            summary: "今日は最新のSwiftUIの動向について調査しました。iOS18のベータ版で新しいAPIがいくつか追加されているようです。",
            tags: ["SwiftUI", "iOS18", "調査", "最新情報"]
        ),
        BlogData(
            publishDate: Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date(),
            author: "notoroid",
            category: "開発日記",
            summary: "札幌iPhone開発勉強会の次回テーマについて検討中です。Vision Proの開発環境について取り上げたいと思います。",
            tags: ["勉強会", "Vision Pro", "企画", "開発環境"]
        )
    ]
}
