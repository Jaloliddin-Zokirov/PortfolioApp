# PortfolioApp

SwiftUI asosida yaratilgan shaxsiy portfel ilovasi. Talaba / developer o'z ko'nikmalari, sertifikatlari va loyihalarini REST API orqali yuklab, foydalanuvchiga zamonaviy UI bilan ko'rsatadi.

## Asosiy imkoniyatlar
- `TabView` orqali Home, Certificates, Skills va Projects bo'limlariga tezkor o'tish
- API'dan sertifikat, ko'nikma va portfel loyihalarini asinxron yuklash
- SVG, PNG va GIF kabi turli formatdagi medialarni qo'llab-quvvatlash
- Splash/Welcome ekranidagi tipografik animatsiya va mahalliy GIF integratsiyasi

## Texnologiyalar va kutubxonalar
- **SwiftUI** – UI qatlamlari, `NavigationView`, `ScrollView`, `LazyVGrid`, `List`
- **Combine** – `@Published` xususiyatlari bilan reaktiv holat boshqaruvi
- **Swift Concurrency (async/await)** – `URLSession` asosida asinxron network chaqiriqlar
- **SVGKit** – `RemoteImage` komponentida SVG va raster rasmlarni dekodlash
- **WebKit (WKWebView)** – `GIFView` orqali mahalliy GIF ko'rsatish
- **Assets Catalog** – `Coding.gif` dataset'i va ikonalar

## Loyiha tuzilmasi
```
PortfolioApp/
├── PortfolioAppApp.swift    // App entry point va Welcome ekranini boshqaradi
├── ContentView.swift        // TabView bazaviy navigatsiya
├── Config.swift             // API host sozlamasi
├── Models/                  // Codable domen modellari
├── Networking/              // APIClient va Endpoints enum
├── ViewModels/              // MVVM uchun ObservableObject VM'lar
├── Views/                   // Ekranlar va UI komponentlari
│   └── Components/          // RemoteImage, GIFView, FeatureTag va h.k.
└── Assets.xcassets/         // AppIcon, ranglar, GIF dataset
```

## Arxitektura va oqim
- **MVVM**: Har ekran (`CertificatesView`, `SkillsView`, `PortfoliosView`) o'ziga mos `ObservableObject` ViewModelga ulangan. `@StateObject` bilan hayot sikli boshqariladi.
- **Network qatlami**: `APIClient.shared` `GET` so'rovlarini jo'natib, muvaffaqiyatli javoblarni `JSONDecoder` orqali Codable modellarga ajratadi. `Endpoints` enum yo'llarni markazlashtiradi.
- **WelcomeView**: Ilova ishga tushganda tipografik “typewriter” animatsiyasi va ikonlar bouncelari bilan foydalanuvchini kutib oladi; animatsiya tugagach asosiy `ContentView`'ga o'tadi.
- **Media**: 
  - `RemoteImage` URL'dan rasm yuklab, MIME tipiga qarab `SVGKit` yoki `UIImage` bilan render qiladi.
  - `GIFView` mahalliy `.gif` faylni `WKWebView` orqali autopley qiladi.

## API integratsiyasi
- **Bazaviy URL**: `Config.swift`'dagi `AppEnv.host` (masalan `https://api.jaloliddindev.uz`) + `API.base` (`/main`)
- **Endpointlar**:
  - `/serticates/` → `[Certificate]` (`id`, `img`)
  - `/skills/` → `[Skill]` (`id`, `title`, `description`, `image`)
  - `/portfolios/` → `[PortfolioItem]` (`title`, `description`, `features`, `tech_stack`, `image`, `link`, `github_link`, va h.k.)
- Har bir ViewModel `task { await vm.load() }` orqali ekranni ochilganda ma'lumotni avtomatik yangilaydi.

## Ishga tushirish bo'yicha ko'rsatmalar
1. Reponi klonlab, `PortfolioApp.xcodeproj` faylini Xcode'da oching.
2. Rivojlantirish server manzilini `Config.swift` ichidagi `AppEnv.host` orqali sozlang (lokal test uchun Mac IP manzilini kiriting).
3. SVG fayllar bilan ishlash uchun SPM orqali `SVGKit` qo'shilganligiga ishonch hosil qiling (`File > Add Packages...`).
4. `PortfolioAppApp` targetini tanlab, iOS 17+ simulyatori yoki real qurilmada build/run qiling.

## Qo'shimcha eslatmalar
- Dizayn qorong'i fon (black) ustida gradient matnlar bilan ishlangan; kerak bo'lsa `HomeView`'dagi `Color.black` fonini light theme uchun moslang.
- `GradientText.swift` fayli hozircha bo'sh, kelajakda gradient matn uchun alohida komponent tayyorlashga mo'ljallangan.
- Agar API xatolik qaytarsa, har bir ekran `Retry` tugmasi orqali qayta so'rov yuboradi.
