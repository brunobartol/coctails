struct CocktailModel: Identifiable {
    let id: String
    let imageUrl: String
    let title: String
    let ingredients: String?
}

extension CocktailModel {
    init(from dto: CocktailDTO) {
        self.id = dto.id
        self.imageUrl = dto.imageUrl
        self.title = dto.name
        self.ingredients = dto.ingredients
    }
}
