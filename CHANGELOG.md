# Changelog

* Doing

	+ Design

* 1.4.0

	+ Stable custom background blur composite
		+ Added `background(:)` to `SummaryView`
	+ Renamings  

* 1.3.6 - 1.3.7

	+ Created `CitiesViewModel`
	+ Created `citiesFrame` enviroment value
	+ Updated `List` mask
	+ Added cover to `WeatherView` background
		+ With backround offset alignment 

* 1.3.5

	+ `CityView`
		+ Extracted `TitleView`
		+ Extracted `SummaryView`
		+ Extracted `WeatherView` (with background mask)
		+ Extracted `AttributesView`
		+ Extracted `AttributeView`
	+ Hidden home indicator
	+ Renamings

* 1.3.1

	+ Extracted `AttributesView`
	+ Removed extra header padding
	+ Folder cleanup

* 1.3.0

	+ Secion header prototypes (padding, transparency)
		+ https://stackoverflow.com/questions/71526675/transparent-section-header
		+ https://stackoverflow.com/questions/71534756/remove-extra-padding-above-section-header

* 1.2.5 - 1.2.6

	+ Build attributes view (in weather header)

* 1.2.0

	+ Built city header, weather header
	+ `OpenWeather` date decoding update
	+ Added map asset(s)

* 1.1.2

	+ Added `Withable`
	+ SwiftLint updates

* 1.1.1

	+ Added `Lato` font

* 1.1.0

	+ Updated `CityViewModel` with async `fetch`
	+ Updated `CityView` to use `refreshable` modifier
	+ Excluded deprecated files from build

* 1.0.1

	+ Update README.md
	+ Added entirely unrelated `Marquee` prototype
		+ From https://twitter.com/Geri_Borbas/status/1504461022219968516

* 1.0.0

	+ Added `Refreshable` (with availability) 

* 0.12.0

	+ Added `AsyncAwaitView`

* 0.11.0
	
	+ Added `ScrollViewResolver` (deprecated)

* 0.10.0

	+ Created `RefreshModifier` implementation (according article update)
	+ Added `Prototype` views (according article update)
	+ Renaming, grouping

* 0.9.0

	+ Deployment target to iOS 13
	+ Added `Introspect`
	+ Added view to test nested scrollviews with `Introspect`

* 0.8.21 - 0.8.22

	+ Added `onScroll {}` modifier 

* 0.8.18 - 0.8.20

	+ Refactor view models, view states

* 0.8.10 - 0.8.16

	+ Refactor scroll view resolving, added `paging()` modifier

* 0.7.5 - 0.8.3

	+ Added AlphaVantage API module
	+ Added OpenWeather API module

* 0.6.7 - 0.7.2

	+ Prototype resolving `UIScrollView` instances by inspecting runtime view geometry

* 0.0.0 - 0.6.6

	+ Prototype attempting to resolve `UIScrollView` instances by inspecting runtime view hierarchy
