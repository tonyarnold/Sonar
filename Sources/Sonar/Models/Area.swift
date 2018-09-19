public struct Area: Decodable, Equatable {
    /// Internal apple's identifier
    public let appleIdentifier: Int
    /// The name of the area; useful to use as display name (e.g. 'App Switcher').
    public let name: String
    /// Indicates if the area is active.
    public let isActive: Bool

    public static func == (lhs: Area, rhs: Area) -> Bool {
        return lhs.appleIdentifier == rhs.appleIdentifier && lhs.name == rhs.name
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.appleIdentifier = try container.decode(Int.self, forKey: .appleIdentifier)
        self.isActive = try container.decode(Bool.self, forKey: .isActive)
        self.name = try container.decode(String.self, forKey: .name)
    }

    private enum CodingKeys: String, CodingKey {
        case appleIdentifier = "id"
        case isActive
        case name
    }
}
