# SwiftUI Pull to Refresh
⇣ SwiftUI Pull to Refresh (for iOS 13 and iOS 14) condensed into a single modifier.


Complementary repository for article [**SwiftUI Pull to Refresh**] (in progress). See [`RefreshModifierView.swift`] for usage, and [`RefreshModifier.swift`] for the source.

```Swift
struct ConventView: View {
	
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


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[`RefreshModifierView.swift`]: SwiftUI_Pull_to_Refresh/Prototypes/RefreshModifierView.swift
[`RefreshModifier.swift`]: SwiftUI_Pull_to_Refresh/RefreshModifier/RefreshModifier.swift
