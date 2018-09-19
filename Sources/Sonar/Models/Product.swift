import Foundation

public struct Product: Decodable, Equatable {
    /// Internal apple's identifier
    public let appleIdentifier: Int
    /// The category of the product (e.g. 'Hardware').
    public let category: String
    /// The name of the product; useful to use as display name (e.g. 'iOS').
    public let name: String
    /// The description of the product; useful to show alonside the name (e.g. 'For issues with iOS utilities and features').
    public let description: String
    /// The child areas for this product
    public let areas: [Area]

    public static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.appleIdentifier == rhs.appleIdentifier
            && lhs.category == rhs.category
            && lhs.name == rhs.name
    }

    // MARK: - Decodable

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        let productContainer = try container.nestedContainer(keyedBy: ProductCodingKeys.self, forKey: .product)
        self.appleIdentifier = try productContainer.decode(Int.self, forKey: .appleIdentifier)
        self.name = try productContainer.decode(String.self, forKey: .name)
        self.description = try productContainer.decode(String.self, forKey: .description)
        self.areas = try productContainer.decode([Area].self, forKey: .areas)

        let sectionContainer = try container.nestedContainer(keyedBy: SectionCodingKeys.self, forKey: .product)
        self.category = try sectionContainer.decode(String.self, forKey: .section)
    }

    private enum CodingKeys: String, CodingKey {
        case product
        case section
    }

    private enum ProductCodingKeys: String, CodingKey {
        case appleIdentifier = "id"
        case name
        case description
        case areas
    }

    private enum SectionCodingKeys: String, CodingKey {
        case section
    }
}
