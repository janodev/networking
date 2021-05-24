import Foundation

/// Parameters for a query to the Random User API.
struct Parameters {
    
    /// Fields to exclude from the response.
    let exclude: [Field]?
    
    /// Format of the results (JSON, XML, etc.).
    let format: Format?
    
    /// User gender.
    let gender: Gender?
    
    /// Fields to include in the response.
    let include: [Field]?
    
    /// User nationality.
    let nationalities: [Nationality]?
    
    /// Number of users to return.
    let results: Results?
    
    /// Other options.
    let options: Set<Option>?
    
    /// Seed.
    let seed: String?
    
    init(exclude: [Field]? = nil,
         format: Format? = nil,
         gender: Gender? = nil,
         include: [Field]? = nil,
         nationalities: [Nationality]? = nil,
         results: Results? = nil,
         options: Set<Option>? = nil,
         seed: String? = nil) {
        
        self.exclude = exclude
        self.format = format
        self.gender = gender
        self.include = include
        self.nationalities = nationalities
        self.results = results
        self.options = options
        self.seed = seed
    }
}
