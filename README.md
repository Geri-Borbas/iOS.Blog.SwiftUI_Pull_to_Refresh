# SwiftUI Pull to Refresh
⇣ SwiftUI Pull to Refresh (for iOS 13 and iOS 14) condensed into a single modifier.


Complementary repository for article [**SwiftUI Pull to Refresh**] (in progress). See [`ContentView.swift`] for usage, and [`RefreshControlModifier.swift`] for the source. Designed to work with **multiple scroll views** on the same screen.

```Swift
struct ContentView: View {
	
	var body: some View {
		VStack {
			HStack {
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Left \(eachRowIndex)")
					}
				}
				.refreshControl { refreshControl in
					Network.refresh {
						refreshControl.endRefreshing()
					}
				}
				List {
					ForEach(1...100, id: \.self) { eachRowIndex in
						Text("Right \(eachRowIndex)")
					}
				}
				.refreshControl { refreshControl in
					Network.refresh {
						refreshControl.endRefreshing()
					}
				}
			}
		}
	}
}
```


## License

> Licensed under the [**MIT License**](https://en.wikipedia.org/wiki/MIT_License).

[`ContentView.swift`]: SwiftUI_Pull_to_Refresh/Views/ContentView.swift
[`RefreshControl.swift`]: SwiftUI_Pull_to_Refresh/Views/RefreshControl.swift

