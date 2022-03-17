# SwiftUI Pull to Refresh
⇣ SwiftUI Pull to Refresh (for iOS 13 and iOS 14) condensed into a single modifier.


Complementary repository for article [SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]. With this extension you can **backport the iOS 15 refreshable modifier to iOS 13 and iOS 14**, and use the exact same code across the board.

```Swift
struct ContentView: View {
    
    var body: some View {
        List {
            ...
        }
        .refreshable {
            await Network.load()
        }
    }
}
```

Alternatively, you can opt into the **closure-based API** below to spare using async await API.

```Swift
struct ContentView: View {
    
    var body: some View {
        List {
            ...
        }
        .onRefresh { refreshControl in
            Network.load {
                refreshControl.endRefreshing()
            }
        }
    }
}
```

See more in the complementary article at [SwiftUI Pull to Refresh (for iOS 13 and iOS 14)].


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[`RefreshModifierView.swift`]: SwiftUI_Pull_to_Refresh/Prototypes/RefreshModifierView.swift
[`RefreshModifier.swift`]: SwiftUI_Pull_to_Refresh/RefreshModifier/RefreshModifier.swift
[SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]: https://blog.eppz.eu/swiftui-pull-to-refresh/
