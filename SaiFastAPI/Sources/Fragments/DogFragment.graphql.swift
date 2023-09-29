// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public struct DogFragment: SaiFastAPI.SelectionSet, Fragment {
  public static var fragmentDefinition: StaticString {
    #"fragment DogFragment on DogType { __typename id name breed dateOfBirth sex }"#
  }

  public let __data: DataDict
  public init(_dataDict: DataDict) { __data = _dataDict }

  public static var __parentType: ApolloAPI.ParentType { SaiFastAPI.Objects.DogType }
  public static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("id", String.self),
    .field("name", String.self),
    .field("breed", String.self),
    .field("dateOfBirth", SaiFastAPI.DateTimeType.self),
    .field("sex", String.self),
  ] }

  public var id: String { __data["id"] }
  public var name: String { __data["name"] }
  public var breed: String { __data["breed"] }
  public var dateOfBirth: SaiFastAPI.DateTimeType { __data["dateOfBirth"] }
  public var sex: String { __data["sex"] }
}
