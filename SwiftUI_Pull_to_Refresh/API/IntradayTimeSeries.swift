//
//  IntradayTimeSeries.swift
//  SwiftUI_Pull_to_Refresh
//
//  Created by Geri Borbás on 18/09/2021.
//

import Foundation


/// From https://www.alphavantage.co/documentation/#intraday
struct IntradayTimeSeries: Decodable {
	
	let metaData: MetaData
	let timeSeries: TimeSeries
	
	enum CodingKeys: String, CodingKey {
		case metaData = "Meta Data"
		case timeSeries = "Time Series (1min)"
	}
	
	struct MetaData: Decodable {
		
		let information: String
		let symbol: String
		let lastRefreshed: String
		let interval: String
		let outputSize: String
		let timeZome: String
		
		enum CodingKeys: String, CodingKey {
			case information = "1. Information"
			case symbol = "2. Symbol"
			case lastRefreshed = "3. Last Refreshed"
			case interval = "4. Interval"
			case outputSize = "5. Output Size"
			case timeZome = "6. Time Zone"
		}
	}
	
	struct TimeSeries: Decodable {
		
		let items: [Item]
		
		private struct DynamicCodingKeys: CodingKey {
			
			var stringValue: String
			var intValue: Int?
			
			init?(stringValue: String) {
				self.stringValue = stringValue
			}
			
			init?(intValue: Int) {
				return nil
			}
		}
		
		init(items: [Item] = []) {
			self.items = items
		}
		
		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
			var items: [Item] = []
			for key in container.allKeys {
				if let key = DynamicCodingKeys(stringValue: key.stringValue) {
					let decodedItem = try container.decode(Item.self, forKey: key)
					items.append(decodedItem)
				}
			}
			self.items = items
		}
		
		struct Item: Decodable {
			
			let open: String
			let high: String
			let low: String
			let close: String
			let volume: String
			let time: String
			
			enum CodingKeys: String, CodingKey {
				case open = "1. open"
				case high = "2. high"
				case low = "3. low"
				case close = "4. close"
				case volume = "5. volume"
			}
			
			init(from decoder: Decoder) throws {
				let container = try decoder.container(keyedBy: CodingKeys.self)
				open = try container.decode(String.self, forKey: CodingKeys.open)
				high = try container.decode(String.self, forKey: CodingKeys.high)
				low = try container.decode(String.self, forKey: CodingKeys.low)
				close = try container.decode(String.self, forKey: CodingKeys.close)
				volume = try container.decode(String.self, forKey: CodingKeys.volume)
				time = container.codingPath.last?.stringValue ?? ""
			}
		}
	}
}


extension IntradayTimeSeries {
	
	static let empty: IntradayTimeSeries = IntradayTimeSeries(
		metaData: MetaData(
			information: "",
			symbol: "",
			lastRefreshed: "",
			interval: "",
			outputSize: "",
			timeZome: ""
		),
		timeSeries: TimeSeries()
	)
}
