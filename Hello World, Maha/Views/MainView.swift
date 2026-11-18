import SwiftUI
import SwiftData

struct MainView: View {
    @State private var viewModel = JournalViewModel()
    @State private var showEditor = false
    @State private var showDeleteAlert = false
    @State private var journalToDelete: Journal?
    @State private var journalToEdit: Journal?
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            ZStack {
                // الخلفية
                Color.appBackground
                    .ignoresSafeArea()

                // المحتوى: فاضي، أو ما فيه نتائج، أو الكروت
                if viewModel.journals.isEmpty {
                    EmptyStateView()
                } else if viewModel.displayedJournals.isEmpty {
                    ContentUnavailableView.search(text: viewModel.searchText)
                } else {
                    List(viewModel.displayedJournals) { journal in
                        JournalCard(journal: journal, viewModel: viewModel)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .onTapGesture {
                                journalToEdit = journal
                            }
                            // السحب وزر الحذف
                            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                                Button("Delete", systemImage: "trash.fill") {
                                    journalToDelete = journal
                                    showDeleteAlert = true
                                }
                                .tint(Color.destructive)
                            }
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("Journal")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Button("Sort by Bookmark") {
                            withAnimation {
                                viewModel.sortOption = .bookmark
                            }
                        }
                        Button("Sort by Entry Date") {
                            withAnimation {
                                viewModel.sortOption = .date
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "line.3.horizontal.decrease")
                    }
                    Button("Add", systemImage: "plus") {
                        showEditor = true
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                SearchBar(text: $viewModel.searchText)
                    .padding(.horizontal, 20)
            }
            .sheet(isPresented: $showEditor) {
                JournalEditorView(viewModel: viewModel)
                    .presentationDragIndicator(.visible)
            }
            .sheet(item: $journalToEdit) { journal in
                JournalEditorView(viewModel: viewModel, journalToEdit: journal)
                    .presentationDragIndicator(.visible)
            }
            // رسالة تأكيد الحذف
            .alert("Delete Journal?", isPresented: $showDeleteAlert) {
                Button("Cancel", role: .cancel) { }
                Button("Delete", role: .destructive) {
                    if let journal = journalToDelete {
                        viewModel.deleteJournal(journal: journal)
                    }
                }
            } message: {
                Text("Are you sure you want to delete this journal?")
            }
        }
        .preferredColorScheme(.dark)
        // نعطي الجرسون القلم أول ما تظهر الصفحة
        .onAppear {
            viewModel.setup(modelContext: modelContext)
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: Journal.self, inMemory: true)
}
