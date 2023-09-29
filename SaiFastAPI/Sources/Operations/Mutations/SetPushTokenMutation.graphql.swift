// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class SetPushTokenMutation: GraphQLMutation {
  public static let operationName: String = "SetPushToken"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation SetPushToken($token: String!) { setPushToken(token: $token) { __typename ...UserFragment } }"#,
      fragments: [UserFragment.self, DogFragment.self]
    ))

  public var token: String

  public init(token: String) {
    self.token = token
  }

  public var __variables: Variables? { ["token": token] }

  public struct Data: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.Mutation }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("setPushToken", SetPushToken.self, arguments: ["token": .variable("token")]),
    ] }

    public var setPushToken: SetPushToken { __data["setPushToken"] }

    /// SetPushToken
    ///
    /// Parent Type: `UserType`
    public struct SetPushToken: SaiFastAPI.SelectionSet {
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

      /// SetPushToken.Dog
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
  }
}
