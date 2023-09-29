// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CommunityPlaceFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CommunityPlaceFragment on CommunityPlaceType { __typename id name lat lon }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("name", String.self),
    .field("lat", Double.self),
    .field("lon", Double.self),
  ] }

  public var id: String { __data["id"] }
  public var name: String { __data["name"] }
  public var lat: Double { __data["lat"] }
  public var lon: Double { __data["lon"] }
}
