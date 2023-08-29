// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct CreateWalkInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    startedAt: DateTimeType,
    finishedAt: DateTimeType,
    walkHistory: CreateWalkHistoryType
  ) {
    __data = InputDict([
      "startedAt": startedAt,
      "finishedAt": finishedAt,
      "walkHistory": walkHistory
    ])
  }

  public var startedAt: DateTimeType {
    get { __data["startedAt"] }
    set { __data["startedAt"] = newValue }
  }

  public var finishedAt: DateTimeType {
    get { __data["finishedAt"] }
    set { __data["finishedAt"] = newValue }
  }

  public var walkHistory: CreateWalkHistoryType {
    get { __data["walkHistory"] }
    set { __data["walkHistory"] = newValue }
  }
}
