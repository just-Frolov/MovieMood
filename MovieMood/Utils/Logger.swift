//
//  Logger.swift
//  MovieMood
//
//  Created by Danil Frolov on 29.04.2023.
//

import Foundation

enum Logger {
    
    fileprivate enum `Type`: String {
        case debug = "🟢🟢🟢"
        case error = "🟡🟡🟡"
    }

    // MARK: - Properties
    private static let mainTag = "FX___"
}

extension Logger {

    static func debug(
        _ msg: String,
        tag: String? = #function,
        file: String? = #file,
        line: Int? = #line
    ) {
        log(msg, tag: tag, type: .debug, file: file, line: line)
    }

    static func error(
        _ msg: String,
        tag: String? = #function,
        file: String? = #file,
        line: Int? = #line
    ) {
        log(msg, tag: tag, type: .error, file: file, line: line)
    }
}

// MARK: - Private Methods
private extension Logger {

    static func log(
        _ msg: String,
        tag: String? = nil,
        type: Type,
        file: String? = nil,
        line: Int? = nil
    ) {
        var message = "\n" + self.mainTag + "\(type.rawValue) |"

        if let url = URL(string: file ?? "") {
            message += " \(url.lastPathComponent) |"
        } else if let file = file {
            message += " \(file) |"
        }

        if let tag = tag {
            message += " \(tag) |"
        }
        if let line = line {
            message += " \(line) |"
        }
        message += " \(msg) ||"
        self.printMessage(message)
    }
    
    static func printMessage(_ message: String) {
        #if DEBUG
        print(message)
        #endif
    }
}
