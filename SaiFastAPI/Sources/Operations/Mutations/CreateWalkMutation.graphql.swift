// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class CreateWalkMutation: GraphQLMutation {
  public static let operationName: String = "CreateWalk"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation CreateWalk($input: CreateWalkInput!) { createWalk(input: $input) { __typename id startedAt finishedAt distance duration avgSpeed avgPace walkHistory { __typename history { __typename latitude longitude timestamp } } } }"#
    ))

  public var input: CreateWalkInput

  public init(input: CreateWalkInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("createWalk", CreateWalk.self, arguments: ["input": .variable("input")]),
    ] }

    public var createWalk: CreateWalk { __data["createWalk"] }

    /// CreateWalk
    ///
    /// Parent Type: `WalkType`
    public struct CreateWalk: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", String.self),
        .field("startedAt", SaiFastAPI.DateTimeType.self),
        .field("finishedAt", SaiFastAPI.DateTimeType.self),
        .field("distance", Double.self),
        .field("duration", Double.self),
        .field("avgSpeed", Double.self),
        .field("avgPace", Double.self),
        .field("walkHistory", WalkHistory.self),
      ] }

      public var id: String { __data["id"] }
      public var startedAt: SaiFastAPI.DateTimeType { __data["startedAt"] }
      public var finishedAt: SaiFastAPI.DateTimeType { __data["finishedAt"] }
      public var distance: Double { __data["distance"] }
      public var duration: Double { __data["duration"] }
      public var avgSpeed: Double { __data["avgSpeed"] }
      public var avgPace: Double { __data["avgPace"] }
      public var walkHistory: WalkHistory { __data["walkHistory"] }

      /// CreateWalk.WalkHistory
      ///
      /// Parent Type: `WalkHistoryType`
      public struct WalkHistory: SaiFastAPI.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkHistoryType }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("history", [History].self),
        ] }

        public var history: [History] { __data["history"] }

        /// CreateWalk.WalkHistory.History
        ///
        /// Parent Type: `WalkHistoryItemType`
        public struct History: SaiFastAPI.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkHistoryItemType }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("latitude", Double.self),
            .field("longitude", Double.self),
            .field("timestamp", SaiFastAPI.DateTimeType.self),
          ] }

          public var latitude: Double { __data["latitude"] }
          public var longitude: Double { __data["longitude"] }
          public var timestamp: SaiFastAPI.DateTimeType { __data["timestamp"] }
        }
      }
    }
  }
}
