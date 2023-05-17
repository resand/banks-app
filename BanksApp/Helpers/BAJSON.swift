//
//  BAJSON.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

final class BAJSON: Sequence, CustomStringConvertible {
    private var json: Any

    var description: String {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) as Data {
            if let description = String(data: data, encoding: String.Encoding.utf8) {
                return description
            } else {
                return String(describing: json)
            }
        } else {
            return String(describing: json)
        }
    }

    // MARK: - Initializers

    init(from any: Any) {
        json = any
    }

    subscript(path: String) -> BAJSON? {
        guard var jsonDict = json as? [String: AnyObject] else {
            return nil
        }

        var json = json
        let pathArray = path.components(separatedBy: ".")

        for key in pathArray {
            if let jsonObject = jsonDict[key] {
                json = jsonObject

                if let jsonDictNext = jsonObject as? [String: AnyObject] {
                    jsonDict = jsonDictNext
                }
            } else {
                return nil
            }
        }

        return BAJSON(from: json)
    }

    subscript(index: Int) -> BAJSON? {
        guard let array = json as? [AnyObject], array.count > index else { return nil }
        return BAJSON(from: array[index])
    }

    class func dataToJson(_ data: Data) throws -> BAJSON {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
        let json = BAJSON(from: jsonObject as AnyObject)

        return json
    }

    // MARK: - Public methods

    func toData() -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: json)
            return data
        } catch let error as NSError {
            logError(error)
            return nil
        }
    }

    func toBool() -> Bool? {
        json as? Bool
    }

    func toInt() -> Int? {
        if let value = json as? Int {
            return value
        } else if let value = toString() {
            return Int(value)
        }

        return nil
    }

    func toString() -> String? {
        json as? String
    }

    func toDouble() -> Double? {
        json as? Double
    }

    func toDictionary() -> [String: Any]? {
        guard let dic = json as? [String: Any] else {
            return [:]
        }

        return dic
    }

    // MARK: - Sequence Methods

    func makeIterator() -> AnyIterator<BAJSON> {
        var index = 0

        return AnyIterator { () -> BAJSON? in
            guard let array = self.json as? [AnyObject] else { return nil }
            guard array.count > index else { return nil }

            let item = array[index]
            let json = BAJSON(from: item)
            index += 1

            return json
        }
    }
}
