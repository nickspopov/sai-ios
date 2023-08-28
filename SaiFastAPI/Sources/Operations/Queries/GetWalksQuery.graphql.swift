// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalksQuery: GraphQLQuery {
  public static let operationName: String = "GetWalks"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalks { getWalks { __typename id startedAt finishedAt avgPace avgSpeed distance duration walkHistory { __typename history { __typename latitude longitude timestamp } } } }"#
    ))

  public init() {}

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getWalks", [GetWalk].self),
    ] }

    public var getWalks: [GetWalk] { __data["getWalks"] }

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
        .field("startedAt", SaiFastAPI.DateTime.self),
        .field("finishedAt", SaiFastAPI.DateTime.self),
        .field("avgPace", Double.self),
        .field("avgSpeed", Double.self),
        .field("distance", Double.self),
        .field("duration", Double.self),
        .field("walkHistory", WalkHistory.self),
      ] }

      public var id: String { __data["id"] }
      public var startedAt: SaiFastAPI.DateTime { __data["startedAt"] }
      public var finishedAt: SaiFastAPI.DateTime { __data["finishedAt"] }
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
            .field("timestamp", SaiFastAPI.DateTime.self),
          ] }

          public var latitude: Double { __data["latitude"] }
          public var longitude: Double { __data["longitude"] }
          public var timestamp: SaiFastAPI.DateTime { __data["timestamp"] }
        }
      }
    }
  }
}
