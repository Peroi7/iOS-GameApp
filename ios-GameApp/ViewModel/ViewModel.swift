//
//  ViewModel.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import Foundation
import Combine

public class Selection {
    @Published var isSelected: Bool = false
}

public protocol ViewModel: Selection {
    var items: [ViewModel] { get }
    var selectedGenres: [Int] { get set }
}

