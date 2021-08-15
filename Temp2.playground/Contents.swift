import Cocoa

// https://en.wikipedia.org/wiki/Pet_door
// https://en.wikipedia.org/wiki/Special:ApiSandbox#action=parse&page=Pet_door&prop=wikitext&formatversion=2
// https://en.wikipedia.org/wiki/Help:Wikitext

struct Parse: Codable {
    let title: String
    let pageid: Int
    let wikitext: String
}

struct WikitextPayload: Codable {
    let parse: Parse
}

// https://stackoverflow.com/questions/53645475/swift-4-cant-decode-properly-if-json-data-contain-new-line-n
let samplePayload = """
    {
        "parse": {
            "title": "Pet door",
            "pageid": 3276454,
            "wikitext": "{{Short description|best}}\\n[[File:Doggy door exit.JPG|thumb|A dog exiting through a pet door]]\\nA '''pet door''' or '''pet flap''' (also referred to in more specific terms, such as '''cat flap''', '''cat door''', '''dog door''', or '''doggy door''') is a small opening to allow [[pet]]s to enter and exit a building on their own without needing a human to open the door."
        }
    }
"""

let payload = try! JSONDecoder().decode(WikitextPayload.self, from: samplePayload.data(using: .utf8)!)

protocol WikiParser {
    func scan() -> (String?)
}

final class HeaderParser: WikiParser {
    let scanner: Scanner
    
    init(_ string: String) {
        scanner = Scanner(string: string)
    }
    
    init(scanner: Scanner) {
        self.scanner = scanner
    }
    
    var inner: String?
    
    func scan() -> (String?) {
        guard let _ = scanner.scanString("{{") else {
            return nil
        }
        guard let inner = scanner.scanUpToString("}}") else {
            return nil
        }
        guard let _ = scanner.scanString("}}") else {
            return nil
        }
        self.inner = inner
        return inner
    }
}

if true {
    let parser = HeaderParser("{{Short description|best}}")
//    print(parser.scan())
    parser.scan()
    assert(parser.inner == "Short description|best")
}

final class FileParser: WikiParser {
    let scanner: Scanner
    
    init(_ string: String) {
        scanner = Scanner(string: string)
    }
    
    init(scanner: Scanner) {
        self.scanner = scanner
    }
    
    var icon: String?
    var tag: String?
    var alt: String?
    
    func scan() -> (String?) {
        guard let _ = scanner.scanString("[[File:") else {
            return nil
        }
        guard let inner = scanner.scanUpToString("]]") else {
            return nil
        }
        guard let _ = scanner.scanString("]]") else {
            return nil
        }
        let result = FileParser.scan3(inner)
        if let icon = result.0, let tag = result.1, let alt = result.2 {
            self.icon = icon
            self.tag = tag
            self.alt = alt
            return inner
        }
    
        return inner
    }
    
    static func scan3(_ inner: String) -> (String?, String?, String?) {
        let scanner = Scanner(string: inner)

        guard let icon = scanner.scanUpToString("|") else {
            return (nil, nil, nil)
        }
        guard let _ = scanner.scanString("|") else {
            return (nil, nil, nil)
        }
        guard let tag = scanner.scanUpToString("|") else {
            return (nil, nil, nil)
        }
        guard let _ = scanner.scanString("|") else {
            return (nil, nil, nil)
        }
        guard let alt = scanner.scanUpToCharacters(from: CharacterSet.newlines) else {
            return (nil, nil, nil)
        }
        return (icon, tag, alt)
    }
}

if true {
    let parser = FileParser("[[File:Doggy door exit.JPG|thumb|A dog exiting through a pet door]]")
//    print(parser.scan())
    parser.scan()
    assert(parser.icon == "Doggy door exit.JPG")
    assert(parser.tag == "thumb")
    assert(parser.alt == "A dog exiting through a pet door")
}

final class LinkParser: WikiParser {
    let scanner: Scanner
    
    init(_ string: String) {
        scanner = Scanner(string: string)
    }
    
    init(scanner: Scanner) {
        self.scanner = scanner
    }
    
    static func scan2(_ inner: String) -> (String?, String?) {
        let scanner = Scanner(string: inner)

        guard let link = scanner.scanUpToString("|") else {
            return (nil, nil)
        }
        guard let _ = scanner.scanString("|") else {
            return (nil, nil)
        }
        guard let alias = scanner.scanUpToCharacters(from: CharacterSet.newlines) else {
            return (nil, nil)
        }
        return (link, alias)
    }

    var link: String?
    var alias: String?
    
    func scan() -> String? {
        guard let _ = scanner.scanString("[[") else {
            return nil
        }
        guard let inner = scanner.scanUpToString("]]") else {
            return nil
        }
        guard let _ = scanner.scanString("]]") else {
            return nil
        }
        let result = LinkParser.scan2(inner)
        if let link = result.0, let alias = result.1 {
            self.link = link
            self.alias = alias
            return inner
        }

        self.link = inner
        return inner
    }
}

if true {
    var parser = LinkParser("[[pet]]")
    parser.scan()
//    print(parser.scan())
    assert(parser.link == "pet")
    assert(parser.alias == nil)
    
    parser = LinkParser("[[Texas|Lone Star State]]")
//    print(parser.scan())
    parser.scan()
    assert(parser.link == "Texas")
    assert(parser.alias == "Lone Star State")
}

final class TextFormatParser: WikiParser {
    let scanner: Scanner
    
