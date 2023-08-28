// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateWalkHistoryItemType: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    latitude: Double,
    longitude: Double,
    timestamp: DateTime
  ) {
    __data = InputDict([
      "latitude": latitude,
      "longitude": longitude,
      "timestamp": timestamp
    ])
  }

  public var latitude: Double {
    get { __data["latitude"] }
    set { __data["latitude"] = newValue }
  }

  public var longitude: Double {
    get { __data["longitude"] }
    set { __data["longitude"] = newValue }
  }

  public var timestamp: DateTime {
    get { __data["timestamp"] }
    set { __data["timestamp"] = newValue }
  }
}
