import Foundation

struct File {
    
    enum FileError: Error, CustomStringConvertible {
        case missingFile(_ filename: String)
        var recovery: String {
            switch self {
            case .missingFile(let filename):
                return "Check phase “Copy Files” for current target contains \(filename)."
            }
        }
        var description: String {
            recovery
        }
    }
    
    private var filename: String
    
    init(filename: String) {
        self.filename = filename
    }
    
    func data() throws -> Data {
        let fileComponents = filename.split(separator: ".")
        guard let name = fileComponents.first.flatMap({ String($0) }),
              let ext = fileComponents.last.flatMap({ String($0) }),
              let url = Bundle.module.url(forResource: name, withExtension: ext) else {
            throw FileError.missingFile(filename)
        }
        return try Data(contentsOf: url)
    }
}
