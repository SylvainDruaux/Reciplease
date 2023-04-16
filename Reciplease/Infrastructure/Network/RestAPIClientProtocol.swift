//
//  RestAPIClientProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol RestAPIClientProtocol {
    func fetchData<T: Decodable>(route: APIRouter) async throws -> T
    func fetchRawData(route: APIRouter) async throws -> Data
}
