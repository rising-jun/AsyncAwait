//
//  DoodleRepository.swift
//  Asyncawait
//
//  Created by 김동준 on 2022/07/26.
//

import Foundation

final class DoodleRepository {
    
    func fetchDoodles() async throws -> [DoodleDTO] {
        guard let url = URL(string: "https://public.codesquad.kr/jk/doodle.json") else { throw NetworkError.invailUrl }
        let result = try await URLSession.shared.data(from: url)
        return try jsonDecode(data: result.0, decodeType: [DoodleDTO].self)
    }
    
    func fetchImages(url: String) async throws -> Data {
        guard let url = URL(string: url) else { return Data() }
        return try await URLSession.shared.data(from: url).0
    }
    
    func jsonDecode<T: Decodable>(data: Data, decodeType: T.Type) throws -> T {
        guard let decodeEntity = try? JSONDecoder().decode(decodeType.self, from: data) else {
            throw NetworkError.parsingError
        }
        return decodeEntity
    }
}

enum NetworkError: Error{
    case invailUrl
    case parsingError
}
