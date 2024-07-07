//
//  JsonFileReader.swift
//  SMGAssignmentTests
//
//  Created by Lữ on 7/7/24.
//

import Foundation

/// Possible errors while reading a json file
enum FileReaderError: Error {
    case fileNotFound(fileName: String)
    case fileCantRead(fileName: String)
    case fileCantParsetoDict(fileName: String)

    var description: String {
        switch self {
        case .fileNotFound(let fileName):
            return "\(fileName).json not found"
        case .fileCantRead(let fileName):
            return "Unable to convert \(fileName).json to Data"
        case .fileCantParsetoDict(let fileName):
            return "Unable to convert \(fileName).json to JSON dictionary"
        }
    }
}

/// Json file reader utilities
class JsonFileReader {
    static let shared = JsonFileReader()
    /// Load JSON content from file name
    /// - Parameter fileName: The input file name
    /// - Returns: JSON content
    func loadJSonString(fileName: String) throws -> String {
        guard let pathString = Bundle(for: type(of: self)).path(forResource: fileName, ofType: "json") else {
            throw FileReaderError.fileNotFound(fileName: fileName)
        }

        let jsonString = try String(contentsOfFile: pathString, encoding: .utf8)

        return jsonString
    }

    /// Create JSON data from
    /// - Parameter fileName: The input file name
    /// - Returns: JSON data
    func loadJSonData(fileName: String) throws -> Data {
        let jsonString = try loadJSonString(fileName: fileName)

        guard let jsonData = jsonString.data(using: .utf8) else {
            throw FileReaderError.fileCantRead(fileName: fileName)
        }
        return jsonData
    }
    
    func loadObject<T: Decodable>(fileName: String) throws -> T {
        let decoder = JSONDecoder()

        return try decoder.decode(
            T.self,
            from: JsonFileReader.shared.loadJSonData(fileName: fileName)
        )
    }
}
