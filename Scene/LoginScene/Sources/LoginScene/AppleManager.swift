//
//  AppleManger.swift
//  
//
//  Created by Eddy on 2023/07/31.
//

import AuthenticationServices

public final class AppleManger: NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    private var continuation: CheckedContinuation<String, Error>?
        
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return UIWindow.key ?? ASPresentationAnchor()
    }
    
    public func configure() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email, .fullName]
            
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            continuation?.resume(returning: appleIDCredential.user
            )
        
        default:
            break
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        continuation?.resume(throwing: error)
    }
    
    public func fetchAppleID() async throws -> String {
        return try await withCheckedThrowingContinuation{ continuation in
            self.continuation = continuation
        }
    }
}
