import SwiftUI

struct CocktailCardView: View {
    let imageUrl: String
    let title: String
    let ingredients: String?
    
    var body: some View {
        HStack(spacing: Constants.spacing) {
            if let url = URL(string: imageUrl) {
                AsyncImage(url: url, content: {
                    $0.resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * Constants.imageRatio
                        }
                }, placeholder: {
                    Image(systemName: Constants.placeHolderImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
                        .containerRelativeFrame(.horizontal) { size, axis in
                            size * Constants.imageRatio
                        }
                })
                .padding(.vertical, Constants.padding)
            }
            
            VStack(alignment: .leading) {
                Spacer()
                Text(title)
                
                if let ingredients = ingredients {
                    Text(ingredients)
                        .lineLimit(Constants.lineLimit)
                }
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

// MARK: - Constants

fileprivate struct Constants {
    private init() {}
    
    static let placeHolderImage = "wineglass.fill"
    
    static let spacing: CGFloat = 23
    static let cornerRadius: CGFloat = 20
    static let imageRatio = 0.21
    static let padding: CGFloat = 20
    static let lineLimit = 1
}

#Preview {
    List {
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Mojito", ingredients: "White rum, soda, mint, sugar, lime")
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Long Island", ingredients: "White rum, soda, mint, sugar, lime")
        CocktailCardView(imageUrl: "https://www.thecocktaildb.com/images/media/drink/metwgh1606770327.jpg", title: "Negroni", ingredients: "White rum, soda, mint, sugar, lime")
    }
    .listStyle(.plain)
}
