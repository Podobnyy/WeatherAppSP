import Foundation

struct LocationModel {

    let latitude: Double
    let longitude: Double

    let name: String?   // TODO: geocode APPLE  https://developer.apple.com/documentation/corelocation/clgeocoder
    let temp: Double?
    let iconString: String?

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude

        name = nil
        temp = nil
        iconString = nil
    }
}
