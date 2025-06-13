import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState.Binding var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: Constants.spacing) {
                Image(systemName: Constants.searchIcon)
                    .padding(.leading, Constants.paddingSmall)
                
                TextField(Constants.searchLabel,
                          text: $text,
                          prompt: Text(isFocused ? Constants.searchPrompt : Constants.searchLabel))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($isFocused, equals: true)
                
                if !text.isEmpty {
                    Button(action: clearSearch, label: {
                        Image(Constants.clearIcon)
                            .resizable()
                            .scaledToFit()
                    })
                    .buttonStyle(.plain)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .padding(EdgeInsets(top: Constants.paddingLarge,
                                        leading: Constants.zeroPadding,
                                        bottom: Constants.paddingSmall,
                                        trailing: Constants.paddingMedium))
                }
            }
            .frame(maxHeight: Constants.maxHeight)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: Constants.cornerRadius))
            
            // filter
            if !isFocused && text.isEmpty {
                Button(action: {
                    // TODO: filter
                }, label: {
                    Image(Constants.filterIcon)
                })
                .buttonStyle(.plain)
                .padding(EdgeInsets(top: Constants.paddingSmall,
                                    leading: Constants.paddingMedium,
                                    bottom: Constants.paddingSmall,
                                    trailing: Constants.zeroPadding))
            }
        }
    }
    
    private func clearSearch() {
        text = ""
    }
}

// MARK: - Constants

fileprivate struct Constants {
    private init() {}
    
    static let searchIcon = "magnifyingglass"
    static let searchLabel = "Search"
    static let searchPrompt = "Type to search"
    static let clearIcon = "closeButton"
    static let filterIcon = "filterButton"
    
    static let spacing: CGFloat = 9
    static let zeroPadding: CGFloat = 0
    static let paddingSmall: CGFloat = 12
    static let paddingMedium: CGFloat = 15
    static let paddingLarge: CGFloat = 16
    static let cornerRadius: CGFloat = 16
    static let maxHeight: CGFloat = 48
    static let imageSize: CGFloat = 20
}

#Preview {
    @FocusState var isFocused: Bool
    
    VStack(spacing: 20) {
        Spacer()
        SearchBar(text: .constant("test"), isFocused: $isFocused)
        SearchBar(text: .constant(""), isFocused: $isFocused)
        Spacer()
    }
    .padding(.horizontal, 20)
    .background(Color.sky)
}
