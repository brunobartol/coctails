import SwiftUI

struct CocktailCardView: View {
    let imageUrl: String
    let title: String
    let ingredients: String
    
    var body: some View {
        HStack(spacing: 23) {
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url, content: {
                    $0.resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.21
                        }
                }, placeholder: {
                    Image(systemName: "book.fill")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * 0.21
                        }
                })
                .padding(.vertical, 20)
            }
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                Text(ingredients)
                    .lineLimit(1)
                Spacer()
            }
        }
        .alignmentGuide(.listRowSeparatorLeading) {
            $0[.leading]
        }
        .alignmentGuide(.listRowSeparatorTrailing) {
            $0[.trailing]
        }
    }
}

#Preview {
    List {
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Mojito", ingredients: "White rum, soda, mint, sugar, lime")
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Long Island", ingredients: "White rum, soda, mint, sugar, lime")
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Negroni", ingredients: "White rum, soda, mint, sugar, lime")
    }
    .listStyle(.plain)
}
