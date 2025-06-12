import Combine
import Foundation

// MARK: - Cocktails list service protocol

protocol CocktailsListServiceProtocol {
    func fetchCocktailsList(_ query: String) -> AnyPublisher<CocktailsListResponseDTO, ApiError>
}

// MARK: - Implementation

final class CocktailsListService: CocktailsListServiceProtocol {
    func fetchCocktailsList(_ query: String) -> AnyPublisher<CocktailsListResponseDTO, ApiError> {
        guard let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(query)") else {
            return Future<CocktailsListResponseDTO, ApiError> { promise in
                return promise(.failure(ApiError.invalidQuery))
            }.eraseToAnyPublisher()
        }
        let request = URLRequest(url: url)
        return URLSession.DataTaskPublisher(request: request, session: .shared)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw ApiError.unknown
                }
                
                switch httpResponse.statusCode {
                case 200:
                    return data
                case 401:
                    throw ApiError.unauthorized
                case 404:
                    throw ApiError.notFound
                case 403:
                    throw ApiError.forbidden
                case 500..<600:
                    throw ApiError.internalServerError
                default:
                    throw ApiError.unknown
                }
            }
            .decode(type: CocktailsListResponseDTO.self, decoder: JSONDecoder())
            .mapError { error in
                if let error = error as? ApiError {
                    return error
                }
                
                if let decodingError = error as? DecodingError {
                    return ApiError.decodingError(message: decodingError.localizedDescription)
                }
                
                return ApiError.unknown
            }
            .eraseToAnyPublisher()
    }
}

// MARK: - Mock implementation for testing

final class MockCocktailsListService: CocktailsListServiceProtocol {
    private let mockCocktailsList = [
        CocktailDTO(id: "1",
                    name: "Mojito",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "2",
                    name: "Long Island",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "3",
                    name: "Negroni",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "4",
                    name: "Mojito",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "5",
                    name: "Long Island",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "6",
                    name: "Negroni",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "7",
                    name: "Mojito",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "8",
                    name: "Long Island",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime"),
        CocktailDTO(id: "9",
                    name: "Negroni",
                    category: "Cocktail",
                    alcoholic: "Alcoholic",
                    imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg",
                    ingredients: "White rum, soda, mint, sugar, lime")
    ]
    
    func fetchCocktailsList(_ query: String) -> AnyPublisher<CocktailsListResponseDTO, ApiError> {
        Future<CocktailsListResponseDTO, ApiError> { [weak self] promise in
            guard let self else { return }
            
            return promise(.success(CocktailsListResponseDTO(drinks: mockCocktailsList)))
        }.eraseToAnyPublisher()
    }
}
