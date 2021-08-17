import Cocoa

enum HttpStatusType: Int {
    case information = 1, successful, redirects, client_errors, server_errors
}

struct HttpStatus {
    var code: Int
    var type: HttpStatusType
}

// https://developer.mozilla.org/en-US/docs/Web/HTTP/Status
let data = [
    HttpStatus(code: 100, type: .information),
    HttpStatus(code: 101, type: .information),
    HttpStatus(code: 200, type: .successful),
    HttpStatus(code: 201, type: .successful),
    HttpStatus(code: 202, type: .successful),
    HttpStatus(code: 400, type: .client_errors),
    HttpStatus(code: 403, type: .client_errors),
    HttpStatus(code: 404, type: .client_errors),
]

// https://developer.apple.com/documentation/swift/dictionary
// https://developer.apple.com/documentation/swift/dictionary/3127163-init
// https://developer.apple.com/tutorials/swiftui/composing-complex-interfaces
var statusToCodes: [HttpStatusType: [HttpStatus]] {
    Dictionary(
        grouping: data,
        by: { $0.type }
    )
}

statusToCodes[.client_errors]
