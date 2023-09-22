// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CommunityPlaceInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    communityId: String,
    name: String,
    lat: Double,
    lon: Double
  ) {
    __data = InputDict([
      "communityId": communityId,
      "name": name,
      "lat": lat,
      "lon": lon
    ])
  }

  public var communityId: String {
    get { __data["communityId"] }
    set { __data["communityId"] = newValue }
  }

  public var name: String {
    get { __data["name"] }
    set { __data["name"] = newValue }
  }

  public var lat: Double {
    get { __data["lat"] }
    set { __data["lat"] = newValue }
  }

  public var lon: Double {
    get { __data["lon"] }
    set { __data["lon"] = newValue }
  }
}
