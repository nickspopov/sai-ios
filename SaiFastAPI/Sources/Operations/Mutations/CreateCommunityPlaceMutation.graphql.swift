// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateCommunityPlaceMutation: GraphQLMutation {
  public static let operationName: String = "CreateCommunityPlace"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateCommunityPlace($input: CommunityPlaceInput!) { createCommunityPlace(input: $input) { __typename id name owner { __typename id name } places { __typename id name lat lon } members { __typename user { __typename id name } lastCheckin { __typename date place { __typename id name } } } } }"#
    ))

  public var input: CommunityPlaceInput

  public init(input: CommunityPlaceInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createCommunityPlace", CreateCommunityPlace.self, arguments: ["input": .variable("input")]),
    ] }

    public var createCommunityPlace: CreateCommunityPlace { __data["createCommunityPlace"] }

    /// CreateCommunityPlace
    ///
    /// Parent Type: `CommunityType`
    public struct CreateCommunityPlace: SaiFastAPI.SelectionSet {
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

      /// CreateCommunityPlace.Owner
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

      /// CreateCommunityPlace.Place
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

      /// CreateCommunityPlace.Member
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

        /// CreateCommunityPlace.Member.User
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

        /// CreateCommunityPlace.Member.LastCheckin
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

          /// CreateCommunityPlace.Member.LastCheckin.Place
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
