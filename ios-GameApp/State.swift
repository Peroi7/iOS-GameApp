//
//  State.swift
//  ios-GameApp
//
//  Created by Pero Ivic on 20/02/2024.
//

import Foundation

enum State {
    case loading
    case loaded([ViewModel])
    case paging([ViewModel])
    case error(Error)
}
