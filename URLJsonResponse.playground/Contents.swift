import Cocoa

// https://en.wikipedia.org/w/api.php?action=parse&format=json&page=Pet_door&prop=wikitext&formatversion=2
struct Parse: Codable {            // <1>
    let title: String
    let pageid: Int
    let wikitext: String
}

struct WikitextPayload: Codable {  // <1>
    let parse: Parse
}

func requestWikitext(_ targetURL: String) {
    if let url = URL(string: targetURL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {       // <2>
                print("Error: \(error)")
                return
            }
            if let data = data {
              
                //if let jsonString = String(data: data, encoding: .utf8) {
                    //print(jsonString)
                //}
                do {
                    let payload = try JSONDecoder().decode(WikitextPayload.self, from: data)
                    print("Title: ", payload.parse.title)
                    print("Payload: ", payload.parse.pageid)
                    print("Wikitext: ", String(payload.parse.wikitext.prefix(30)))

                } catch {   // <3>
                    print("Error: Couldn't parse payload")
                }
            }
        }.resume()
    }
}

// Success!
requestWikitext("https://en.wikipedia.org/w/api.php?action=parse&format=json&page=Pet_door&prop=wikitext&formatversion=2")

// Error connecting server
requestWikitext("https://en.wikipedia.org:12345/w/api.php?action=parse&format=json&page=Pet_door&prop=wikitext&formatversion=2")

// Error parsing payload
requestWikitext("https://en.wikipedia.org/w/api.php?action=parse&format=json&page=Pet_door12314124312&prop=wikitext&formatversion=2")