    init(_ string: String) {
        scanner = Scanner(string: string)
    }
    
    init(scanner: Scanner) {
        self.scanner = scanner
    }
    
    var inner: String?
    
    func scan() -> String? {
        guard let _ = scanner.scanString("'''") else {
            return nil
        }
        guard let inner = scanner.scanUpToString("'''") else {
            return nil
        }
        guard let _ = scanner.scanString("'''") else {
            return nil
        }
  
        self.inner = inner
        return inner
    }
}

final class PlainTextParser: WikiParser {
    let scanner: Scanner
    
    init(_ string: String) {
        scanner = Scanner(string: string)
    }
    var text: String?
    
    func scan() -> String? {
        fatalError("Should not used")
    }
}

if true {
    let parser = TextFormatParser("'''pet flap'''")
    parser.scan()
    assert(parser.inner == "pet flap")
}
// https://talk.objc.io/episodes/S01E13-parsing-techniques
// https://developer.apple.com/documentation/foundation/scanner
final class Parser {
    let scanner: Scanner
    
    init(_ string: String) {
        self.string = string
        scanner = Scanner(string: string)
        parsers = []
    }
    
    var string: String
    var parsers: [WikiParser]
    
    // TODO: return index or just advance scanner? or return pattern?
    func seek() -> String? {
        let suffix = string[scanner.currentIndex...]
        
        while true {
            var usedPattern: String? = nil
            var usedByteLength = 0
            for pattern in ["'''", "[["] {
                let suffixScanner = Scanner(string: String(suffix))
                suffixScanner.scanUpToString(pattern)
                let leftByteLength = suffixScanner.string.substring(from: suffixScanner.currentIndex).lengthOfBytes(using: .utf8)
                if (leftByteLength > usedByteLength) {
                    usedPattern = pattern
                    usedByteLength = leftByteLength
                }
            }
            if usedPattern == nil {
                print("No pattern found")
                return nil
            }
            
            if usedPattern == "[[" {
                let suffixScanner = Scanner(string: String(suffix))
                suffixScanner.scanUpToString(usedPattern!)
                if let inner = LinkParser(scanner: suffixScanner).scan() {
                    print(usedPattern!, ": ", inner)
                    return usedPattern
                }
            }
            
            if usedPattern == "'''" {
                let suffixScanner = Scanner(string: String(suffix))
                suffixScanner.scanUpToString(usedPattern!)
                if let inner = TextFormatParser(scanner: suffixScanner).scan() {
                    print("Pattern(\(usedPattern!)) for", ": ", inner)
                    return usedPattern
                }
            }

            fatalError("Not implemented")
        }
    }

    func scan() -> (String?) {
        let headerParser = HeaderParser(scanner: scanner)
        if let first = headerParser.scan() {
            parsers.append(headerParser)
        }
        let fileParser = FileParser(scanner: scanner)
        if let first = fileParser.scan() {
            parsers.append(fileParser)
        }

        while true {
            guard let pattern = seek() else {
                parsers.append(PlainTextParser(scanner.string.substring(from: scanner.currentIndex)))
                return "TODO"
            }
            
            if pattern == "'''" {
                if let prefix = scanner.scanUpToString(pattern) {
                    parsers.append(PlainTextParser(prefix))
                }
                
                let textFormatParser = TextFormatParser(scanner: scanner)
                if let _ = textFormatParser.scan() {
                    parsers.append(textFormatParser)
                }
            } else if pattern == "[[" {
                if let prefix = scanner.scanUpToString(pattern) {
                    parsers.append(PlainTextParser(prefix))
                }
                
                let linkParser = LinkParser(scanner: scanner)
                if let _ = linkParser.scan() {
                    parsers.append(linkParser)
                }
            } else {
                fatalError("Not implemented")
            }
        // if true {
            // ok = false
            print("Next location: ", scanner.currentIndex)
            print("Suffix       : ", string[scanner.currentIndex...])
            print()
            /*if let plainText = scanner.scanUpToString("[[") {
                let linkParser = LinkParser(scanner: scanner)
                if let _ = linkParser.scan() {
                    ok = true
                    if !plainText.isEmpty {
                        parsers.append(PlainTextParser(plainText))
                    }
                    parsers.append(linkParser)
                }
            }*/
            /*if let plainText = scanner.scanUpToString("'''") {
                let textFormatParser = TextFormatParser(scanner: scanner)
                if let _ = textFormatParser.scan() {
                    ok = true
                    if !plainText.isEmpty {
                        parsers.append(PlainTextParser(plainText))
                    }
                    parsers.append(textFormatParser)
                }
            }*/
        }
   
        /*guard let left = scanner.scanUpToString("######IMPOSSIBLE######") else {
            return nil
        }*/
        
        // TODO: cookbook: location deprecated using currentIndex
        // TODO: substring deprecated
        let left = scanner.string.substring(from: scanner.currentIndex)
        return left
    }
}

if true {
    let parser = Parser(payload.parse.wikitext)
    parser.scan()
    // print(parser.scan())
    // parser.seek()
}
// print(parser.scanLeftCurlyBrace())
// print(parser.scanUpToRightCurlyBrace())
// print(parser.scanHeader())
// print(parser.scanFile())
// print(parser.scanNewline())

// let parser2 = Parser("\n")
// print(parser2.scanNewline())


// <body>: [<text>?<text_format>?<link>?]*
