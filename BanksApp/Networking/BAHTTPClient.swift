//
//  BAHTTPClient.swift
//  BanksApp
//
//  Created by René Sandoval on 16/05/23.
//

import Foundation

private let BAErrorMap: [Int: ResponseType] = [
    400: .badRequest,
    401: .unauthorized,
    403: .forbidden,
    404: .notFound,
    408: .requestTimeOut,
    409: .conflict,
    410: .gone,
    422: .unprocessable,
    426: .upgradeRequired,
    500: .internalError,
    502: .badGateway,
    503: .serviceUnavailable,
    504: .gatewayTimeOut,
    NSURLErrorCancelled: .canceled,
    NSURLErrorTimedOut: .clientTimeOut,
    NSURLErrorNotConnectedToInternet: .notConnected,
]

protocol Routable {
    var url: URL { get }
    var extraHTTPHeaders: [String: String] { get }
}

enum HTTPMethod: String {
    case options, get, head, post, put, patch, delete, trace, connect
}

/// The HTTP response type. The type of this enum is defined by the HTTP Status code or NSURLError
///
/// - succeed:              The request was successfully executed and doesn't need further processing.
/// - badRequest:           The request failed because of a client error
/// - unauthorized:         The request failed because the user is not logged in.
/// - upgradeRequired:      The request failed because the app needs to be upgraded.
/// - forbidden:            The request failed because the user does not have appropriate persmissions.
/// - gone:                 The request failed because the resource is no longer available.
/// - canceled:             The request was canceled by the client.
/// - unprocessable:        The request failed because an error on the information we sent.
/// - notFound:             The request failed because the requested resource wasn't found on the server.
/// - unknownError:         The request failed with an unknown error that shouldn't be retried.
/// - clientTimeOut:        The request failed because there was no response before timeout
/// - notConnected:         The request failed because the user is not connected to the internet
/// - conflict:             The request failed due to a conflict in the request
/// - internalError:        The request failed due to an unexpected condition on the server
/// - badGateway:           The request failed because the server recieved an invalid response from upstream
/// - serviceUnavailable:   The request failed because the server is temporarily unavailable.
/// - requestTimeOut:       The request failed because the client did not produce a request within the time
///                         that the server was prepared to wait
/// - gatewayTimeOut:       The request failed because the server was acting as a gateway or proxy and did not
///                         recieve a response in time
public enum ResponseType {
    case succeed
    case badRequest, unauthorized, upgradeRequired, forbidden, gone
    case canceled, unprocessable, notFound, unknownError, clientTimeOut, notConnected
    case conflict, internalError, badGateway, serviceUnavailable, requestTimeOut, gatewayTimeOut

    init(fromCode code: Int) {
        if code >= 200 && code < 300 {
            self = .succeed
            return
        }

        self = BAErrorMap[code] ?? .unknownError
    }
}

final class BAHTTPClient {
    private let session: URLSession

    required init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        session = URLSession(configuration: configuration)
    }

    func request(
        _ method: HTTPMethod,
        _ route: Routable,
        withData data: [String: Any?]? = nil,
        completion: @escaping (Any?, ResponseType) -> Void
    ) {
        let request = urlRequest(method: method, route: route, withData: data)
        logRequest(request)
        let dataTask = session.dataTask(with: request) { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1001
            var status: ResponseType
            let JSON = try? JSONSerialization.jsonObject(with: data ?? Data(), options: [])

            if let error = error as? NSError {
                self.logResponseError(response: response as? HTTPURLResponse, error)
                status = ResponseType(fromCode: error.code)
                DispatchQueue.main.async {
                    completion(JSON, status)
                }
            } else {
                status = ResponseType(fromCode: statusCode)
                self.logResponse(response as? HTTPURLResponse, data)
                DispatchQueue.main.async {
                    completion(JSON, status)
                }
            }
        }

        dataTask.resume()
    }

    private func urlRequest(method: HTTPMethod, route: Routable, withData data: [String: Any?]? = nil) -> URLRequest {
        var request = URLRequest(url: route.url)
        request.httpMethod = method.rawValue

        if let data {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
            } catch {
                logError(error as NSError)
            }
        }

        for (key, value) in route.extraHTTPHeaders {
            request.setValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}

// MARK: - Logs

extension BAHTTPClient {
    private func logRequest(_ request: URLRequest?) {
        guard BAConfiguration.shared.logLevel == .debug else { return }

        let url = request?.url?.absoluteString ?? "INVALID URL"

        log("******** REQUEST ********")
        log(" - URL:\t" + url)
        log(" - METHOD:\t" + (request?.httpMethod ?? "INVALID REQUEST"))
        logHeaders(request)
        logBody(request)
        log("*************************\n")
    }

    private func logBody(_ request: URLRequest?) {
        guard
            let body = request?.httpBody,
            let json = try? BAJSON.dataToJson(body)
        else { return }

        log(" - BODY:\n\(json)")
    }

    private func logHeaders(_ request: URLRequest?) {
        guard let headers = request?.allHTTPHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    private func logResponse(_ response: HTTPURLResponse?, _ data: Data?) {
        guard BAConfiguration.shared.logLevel == .debug else { return }

        log("******** RESPONSE ********")
        log(" - URL:\t" + logURL(response))
        log(" - CODE:\t" + "\(response?.statusCode ?? -1)")
        logHeaders(response)
        log(" - DATA:\n" + logData(data))
        log("*************************\n")
    }

    private func logResponseError(response: HTTPURLResponse?, _ error: NSError?) {
        guard BAConfiguration.shared.logLevel == .debug else { return }

        log("******** ERROR ********")
        log(" - URL:\t" + logURL(response))
        log(" - CODE:\t" + "\(error?.code ?? -1)")
        logHeaders(response)
        log(" - MESSAGE:\t" + "\(error?.localizedDescription ?? "")")
        log("*************************\n")
    }

    private func logURL(_ response: HTTPURLResponse?) -> String {
        guard let url = response?.url?.absoluteString else {
            return "NO URL"
        }

        return url
    }

    private func logHeaders(_ response: HTTPURLResponse?) {
        guard let headers = response?.allHeaderFields else { return }

        log(" - HEADERS: {")

        for key in headers.keys {
            if let value = headers[key] {
                log("\t\t\(key): \(value)")
            }
        }

        log("}")
    }

    private func logData(_ data: Data?) -> String {
        guard let data else {
            return "NO DATA"
        }

        guard let dataJson = try? BAJSON.dataToJson(data) else {
            return String(data: data, encoding: String.Encoding.utf8) ?? "Error parsing JSON"
        }

        return "\(dataJson)"
    }
}
