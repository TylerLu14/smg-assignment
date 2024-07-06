//
//  Logger.swift
//  SMGAssignment
//
//  Created by Lữ on 7/6/24.
//

import Foundation

import Foundation

typealias Logger = LoggerDebug

class LoggerDebug {
    static func d(_ tag: String, _ message: String, _ error: Any? = nil) {
        Self.write("D", tag, message, error)
    }
    static func v(_ tag: String, _ message: String, _ error: Any? = nil) {
        Self.write("V", tag, message, error)
    }
    static func i(_ tag: String, _ message: String, _ error: Any? = nil) {
        Self.write("I", tag, message, error)
    }
    static func e(_ tag: String, _ message: String, _ error: Any? = nil) {
        Self.write("E", tag, message, error)
    }
    static func w(_ tag: String, _ message: String, _ error: Any? = nil) {
        Self.write("W", tag, message, error)
    }

    /// Write log message.
    ///
    /// - parameter tag:       tag string.
    /// - parameter message:   message string.
    private static func write(_ level: String,
                              _ tag: String,
                              _ message: String,
                              _ error: Any?) {
        #if !(DEBUG || TEST)
        return
        #endif

        NSLog("[%@][%@]%@", level, tag, message)
        // 1024バイトまでしか出力されないので、下記の方法で追加出力する。
        if (level.utf8.count + tag.utf8.count + message.utf8.count) > 1024 {
            Swift.print("\n===\n[\(level)][\(tag)]\(message)\n===\n")
        }
        if let error = error as? NSError {
            writeWithStack("[\(level)][\(tag)]\(error)", Thread.callStackSymbols)
        } else if let error = error as? Error {
            writeWithStack("[\(level)][\(tag)]\(error)", Thread.callStackSymbols)
        } else {
            // noop
        }
    }

    /// Write log message with stack
    ///
    /// - parameter header: header string.
    /// - parameter stackArray: array of string
    private static func writeWithStack(_ header: String, _ stackArray: [String]) {
        #if !(DEBUG || TEST)
        return
        #endif

        NSLog("%@", header)
        Swift.print("\n" + stackArray.joined(separator: "\n") + "\n")
    }
}
