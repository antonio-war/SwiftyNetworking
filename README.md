# Overview

**SwiftNetworking** is a powerful and easy-to-use networking client written in Swift. 
It simplifies making network requests and handling responses, allowing you to focus on building your application rather than dealing with the complexities of networking.
- **Simple**: Designed with simplicity and ease of use in mind, SwiftyNetworking eliminates the need for extensive configuration, making it ready to use right out of the box.
- **Asynchronous**: Built with modern Swift concurrency, supporting `async/await`.
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
   - Once SwiftNetworking is imported, you can start using its methods to execute a networking request.
   - Refer to the usage section for guidance regarding structs, classes and methods.
5. **Run Your Project**:
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
      parameters: ["postId": 1],
      cachePolicy: .reloadIgnoringCacheData
   )
```
