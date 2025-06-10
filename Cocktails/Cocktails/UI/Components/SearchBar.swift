import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            HStack(spacing: 9) {
                Image(systemName: "magnifyingglass")
                    .padding(.leading, 12)
                
                TextField("Search",
                          text: $text,
                          prompt: Text(isFocused ? "Type to search" : "Search"))
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .focused($isFocused)
                
                if !text.isEmpty {
                    Button(action: clearSearch, label: {
                        Image("closeButton")
                            .resizable()
                            .scaledToFit()
                    })
                    .buttonStyle(.plain)
                    .frame(width: 20, height: 20)
                    .padding(EdgeInsets(top: 16,
                                        leading: 0,
                                        bottom: 12,
                                        trailing: 15))
                }
            }
            .frame(maxHeight: 48)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            
            // filter
            if text.isEmpty {
                Button(action: {
                    // TODO: filter
                }, label: {
                    Image("filterButton")
                })
                .buttonStyle(.plain)
                .padding(EdgeInsets(top: 12,
                                    leading: 15,
                                    bottom: 12,
                                    trailing: 0))
            }
        }
    }
    
    private func clearSearch() {
        text = ""
    }
}

#Preview {
    VStack(spacing: 20) {
        Spacer()
        SearchBar(text: .constant("test"))
        SearchBar(text: .constant(""))
        Spacer()
    }
    .padding(.horizontal, 20)
    .background(Color.sky)
}
