//
//  HTTPStatusCode.swift
//  NewsFeed
//
//  Created by Sudhir on 17/09/19.
//  Copyright © 2019 Sudhir. All rights reserved.
//

import Foundation

/// HTTP Status Code (RFC 2616)
public enum HTTPStatusCode: Int {
    case `continue` = 100,
        switchingProtocols = 101

    case ok = 200,
        created = 201,
        accepted = 202,
        nonAuthoritativeInformation = 203,
        noContent = 204,
        resetContent = 205,
        partialContent = 206

    case multipleChoices = 300,
        movedPermanently = 301,
        found = 302,
        seeOther = 303,
        notModified = 304,
        useProxy = 305,
        unused = 306,
        temporaryRedirect = 307

    case badRequest = 400,
        unauthorized = 401,
        paymentRequired = 402,
        forbidden = 403,
        notFound = 404,
        methodNotAllowed = 405,
        notAcceptable = 406,
        proxyAuthenticationRequired = 407,
        requestTimeout = 408,
        conflict = 409,
        gone = 410,
        lengthRequired = 411,
        preconditionFailed = 412,
        requestEntityTooLarge = 413,
        requestUriTooLong = 414,
        unsupportedMediaType = 415,
        requestedRangeNotSatisfiable = 416,
        expectationFailed = 417

    case internalServerError = 500,
        notImplemented = 501,
        badGateway = 502,
        serviceUnavailable = 503,
        gatewayTimeout = 504,
        httpVersionNotSupported = 505

    case userAccessDenied = 600,
        forceApplicationUpdate = 601,
        warningApplicationUpdate = 602,
        applicationUnderMaintenance = 603

    case invalidUrl = -1001

    case unknownStatus = 0

    init(statusCode: Int) {
        self = HTTPStatusCode(rawValue: statusCode) ?? .unknownStatus
    }

    public var statusDescription: String {
        switch self {
        case .continue:
            return "Continue"
        case .switchingProtocols:
            return "Switching protocols"
        case .ok:
            return "OK"
        case .created:
            return "Created"
        case .accepted:
            return "Accepted"
        case .nonAuthoritativeInformation:
            return "Non authoritative information"
        case .noContent:
            return "No content"
        case .resetContent:
            return "Reset content"
        case .partialContent:
            return "Partial Content"
        case .multipleChoices:
            return "Multiple choices"
        case .movedPermanently:
            return "Moved Permanently"
        case .found:
            return "Found"
        case .seeOther:
            return "See other Uri"
        case .notModified:
            return "Not modified"
        case .useProxy:
            return "Use proxy"
        case .unused:
            return "Unused"
        case .temporaryRedirect:
            return "Temporary redirect"
        case .badRequest:
            return "Bad request"
        case .unauthorized:
            return "Access denied"
        case .paymentRequired:
            return "Payment required"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Page not found"
        case .methodNotAllowed:
            return "Method not allowed"
        case .notAcceptable:
            return "Not acceptable"
        case .proxyAuthenticationRequired:
            return "Proxy authentication required"
        case .requestTimeout:
            return "Your request has been timeout."
        case .conflict:
            return "Conflict request"
        case .gone:
            return "Page is gone"
        case .lengthRequired:
            return "Lack content length"
        case .preconditionFailed:
            return "Precondition failed"
        case .requestEntityTooLarge:
            return "Request entity is too large"
        case .requestUriTooLong:
            return "Request uri is too long"
        case .unsupportedMediaType:
            return "Unsupported media type"
        case .requestedRangeNotSatisfiable:
            return "Request range is not satisfiable"
        case .expectationFailed:
            return "Expected request is failed"
        case .internalServerError:
            return "Internal server error"
        case .notImplemented:
            return "Server does not implement a feature for request"
        case .badGateway:
            return "Bad gateway"
        case .serviceUnavailable:
            return "Service unavailable"
        case .gatewayTimeout:
            return "Gateway timeout"
        case .httpVersionNotSupported:
            return "Http version not supported"
        case .invalidUrl:
            return "Invalid url"
        case .userAccessDenied:
            return "User access denied"
        case .forceApplicationUpdate:
            return "An updated version of this application is available on App Store. Kindly update your application to continue."
        case .warningApplicationUpdate:
            return "An updated version of this application is available on App Store. Kindly update your application to enjoy new features."
        case .applicationUnderMaintenance:
            return "Server is under maintenance."
        default:
            return "Unknown status code"
        }
    }
}
