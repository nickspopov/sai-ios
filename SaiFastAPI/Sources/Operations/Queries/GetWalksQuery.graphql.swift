// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class GetWalksQuery: GraphQLQuery {
  public static let operationName: String = "GetWalks"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query GetWalks { getWalks { __typename id } }"#
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
      ] }

      public var id: String { __data["id"] }
    }
  }
}
