// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct UserFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment UserFragment on UserType { __typename id name dogs { __typename ...DogFragment } }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.UserType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("name", String.self),
    .field("dogs", [Dog].self),
  ] }

  public var id: String { __data["id"] }
  public var name: String { __data["name"] }
  public var dogs: [Dog] { __data["dogs"] }

  /// Dog
  ///
  /// Parent Type: `DogType`
  public struct Dog: SaiFastAPI.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.DogType }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(DogFragment.self),
    ] }

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
