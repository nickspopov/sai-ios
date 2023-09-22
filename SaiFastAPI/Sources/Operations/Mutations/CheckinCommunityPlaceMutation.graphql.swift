// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CheckinCommunityPlaceMutation: GraphQLMutation {
  public static let operationName: String = "CheckinCommunityPlace"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CheckinCommunityPlace($communityId: String!, $placeId: String!, $date: DateTimeType!) { checkinCommunityPlace(communityId: $communityId, placeId: $placeId, date: $date) { __typename id name owner { __typename id name } places { __typename id name lat lon } members { __typename user { __typename id name } lastCheckin { __typename date place { __typename id name } } } } }"#
    ))

  public var communityId: String
  public var placeId: String
  public var date: DateTimeType

  public init(
    communityId: String,
    placeId: String,
    date: DateTimeType
  ) {
    self.communityId = communityId
    self.placeId = placeId
    self.date = date
  }

  public var __variables: Variables? { [
    "communityId": communityId,
    "placeId": placeId,
    "date": date
  ] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("checkinCommunityPlace", CheckinCommunityPlace.self, arguments: [
        "communityId": .variable("communityId"),
        "placeId": .variable("placeId"),
        "date": .variable("date")
      ]),
    ] }

    public var checkinCommunityPlace: CheckinCommunityPlace { __data["checkinCommunityPlace"] }

    /// CheckinCommunityPlace
    ///
    /// Parent Type: `CommunityType`
    public struct CheckinCommunityPlace: SaiFastAPI.SelectionSet {
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

      /// CheckinCommunityPlace.Owner
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

      /// CheckinCommunityPlace.Place
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

      /// CheckinCommunityPlace.Member
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

        /// CheckinCommunityPlace.Member.User
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

        /// CheckinCommunityPlace.Member.LastCheckin
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

          /// CheckinCommunityPlace.Member.LastCheckin.Place
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
