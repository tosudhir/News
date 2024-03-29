//
//  Logger.swift
//
//  Created by Arvind Singh on 09/06/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import Foundation
import UIKit

/**
 * Singleton class to print custom log messages easier to read and analize. Based in glyphs and log levels
 */
final class Logger {
    private static let kLogDirectoryName = "Logs"

    // MARK: - Singleton Instance

    class var shared: Logger {
        struct Singleton {
            static let instance = Logger()
        }
        return Singleton.instance
    }

    // Enum defining our log levels
    public enum Level: Int {
        case verbose
        case debug
        case info
        case warning
        case error
        case severe

        public var description: String {
            switch self {
            case .verbose:
                return "Verbose"
            case .debug:
                return "Debug"
            case .info:
                return "Info"
            case .warning:
                return "Warning"
            case .error:
                return "Error"
            case .severe:
                return "Severe"
            }
        }

        public static let all: [Level] = [.verbose, .debug, .info, .warning, .error, .severe]

        func atLeast(_ level: Level) -> Bool {
            return level.rawValue >= rawValue
        }
    }

    // Configuration settings
    private struct Configuration {
        var logLevel: Level

        var showLogLevel: Bool
        var showThreadName: Bool
        var showFunctionName: Bool
        var showFileName: Bool
        var showLineNumber: Bool

        var writeToFile: Bool
    }

    private var configuration: Configuration!

    private init() {
        // Set the defaut level to error
        configuration = Configuration(logLevel: .error, showLogLevel: true, showThreadName: false, showFunctionName: true, showFileName: true, showLineNumber: true, writeToFile: false)
    }

    // A shortcut method to configure the logger.
    class func setup(_ logLevel: Level, showLogLevel: Bool = true, showThreadName: Bool = false, showFunctionName: Bool = true, showFileName: Bool = true, showLineNumber: Bool = true, writeToFile: Bool = false) {
        Logger.shared.configuration = Configuration(logLevel: logLevel, showLogLevel: showLogLevel, showThreadName: showThreadName, showFunctionName: showFunctionName, showFileName: showFileName, showLineNumber: showLineNumber, writeToFile: writeToFile)
    }

    // Log a message if the logger's log level is equal to or lower than the specified level.
    class func log(_ message: String, properties: [String: Any]? = nil, level: Level = .debug, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        let config = Logger.shared.configuration!

        if config.logLevel.atLeast(level) {
            var appendContents = Logger.formattedMessage(message, properties: properties, level: level, fileName: fileName, line: line, column: column, functionName: functionName)
            debugPrint(appendContents)

            if config.writeToFile {
                let logFilePath = Logger.logFilePath()
                if !FileManager.default.fileExists(atPath: logFilePath) {
                    appendContents = Logger.headerContent() + appendContents
                    debugPrint("Log file created")
                } else {
                    appendContents = logPrint() + appendContents
                }

                appendContents += "\n\n"

                do {
                    try appendContents.write(toFile: logFilePath, atomically: true, encoding: String.Encoding.utf8)
                } catch let error as NSError {
                    print("Unable to write : \(error.debugDescription)")
                }
            }
        }
    }

    private class func formattedMessage(_ message: String, properties: [String: Any]?, level: Level, fileName: String, line: Int, column _: Int, functionName: String) -> String {
        let config = Logger.shared.configuration!
        var appendContents = String()
        appendContents += "\(Date().toString())"
        appendContents += config.showLogLevel ? " [\(level.description)]" : ""
        appendContents += config.showFileName ? " [\(sourceFileName(filePath: fileName))]" : ""
        appendContents += config.showLineNumber ? " [\(line)]" : ""

        if config.showThreadName {
            let name = __dispatch_queue_get_label(nil)
            let queuename = String(cString: name, encoding: .utf8)
            appendContents += config.showThreadName ? " [\(String(describing: queuename))]" : ""
        }

        appendContents += config.showFunctionName ? " \(functionName)" : ""
        appendContents += " -> \(message)"

        if let properties = properties {
            appendContents += "\nPROPERTIES ¬ \n"

            for (key, _) in properties {
                assert(properties[key] != nil, "Event property cannot be null")
                appendContents += "\(key): \"\(String(describing: properties[key]))\"\n"
            }
        }

        return appendContents
    }

    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }

    private class func logDirectoryPath() -> URL {
        let url = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]).appendingPathComponent(Logger.kLogDirectoryName)

        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: false, attributes: nil)
                debugPrint("Log directory created")
            } catch let error as NSError {
                print("Unable to create directory : \(error.debugDescription)")
            }
        }

        return url
    }

    private class func todayDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return "\(formatter.string(from: Date()))"
    }

    private class func logFilePath() -> String {
        return "\(Logger.logDirectoryPath().appendingPathComponent(Logger.todayDate()).path).txt"
    }

    private class func headerContent() -> String {
        return "Log Created: \(Logger.todayDate())\nApp Name: \(String(describing: Bundle.main.object(forInfoDictionaryKey: "CFBundleName")))\nApp Bundle Identifier: \(Bundle.main.bundleIdentifier ?? "Not available")\nDevice: \(UIDevice.current.name) (\(UIDevice.current.systemName) \(UIDevice.current.systemVersion))\nLocalization: \(String(describing: NSLocale.current.languageCode))\n\n"
    }

    private class func logPrint() -> String {
        var content: String?
        let path = Logger.logFilePath()

        if FileManager.default.fileExists(atPath: path) {
            do {
                content = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
            }
        }

        return content ?? ""
    }

    private class func logData() -> Data? {
        return FileManager.default.contents(atPath: Logger.logFilePath())
    }
}

// MARK: - Logging methods

extension Logger {
    class func verbose(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .verbose, fileName: fileName, line: line, column: column, functionName: functionName)
    }

    class func debug(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .debug, fileName: fileName, line: line, column: column, functionName: functionName)
    }

    class func info(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .info, fileName: fileName, line: line, column: column, functionName: functionName)
    }

    class func warning(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .warning, fileName: fileName, line: line, column: column, functionName: functionName)
    }

    class func error(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .error, fileName: fileName, line: line, column: column, functionName: functionName)
    }

    class func severe(_ message: String, properties: [String: Any]? = nil, fileName: String = #file, line: Int = #line, column: Int = #column, functionName: String = #function) {
        Logger.log(message, properties: properties, level: .severe, fileName: fileName, line: line, column: column, functionName: functionName)
    }
}

internal extension Date {
    private static var dateFormat = "yyyy-MM-dd hh:mm:ss.SSS"
    private static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }

    func toString() -> String {
        return Date.dateFormatter.string(from: self as Date)
    }
}
