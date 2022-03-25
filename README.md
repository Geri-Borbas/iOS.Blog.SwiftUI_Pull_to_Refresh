# SwiftUI Pull to Refresh
⬇️🔄 SwiftUI Pull to Refresh (for iOS 13 and iOS 14) condensed into a single modifier.

<p align="center"><img src="SwiftUI_Pull_to_Refresh/Documentation/SwiftUI_Pull_to Refresh_iOS_13_iOS_14.png" width="900"></p>

Complementary repository for article [SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]. With this extension you can **backport the iOS 15 refreshable modifier to iOS 13 and iOS 14**, and use the exact same code across the board.

```Swift
struct ContentView: View {
    
	...
    
    var body: some View {
        List {
            ...
        }
        .refreshable {
            await viewModel.fetch()
        }
    }
}
```

Alternatively, you can opt into the **closure-based API** below to spare using async await API.

```Swift
struct ContentView: View {
    
	...
    
    var body: some View {
        List {
            ...
        }
        .onRefresh { refreshControl in
            viewModel.fetch {
                refreshControl.endRefreshing()
            }
        }
    }
}
```


## Quick Start

Find [`OnRefreshModifier.swift`] and [`RefreshableModifier.swift`] in [`Refreshable`] folder (also add [Introspect] package). Find the exmaples above in the [`Examples`] folder. 


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[SwiftUI Pull to Refresh (for iOS 13 and iOS 14)]: https://blog.eppz.eu/swiftui-pull-to-refresh/
[Introspect]: https://github.com/siteline/SwiftUI-Introspect
[`OnRefreshModifier.swift`]: SwiftUI_Pull_to_Refresh/Refreshable/OnRefreshModifier.swift
[`RefreshableModifier.swift`]: SwiftUI_Pull_to_Refresh/Refreshable/RefreshableModifier.swift
[`Refreshable`]: SwiftUI_Pull_to_Refresh/Refreshable
[`Examples`]: SwiftUI_Pull_to_Refresh/Examples
