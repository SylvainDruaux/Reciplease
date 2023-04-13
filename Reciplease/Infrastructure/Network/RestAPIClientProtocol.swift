//
//  RestAPIClientProtocol.swift
//  Reciplease
//
//  Created by Sylvain Druaux on 06/04/2023.
//

import Foundation

protocol RestAPIClientProtocol {
    func fetchData<T: Decodable>(route: APIRouter, completion: @escaping(Result<T, DataError>) -> Void)
    func fetchRawData(route: APIRouter, completion: @escaping(Result<Data, DataError>) -> Void)
}
