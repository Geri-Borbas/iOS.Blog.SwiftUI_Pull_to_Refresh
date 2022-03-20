# SwiftUI Pull to Refresh
⬇️🔄 SwiftUI Pull to Refresh (for iOS 13 and iOS 14) condensed into a single modifier.


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


## Quick Start

Find [`OnRefreshModifier`] and [`RefreshableModifier`] in [`Refreshable`] folder. Find the exmaples below in the [`Examples`] folder. 


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[`OnRefreshModifier.swift`]: SwiftUI_Pull_to_Refresh/Refreshable/OnRefreshModifier.swift
[`RefreshableModifier.swift`]: SwiftUI_Pull_to_Refresh/Refreshable/RefreshableModifier.swift
[`Refreshable`]: SwiftUI_Pull_to_Refresh/Refreshable
[`Examples`]: SwiftUI_Pull_to_Refresh/Examples
[SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]: https://blog.eppz.eu/swiftui-pull-to-refresh/
