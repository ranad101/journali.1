import SwiftUI

struct AddNewJournal: View {
    @State private var title: String // Initialize title based on input
    @State private var contentField: String // Initialize content based on input
    var onSave: (String, String) -> Void
    var onCancel: () -> Void

    init(title: String = "", content: String = "", onSave: @escaping (String, String) -> Void, onCancel: @escaping () -> Void) {
        _title = State(initialValue: title)
        _contentField = State(initialValue: content)
        self.onSave = onSave
        self.onCancel = onCancel
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 10) {
                TextField("Title", text: $title, axis: .vertical)
                    .font(.system(size: 34, weight: .bold))
                    .accentColor(.white)
                    .padding(.top, 40)
                    .padding([.leading, .trailing], 20)
                    .foregroundColor(.white)

                Text(Date.now.formatted(date: .numeric, time: .omitted))
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(Color.gray)
                    .padding([.leading, .trailing], 20)

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
                        onCancel()
                    }
                    .foregroundColor(Color.darklilac)
                    .font(.system(size: 16, weight: .regular))
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        onSave(title, contentField)
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
