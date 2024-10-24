import SwiftUI

struct AddNewJournal: View {
    @State private var title: String = "" // Local state for the journal title
    @State private var contentField: String = "" // Local state for the journal content
    var onSave: (String, String) -> Void // Pass title and content back on save
    var onCancel: () -> Void

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                // Journal Title field
                TextField("Title", text: $title, axis: .vertical)
                    .font(.system(size: 34, weight: .bold))
                    .accentColor(.white)
                    .padding(.top, 40)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.white)
                
                // Current Date
                Text(Date.now.formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.gray)
                    .padding([.leading, .trailing], 20)

                // Journal Content field
                TextField("Type your journal...", text: $contentField, axis: .vertical)
                    .font(.system(size: 20))
                    .padding(.top, 10)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.white)

                Spacer()
            }
            .background(Color("sheet"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        onCancel() // Call onCancel when Cancel is tapped
                    }
                    .foregroundColor(Color.darklilac)
                    .font(.system(size: 16, weight: .regular))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(title, contentField) // Call onSave with the current title and content
                    }
                    .foregroundColor(Color.darklilac)
                    .font(.system(size: 16, weight: .bold))
                }
            }
        }
    }
}

#Preview {
    AddNewJournal(
        onSave: { _, _ in },
        onCancel: {}
    )
}
