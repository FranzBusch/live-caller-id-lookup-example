// Copyright 2024 Apple Inc. and the Swift Homomorphic Encryption project authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Hummingbird
import HummingbirdTesting
@testable import PIRService
import SwiftProtobuf

public extension TestClientProtocol {
    @discardableResult
    func execute<Return>(
        uri: String,
        userIdentifier: UserIdentifier,
        message: some Message,
        testCallback: @escaping (TestResponse) async throws -> Return = { $0 }) async throws -> Return
    {
        let bodyBuffer = try ByteBuffer(data: message.serializedData())
        let headers: HTTPFields = [.userIdentifier: userIdentifier.identifier]
        let response = try await executeRequest(uri: uri, method: .post, headers: headers, body: bodyBuffer)
        return try await testCallback(response)
    }
}
