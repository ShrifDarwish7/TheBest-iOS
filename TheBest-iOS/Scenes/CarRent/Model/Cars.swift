//
//  Cars.swift
//  TheBest-iOS
//
//  Created by Sherif Darwish on 8/30/20.
//  Copyright © 2020 Sherif Darwish. All rights reserved.
//

import Foundation

// MARK: - Cars
struct Cars: Codable {
    let cars: CarsClass

    enum CodingKeys: String, CodingKey {
        case cars = "Cars"
    }
}

// MARK: - CarsClass
struct CarsClass: Codable {
    let currentPage: Int
    let data: [Datum]
    let firstPageURL: String
    let from, lastPage: Int
    let lastPageURL: String
    let nextPageURL: String?
    let path: String
    let perPage: Int
    let prevPageURL: String?
    let to, total: Int
    

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
        
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name, createdAt, updatedAt: String
    let carsModels: [CarsModel]
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case carsModels = "cars_models"
        case image = "has_image"
    }
}

// MARK: - CarsModel
struct CarsModel: Codable {
    let id: Int
    let name: String
    let carFactoriesID: Int
    let createdAt, updatedAt: String
    let carslist: [Carslist]

    enum CodingKeys: String, CodingKey {
        case id, name
        case carFactoriesID = "car_factories_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case carslist
    }
}

// MARK: - Carslist
struct Carslist: Codable {
    let id: Int
    let name: String
    let carFactoriesID, carModelsID, releaseDate: Int
    let createdAt, updateAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case carFactoriesID = "car_factories_id"
        case carModelsID = "car_models_id"
        case releaseDate = "release_date"
        case createdAt = "created_at"
        case updateAt = "update_at"
    }
}
