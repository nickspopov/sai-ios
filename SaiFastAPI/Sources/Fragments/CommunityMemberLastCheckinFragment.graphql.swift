// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CommunityMemberLastCheckinFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CommunityMemberLastCheckinFragment on CommunityMemberLastCheckinType { __typename date place { __typename ...CommunityPlaceFragment } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberLastCheckinType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("date", SaiFastAPI.DateTimeType.self),
    .field("place", Place.self),
  ] }

  public var date: SaiFastAPI.DateTimeType { __data["date"] }
  public var place: Place { __data["place"] }

  /// Place
  ///
  /// Parent Type: `CommunityPlaceType`
  public struct Place: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CommunityPlaceFragment.self),
    ] }

    public var id: String { __data["id"] }
    public var name: String { __data["name"] }
    public var lat: Double { __data["lat"] }
    public var lon: Double { __data["lon"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var communityPlaceFragment: CommunityPlaceFragment { _toFragment() }
    }
  }
}
