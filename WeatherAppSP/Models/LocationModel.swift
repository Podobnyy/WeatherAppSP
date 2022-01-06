import Foundation

enum LocationModelKey: String {
    case latitude
    case longitude
    case name
    case temp
    case iconString
}

final class LocationModel: NSObject, NSCoding {

    let latitude: Double
    let longitude: Double

    let name: String?
    let temp: Double?
    let iconString: String?

    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude

        name = nil
        temp = nil
        iconString = nil
    }

    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(latitude, forKey: LocationModelKey.latitude.rawValue)
        coder.encode(longitude, forKey: LocationModelKey.longitude.rawValue)
        coder.encode(name, forKey: LocationModelKey.name.rawValue)
        coder.encode(temp, forKey: LocationModelKey.temp.rawValue)
        coder.encode(iconString, forKey: LocationModelKey.iconString.rawValue)
    }

    required init?(coder: NSCoder) {
        latitude = coder.decodeDouble(forKey: LocationModelKey.latitude.rawValue)
        longitude = coder.decodeDouble(forKey: LocationModelKey.longitude.rawValue)
        name = coder.decodeObject(forKey: LocationModelKey.name.rawValue) as? String
        temp = coder.decodeObject(forKey: LocationModelKey.temp.rawValue) as? Double
        iconString = coder.decodeObject(forKey: LocationModelKey.iconString.rawValue) as? String
    }
}
