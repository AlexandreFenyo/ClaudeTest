import SwiftUI
import WebKit

struct ToolsView: View {
    @State private var showURLInput = false
    @State private var showWebView = false
    @State private var urlString = ""
    @State private var loadedURL: URL?

    var body: some View {
        NavigationView {
            VStack {
                Button("Load HTML") {
                    urlString = ""
                    showURLInput = true
                }
                .buttonStyle(.borderedProminent)
            }
            .navigationTitle("Tools")
            .sheet(isPresented: $showURLInput) {
                URLInputView(urlString: $urlString, onOK: {
                    if let url = URL(string: urlString) {
                        loadedURL = url
                        showURLInput = false
                        showWebView = true
                    }
                }, onCancel: {
                    showURLInput = false
                })
            }
            .fullScreenCover(isPresented: $showWebView) {
                WebContentView(url: loadedURL, onClose: { showWebView = false })
            }
        }
    }
}

struct URLInputView: View {
    @Binding var urlString: String
    let onOK: () -> Void
    let onCancel: () -> Void

    @FocusState private var isFieldFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("URL")) {
                    TextField("https://example.com", text: $urlString)
                        .keyboardType(.URL)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .focused($isFieldFocused)
                }
            }
            .navigationTitle("Load HTML")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { onCancel() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("OK") { onOK() }
                        .disabled(urlString.isEmpty || URL(string: urlString) == nil)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                isFieldFocused = true
            }
        }
    }
}

struct WebContentView: View {
    let url: URL?
    let onClose: () -> Void

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(url?.absoluteString ?? "")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Spacer()
                Button("Fermer") { onClose() }
                    .padding(.leading)
            }
            .padding()
            .background(Color(.systemBackground))
            .overlay(Divider(), alignment: .bottom)

            if let url = url {
                WKWebViewRepresentable(url: url)
            }
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct WKWebViewRepresentable: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}
