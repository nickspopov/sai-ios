// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalkDayActivityQuery: GraphQLQuery {
  public static let operationName: String = "GetWalkDayActivity"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalkDayActivity($date: DateTime!) { getWalkDayActivity(date: $date) { __typename totalDistance totalDuration avgSpeed avgPace date } }"#
    ))

  public var date: DateTime

  public init(date: DateTime) {
    self.date = date
  }

  public var __variables: Variables? { ["date": date] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Query }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("getWalkDayActivity", GetWalkDayActivity.self, arguments: ["date": .variable("date")]),
    ] }

    public var getWalkDayActivity: GetWalkDayActivity { __data["getWalkDayActivity"] }

    /// GetWalkDayActivity
    ///
    /// Parent Type: `WalkDayActivity`
    public struct GetWalkDayActivity: SaiFastAPI.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.WalkDayActivity }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("totalDistance", Double.self),
        .field("totalDuration", Double.self),
        .field("avgSpeed", Double.self),
        .field("avgPace", Double.self),
        .field("date", SaiFastAPI.DateTime.self),
      ] }

      public var totalDistance: Double { __data["totalDistance"] }
      public var totalDuration: Double { __data["totalDuration"] }
      public var avgSpeed: Double { __data["avgSpeed"] }
      public var avgPace: Double { __data["avgPace"] }
      public var date: SaiFastAPI.DateTime { __data["date"] }
    }
  }
}
