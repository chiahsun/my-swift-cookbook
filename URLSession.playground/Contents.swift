import Cocoa
import Combine

// https://developer.apple.com/documentation/foundation/urlsession/processing_url_session_data_task_results_with_combine
// https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory

struct User: Codable {
    let login: String
    let id: Int
    let url: String
}

let cancellable = URLSession.shared.dataTaskPublisher(           // <1>
        for: URL(string: "https://api.github.com/users/github")!
    )
    // https://developer.apple.com/documentation/combine/publishers/maperror/trymap(_:)
    .tryMap { element -> Data in                                 // <2>
        guard let httpResponse = element.response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        return element.data
    }
    // https://developer.apple.com/documentation/combine/fail/decode(type:decoder:)
    .decode(type: User.self, decoder: JSONDecoder())             // <3>
    // https://developer.apple.com/documentation/combine/fail/sink(receivevalue:)
    .sink(
        receiveCompletion: {                                     // <4>
            print ("Received completion: \($0).")
        }, receiveValue: { user in
            print ("Received user: \(user)")
        }
    )

// Prints:
//   Received user: User(login: "github", id: 9919, url: "https://api.github.com/users/github")
//   Received completion: finished.

// curl -H "Accept: application/vnd.github.v3+json" https://api.github.com/users/nosuchuserexample
let cancellable2 = URLSession.shared.dataTaskPublisher(
        for: URL(string: "https://api.github.com/users/nosuchuserexample")!
    )
    .tryMap { element -> Data in
        guard let httpResponse = element.response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        guard httpResponse.statusCode == 200 else {
            let data = String(bytes: element.data, encoding: .utf8)
            throw URLError(                                             // <1>
                URLError.Code(rawValue: httpResponse.statusCode),
                userInfo: ["data": data ?? "Fail to convert to string"]
            )
        }
        return element.data
    }
    .decode(type: User.self, decoder: JSONDecoder())
    .sink(receiveCompletion: {
            print ("Received completion: \($0).")                       // <2>
    }, receiveValue: { user in
        print ("Received user: \(user)")
    })

// Prints:
//   Received completion: failure(Error Domain=NSURLErrorDomain Code=404 "(null)" UserInfo={data={"message":"Not Found","documentation_url":"https://docs.github.com/rest/reference/users#get-a-user"}}).

