# SwiftUI Pull to Refresh
⇣ SwiftUI Pull to Refresh in 100 lines of code.


Complementary repository for article [**SwiftUI Pull to Refresh**] (in progress). See [`ContentView.swift`] for usage, and [`RefreshControl.swift`] for the source.

```Swift
struct ContentView: View {
    
    @State var isRefreshing: Bool = false
    
    var body: some View {
        List {
            RefreshControl(isRefreshing: $isRefreshing) {
                self.refresh()
            }
            ForEach(1...100, id: \.self) { eachRowIndex in
                Text("Row \(eachRowIndex)")
            }
                .opacity(isRefreshing ? 0.2 : 1.0)
        }
            .onAppear {
                self.isRefreshing = true
                self.refresh()
            }
    }
    
    func refresh() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.isRefreshing = false
        }
    }
}
```


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[`ContentView.swift`]: SwiftUI_Pull_to_Refresh/Views/ContentView.swift
[`RefreshControl.swift`]: SwiftUI_Pull_to_Refresh/Views/RefreshControl.swift

