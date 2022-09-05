//
//  StationView.swift
//  citibike-ios
//
//  Created by Harrison Borges on 8/27/22.
//

import SwiftUI


struct BikeListView: View {
	var bikes: [Bike]
	var displayableBikes: [Bike] {
		if bikes.count > 5 {
			return Array(bikes[...4])
		}

		return bikes
	}
	
	var body: some View {
		VStack(alignment: .leading) {
			ForEach(displayableBikes) { bike in
				HStack {
					Image(systemName: bike.batteryIcon)
						.foregroundColor(batteryColor(bike: bike))
						.font(.callout)
					Text(bike.range)
						.font(.callout)
				}
			}
		}
	}

	func batteryColor(bike: Bike) -> Color {
		switch bike.batteryIcon {
			case "battery.25":
				return Color.bikeBatteryLow
			case "battery.100":
				return Color.primaryGreen
			default:
				return Color("Foreground")
		}
	}
}

struct BikeCount: View {
	var count: String
	var body: some View {
		Text(count)
			.padding(10)
			.foregroundColor(Color.background)
			.background(
				Circle()
					.fill(Color.foreground)
			)
	}
}

struct StationCellView: View {
	var station: Station
	var stationRoute: StationRoute?
	
	var body: some View {
		VStack(alignment: .leading) {
			VStack(alignment: .leading) {
				HStack {
					BikeCount(count: station.bikeCount)
						.padding(.trailing, 6)
						.frame(maxHeight: .infinity)

					VStack(alignment: .leading) {
						Text(station.name)
							.font(.title3)
							.fontWeight(.bold)

						if let travelTime = stationRoute?.travelTimeInMinutes {
							Text("\(travelTime) min walk")
								.font(.body)
								.italic()
								.foregroundColor(Color.secondaryText)
						}
					}
				}

				BikeListView(bikes: station.bikes)
			}
		}
	}
}

