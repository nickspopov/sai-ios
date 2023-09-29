// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct CommunityFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment CommunityFragment on CommunityType { __typename id name owner { __typename ...UserFragment } places { __typename ...CommunityPlaceFragment } members { __typename ...CommunityMemberFragment } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("name", String.self),
    .field("owner", Owner.self),
    .field("places", [Place].self),
    .field("members", [Member].self),
  ] }

  public var id: String { __data["id"] }
  public var name: String { __data["name"] }
  public var owner: Owner { __data["owner"] }
  public var places: [Place] { __data["places"] }
  public var members: [Member] { __data["members"] }

  /// Owner
  ///
  /// Parent Type: `UserType`
  public struct Owner: SaiFastAPI.SelectionSet {
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

    /// Owner.Dog
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

  /// Member
  ///
  /// Parent Type: `CommunityMemberType`
  public struct Member: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(CommunityMemberFragment.self),
    ] }

    public var user: User { __data["user"] }
    public var lastCheckin: LastCheckin? { __data["lastCheckin"] }

    public struct Fragments: FragmentContainer {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public var communityMemberFragment: CommunityMemberFragment { _toFragment() }
    }

    /// Member.User
    ///
    /// Parent Type: `UserType`
    public struct User: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }

      public var id: String { __data["id"] }
      public var name: String { __data["name"] }
      public var dogs: [Dog] { __data["dogs"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var userFragment: UserFragment { _toFragment() }
      }

      /// Member.User.Dog
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

    /// Member.LastCheckin
    ///
    /// Parent Type: `CommunityMemberLastCheckinType`
    public struct LastCheckin: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityMemberLastCheckinType }

      public var date: SaiFastAPI.DateTimeType { __data["date"] }
      public var place: Place { __data["place"] }

      public struct Fragments: FragmentContainer {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public var communityMemberLastCheckinFragment: CommunityMemberLastCheckinFragment { _toFragment() }
      }

      /// Member.LastCheckin.Place
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
}
