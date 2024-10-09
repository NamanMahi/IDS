//
//  CategoryModel.swift
//  IDSLogic
//
//  Created by Rajshree Jaiswal on 09/10/24.
//

import Foundation


struct Root: Codable {
    let data: DataContent?
}


struct DataContent: Codable {
    let contentFeed: ContentFeed?
}


struct ContentFeed: Codable {
    let feedName: String
    let feedResults: [FeedResult]?
}

struct FeedResult: Codable, Identifiable {
    let tags: [String]
    let artifact: Artifact?
    var id: Int { artifact?.id ?? Int(UUID().hashValue) }
    

    enum CodingKeys: String, CodingKey {
        case tags
        case artifact
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tags = try container.decode([String].self, forKey: .tags)
        artifact = try container.decode(Artifact.self, forKey: .artifact)


        guard !tags.isEmpty else {
            throw DecodingError.dataCorruptedError(forKey: .tags, in: container, debugDescription: "Tags cannot be empty")
        }
    }
}

struct Artifact: Codable {
    let id: Int?
    let contentPage: ContentPage?
    let slideShow: SlideShow?
    
    enum CodingKeys: String, CodingKey {
        case id
        case contentPage
        case slideShow
    }
}


struct ContentPage: Codable {
    let id: Int
    let title: String
    let bodyDisplay: String
    let brandedContentSponsor: String
    let brandedContentSponsorImg: String
    let brandedContentSponsorUrl: String
    let active: Bool
    let urlMappings: [UrlMapping]
}


struct UrlMapping: Codable {
    let incomingUrl: String
}


struct SlideShow: Codable {
    let id: Int
    let type: String
    let slides: [Slide]
}


struct Slide: Codable {
    let id: Int
    let headline: String
    let shortName: String
    let caption: String
    let order: Int
    let imageUrl: String
    let imageAltText: String
    let photoCredit: String
    let retailers: [Retailer]
}


struct Retailer: Codable {
    let productId: String
    let productLink: String
}
