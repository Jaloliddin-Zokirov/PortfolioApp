import SwiftUI
import SVGKit

struct RemoteImage: View {
    let urlString: String?
    let width: CGFloat?
    let height: CGFloat?
    let corner: CGFloat
    @State private var uiImage: UIImage?

    var body: some View {
        ZStack {
            if let img = uiImage {
                Image(uiImage: img)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: height)
                    .clipped()
                    .cornerRadius(corner)
            } else {
                ProgressView()
                    .frame(width: width, height: height)
                    .onAppear(perform: load)
            }
        }
    }

    private func load() {
        guard let s = urlString, let url = URL(string: s) else { return }

        // Yuklab olishni fon oqimida bajarish
        DispatchQueue.global(qos: .background).async {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"

            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data,
                      let http = response as? HTTPURLResponse,
                      http.statusCode == 200 else { return }

                // MIME turini tekshiramiz
                let mime = http.mimeType ?? ""

                if mime.contains("svg") {
                    if let svg = SVGKImage(data: data) {
                        DispatchQueue.main.async {
                            uiImage = svg.uiImage
                        }
                    }
                } else if let img = UIImage(data: data) {
                    DispatchQueue.main.async {
                        uiImage = img
                    }
                } else {
                    print("❌ Noma’lum rasm formati:", mime)
                }
            }.resume()
        }
    }
}
