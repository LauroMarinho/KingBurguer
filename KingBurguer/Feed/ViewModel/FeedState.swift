//
//  FeedState.swift
//  KingBurguer
//
//  Created by Lauro Marinho on 24/03/25.
//

import Foundation


enum FeedState {
    case loading
    case success(FeedResponse)
    case successHighlight(HighlightResponse)
    case error(String)
}
