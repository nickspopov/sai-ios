// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CommunityMemberFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CommunityMemberFragment on CommunityMemberType { __typename user { __typename ...UserFragment } lastCheckin { __typename ...CommunityMemberLastCheckinFragment } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("user", User.self),
    .field("lastCheckin", LastCheckin?.self),
  ] }

  public var user: User { __data["user"] }
  public var lastCheckin: LastCheckin? { __data["lastCheckin"] }

  /// User
  ///
  /// Parent Type: `UserType`
  public struct User: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(UserFragment.self),
    ] }

    public var id: String { __data["id"] }
    public var name: String { __data["name"] }
    public var dogs: [Dog] { __data["dogs"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var userFragment: UserFragment { _toFragment() }
    }

    /// User.Dog
    ///
    /// Parent Type: `DogType`
    public struct Dog: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.DogType }

      public var id: String { __data["id"] }
      public var name: String { __data["name"] }
      public var breed: String { __data["breed"] }
      public var dateOfBirth: SaiFastAPI.DateTimeType { __data["dateOfBirth"] }
      public var sex: String { __data["sex"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var dogFragment: DogFragment { _toFragment() }
      }
    }
  }

  /// LastCheckin
  ///
  /// Parent Type: `CommunityMemberLastCheckinType`
  public struct LastCheckin: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberLastCheckinType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CommunityMemberLastCheckinFragment.self),
    ] }

    public var date: SaiFastAPI.DateTimeType { __data["date"] }
    public var place: Place { __data["place"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var communityMemberLastCheckinFragment: CommunityMemberLastCheckinFragment { _toFragment() }
    }

    /// LastCheckin.Place
    ///
    /// Parent Type: `CommunityPlaceType`
    public struct Place: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }

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
}
