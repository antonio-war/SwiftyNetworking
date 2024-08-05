[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyNetworking%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/antonio-war/SwiftyNetworking)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fantonio-war%2FSwiftyNetworking%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/antonio-war/SwiftyNetworking)

# Overview

**SwiftyNetworking** is a powerful and easy-to-use networking client written in Swift. 
It simplifies making network requests and handling responses, allowing you to focus on building your application rather than dealing with the complexities of networking.
- **Simple**: Designed with simplicity and ease of use in mind, SwiftyNetworking eliminates the need for extensive configuration, making it ready to use right out of the box.
- **Asynchronous**: Built with modern Swift concurrency, supporting async/await.
- **Flexible**: Customize requests with different methods, headers, and cache policies.
- **Inspectable**: SwiftyNetworking collect some network metrics that can be used for in-depth debugging.

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
First, define a `SwiftyNetworkingRequest` which is a simple wrapper around `URLRequest` which allows you to easily set up everything you need to make an API call.
Such as the classics method, headers and query parameters, but also some parameters closely linked to the iOS ecosystem such as cache policy or timeout management.

```swift
   let request = SwiftyNetworkingRequest(
      endpoint: "https://jsonplaceholder.typicode.com",
      path: "comments",
      method: .get,
      parameters: ["postId": "1"],
      cachePolicy: .reloadIgnoringCacheData
   )
```

### Client creation
Create a `SwiftyNetworkingClient` instance using the default or a custom URLSessionConfiguration.
A single instance should be enough to manage the entire networking layer of the app, so hypothetically the client could be placed inside a dependency container.

```swift
   let networkingClient = SwiftyNetworkingClient()
```

### Request execution
Execute the request using the defined async method.

```swift
   let response = try await networkingClient.send(request)
```

The same method is also provided in the classic versions with completion instead of async/await.

### Response handling
If successful, the method will return a `SwiftyNetworkingResponse` which is a simple wrapper around `HTTPURLResponse` and allows you to easily access some elements like body, headers and few metrics. SwiftyNetworking always returns the source of the response and its duration allowing you to understand if it comes from the network or from the cache.

```swift
   if response.status == .success && let body = response.body {
      return String(data: body, encoding: .utf8)
   }
```

---
# Advanced usage
In a business context the basic functionality of SwiftyNetworking may not be enough, which is why additional constructs have been integrated.

### Routing
In a context where the app makes numerous requests of different types to the same API, it can be cumbersome to have to define more and more requests. That's why we introduced `SwiftyNetworkingRouter`, which is basically a protocol that allows you to define multiple requests that hypothetically point to the same API and therefore share resources.

```swift
   enum JsonPlaceholderRouter: SwiftyNetworkingRouter {
      case users
      case user(id: Int)
    
      var endpoint: String {
         "https://jsonplaceholder.typicode.com"
      }

      var path: String {
         switch self {
            case .users:
               "/"
            case .user(let id):
               "/\(id)"
         }
      }
   }
```

Making a request to one of the exposed routes will be really easy!

```swift
   let request = JsonPlaceholderRouter.users
   let response = try await client.send(request)
```

---
# Support
Your generous donations help sustain and improve this project. Here's why supporting us is important:
1. **Development and Maintenance**: Donations enable us to dedicate more time and resources to developing new features, fixing bugs, and maintaining the project's overall health. Your support directly contributes to the project's ongoing improvement and sustainability.
2. **Community Support**: Your contributions show your support for the project and help foster a thriving community around it. Your generosity motivates us to keep pushing the project forward and encourages others to join the cause.
3. **Open Source Sustainability**: By supporting open-source projects like ours, you're contributing to the sustainability of the entire open-source ecosystem. Your donations help ensure that valuable projects remain accessible to everyone.

Every donation, no matter how small, makes a big difference. Thank you for considering supporting us!<br><br>
<a href="https://www.buymeacoffee.com/antoniowar" target="_blank"><img src="https://github.com/appcraftstudio/buymeacoffee/raw/master/Images/snapshot-bmc-button.png" alt="Buy Me A Coffee" height="40"></a>

---
# License
SwiftyNetworking is published under the MIT license.
