// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetCommunitiesQuery: GraphQLQuery {
  public static let operationName: String = "GetCommunities"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetCommunities { getCommunities { __typename id name owner { __typename id name } places { __typename id name lat lon } members { __typename user { __typename id name } lastCheckin { __typename date place { __typename id name } } } } }"#
    ))

  public init() {}

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getCommunities", [GetCommunity].self),
    ] }

    public var getCommunities: [GetCommunity] { __data["getCommunities"] }

    /// GetCommunity
    ///
    /// Parent Type: `CommunityType`
    public struct GetCommunity: SaiFastAPI.SelectionSet {
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

      /// GetCommunity.Owner
      ///
      /// Parent Type: `UserType`
      public struct Owner: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", String.self),
          .field("name", String.self),
        ] }

        public var id: String { __data["id"] }
        public var name: String { __data["name"] }
      }

      /// GetCommunity.Place
      ///
      /// Parent Type: `CommunityPlaceType`
      public struct Place: SaiFastAPI.SelectionSet {
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

      /// GetCommunity.Member
      ///
      /// Parent Type: `CommunityMemberType`
      public struct Member: SaiFastAPI.SelectionSet {
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

        /// GetCommunity.Member.User
        ///
        /// Parent Type: `UserType`
        public struct User: SaiFastAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", String.self),
            .field("name", String.self),
          ] }

          public var id: String { __data["id"] }
          public var name: String { __data["name"] }
        }

        /// GetCommunity.Member.LastCheckin
        ///
        /// Parent Type: `CommunityMemberLastCheckinType`
        public struct LastCheckin: SaiFastAPI.SelectionSet {
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

          /// GetCommunity.Member.LastCheckin.Place
          ///
          /// Parent Type: `CommunityPlaceType`
          public struct Place: SaiFastAPI.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.CommunityPlaceType }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", String.self),
              .field("name", String.self),
            ] }

            public var id: String { __data["id"] }
            public var name: String { __data["name"] }
          }
        }
      }
    }
  }
}
