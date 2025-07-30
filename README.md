[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyNetworking%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/antonio-war/SwiftyNetworking)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyNetworking%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/antonio-war/SwiftyNetworking)

# Overview

**SwiftyNetworking** is a modern, lightweight networking client written in Swift, built with Swift 6 and strict concurrency in mind.
It streamlines network communication, allowing you to focus on your app’s logic rather than the intricacies of HTTP.
- **Simple**: Offers a clean API that works out of the box with minimal setup, focused solely on performing requests and returning responses.
- **Asynchronous**: Designed from the ground up to leverage async/await, Swift’s structured concurrency model, and Sendable for thread safety.
- **Flexible**: Easily configure requests with methods, headers, query parameters, and cache policies.
- **Inspectable**: Collects network metric to help with debugging and performance analysis.

---
# Integration
Integrating SwiftyNetworking into your Swift project is straightforward. Follow these steps to get started:

1. **Install SwiftyNetworking**:
   - If you're using Swift Package Manager (SPM):
     - Open your Xcode project.
     - Navigate to "File" > "Swift Packages" > "Add Package Dependency...".
     - Enter the SwiftyNetworking repository URL: `https://github.com/antonio-war/SwiftyNetworking`.
     - Follow the prompts to select the version and add SwiftyNetworking to your project.
   - If you're using CocoaPods or Carthage, we're sorry, but they are not currently supported.
2. **Import SwiftyNetworking**:
   - In the files where you want to use SwiftyNetworking features, import its module at the top of the file:
     ```swift
     import SwiftyNetworking
     ```
3. **Start Using SwiftyNetworking**:
   - Once SwiftyNetworking is imported, you can start using its methods to execute a networking request.
   - Refer to the usage section for guidance regarding structs, classes and methods.
4. **Run Your Project**:
   - Build and run your project to ensure that SwiftyNetworking has been integrated successfully.
   - Test out the functionality you've implemented using SwiftyNetworking to ensure everything works as expected.
That's it! You've successfully integrated SwiftyNetworking into your project and can now leverage its powerful features.

---
# Usage
The main steps for using SwiftyNetworking into your project are outlined below, guiding you through the process.

### Request definition
First, define a `NetworkingRequest` which is a simple wrapper around `URLRequest` that allows you to easily set up everything you need to make an API call.
Such as the classics method, headers and body, but also some parameters closely linked to the iOS ecosystem such as cache policy or timeout management.

```swift
   let url = URL(string: "https://api.example.com/search?query=swift&limit=10")!
   let request = NetworkingRequest(
       url: url,
       method: .get,
       headers: [
           "Authorization": "Bearer YOUR_ACCESS_TOKEN",
           "Accept": "application/json"
       ],
       cachePolicy: .reloadIgnoringCache,
       timeout: 30
   )
```

### Client creation
Create a `NetworkingClient` instance using the shared instance or a custom one.
Being stateless a single client should be enough to manage the entire networking layer of the app, so hypothetically you could place it inside a dependency container.

```swift
   let networkingClient = NetworkingClient()
```

### Request execution
Execute the request using the defined async method.

```swift
   let response = try await networkingClient.send(request)
```

### Response handling
If successful, the method will return a `NetworkingResponse` which is a simple wrapper around `URLResponse` and allows you to easily access some elements like body, headers and few metrics. SwiftyNetworking returns when possible the source of the response and its duration allowing you to understand if it comes from the network or from the cache.

```swift
   if response.status == .success {
      return String(data: response.body, encoding: .utf8)
   }
```

### Notes
This networking client is intentionally designed without any response body decoding logic. It operates as a low-level, generic component that simply interfaces with the outside world. Its responsibility is limited to making requests and returning raw responses. Decoding and mapping of the response data into models is delegated to a higher-level layer built on top of this client, keeping the architecture modular, testable, and decoupled.

---
# Support
Your generous donations help sustain and improve this project. Here's why supporting us is important:
1. **Development and Maintenance**: Donations enable us to dedicate more time and resources to developing new features, fixing bugs, and maintaining the project's overall health. Your support directly contributes to the project's ongoing improvement and sustainability.
2. **Community Support**: Your contributions show your support for the project and help foster a thriving community around it. Your generosity motivates us to keep pushing the project forward and encourages others to join the cause.
3. **Open Source Sustainability**: By supporting open-source projects like ours, you're contributing to the sustainability of the entire open-source ecosystem. Your donations help ensure that valuable projects remain accessible to everyone.

Every donation, no matter how small, makes a big difference. Thank you for considering supporting us!

---
# License
SwiftyNetworking is published under the MIT license.
