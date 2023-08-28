// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalkQuery: GraphQLQuery {
  public static let operationName: String = "GetWalk"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalk($id: String!) { getWalk(id: $id) { __typename id startedAt finishedAt avgPace avgSpeed distance duration walkHistory { __typename history { __typename latitude longitude timestamp } } } }"#
    ))

  public var id: String

  public init(id: String) {
    self.id = id
  }

  public var __variables: Variables? { ["id": id] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getWalk", GetWalk?.self, arguments: ["id": .variable("id")]),
    ] }

    public var getWalk: GetWalk? { __data["getWalk"] }

    /// GetWalk
    ///
    /// Parent Type: `WalkType`
    public struct GetWalk: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkType }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("id", String.self),
        .field("startedAt", SaiFastAPI.DateTimeType.self),
        .field("finishedAt", SaiFastAPI.DateTimeType.self),
        .field("avgPace", Double.self),
        .field("avgSpeed", Double.self),
        .field("distance", Double.self),
        .field("duration", Double.self),
        .field("walkHistory", WalkHistory.self),
      ] }

      public var id: String { __data["id"] }
      public var startedAt: SaiFastAPI.DateTimeType { __data["startedAt"] }
      public var finishedAt: SaiFastAPI.DateTimeType { __data["finishedAt"] }
      public var avgPace: Double { __data["avgPace"] }
      public var avgSpeed: Double { __data["avgSpeed"] }
      public var distance: Double { __data["distance"] }
      public var duration: Double { __data["duration"] }
      public var walkHistory: WalkHistory { __data["walkHistory"] }

      /// GetWalk.WalkHistory
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

        /// GetWalk.WalkHistory.History
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
