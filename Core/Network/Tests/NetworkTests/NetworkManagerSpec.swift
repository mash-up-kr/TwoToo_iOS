import Quick
import Nimble
import OHHTTPStubs
import OHHTTPStubsSwift
import Alamofire
@testable import Network

class NetworkManagerTests: QuickSpec {
    
    override func spec() {
        var sut: NetworkManager!
        
        beforeEach {
            sut = NetworkManager(configuration: .init(baseURL: "https://api.example.com"))
        }
        
        afterEach {
            sut = nil
            HTTPStubs.removeAllStubs()
        }
        
        describe("네트워크 요청 결과가 성공이다.") {
            beforeEach {
                stub(condition: isHost("api.example.com")) { _ in
                    let stubData = "{\"success\": true}".data(using: .utf8)
                    return HTTPStubsResponse(data: stubData!, statusCode: 200, headers: ["Content-Type": "application/json"])
                }
            }
            
            context("GET 통신을 요청할 때") {
                var response: DecodableResponseMock?
                
                beforeEach {
                    do {
                        response = try await sut.request(
                            path: "/success",
                            method: .get
                        )
                    } catch {
                        
                    }
                }
                
                it("성공적인 응답이 돌아와야한다.") {
                    expect(response).toNot(beNil())
                    expect(response?.success).to(beTrue())
                }
            }
            
            context("POST 통신을 요청할 때") {
                var response: DecodableResponseMock?
                
                beforeEach {
                    do {
                        response = try await sut.request(
                            path: "/success",
                            method: .post,
                            parameters: ["data": "123"]
                        )
                    } catch {
                        
                    }
                }
                
                it("성공적인 응답이 돌아와야한다.") {
                    expect(response).toNot(beNil())
                    expect(response?.success).to(beTrue())
                }
            }
            
            context("업로드를 요청할 때") {
                var response: DecodableResponseMock?

                beforeEach {
                    do {
                        response = try await sut.upload(
                            path: "/upload",
                            data: Data(),
                            fileName: "test",
                            mimeType: "application/octet-stream"
                        )
                    } catch {
                        
                    }
                }
                
                it("성공적인 응답이 돌아와야한다.") {
                    expect(response).toNot(beNil())
                    expect(response?.success).to(beTrue())
                }
            }
        }
        
        describe("네트워크 요청 결과가 유효하지 않은 값이다.") {
            beforeEach {
                stub(condition: isHost("api.example.com")) { _ in
                    let invalidJSONData = "Invalid JSON".data(using: .utf8)!
                    return HTTPStubsResponse(data: invalidJSONData, statusCode: 200, headers: ["Content-Type": "application/json"])
                }
            }
            
            context("GET 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .get
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("디코딩 에러를 반환해야한다.") {
                    expect(resultError).to(matchError(NSError(domain: "decode_error", code: -2)))
                }
            }
            
            context("POST 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .post,
                            parameters: ["data": "123"]
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("디코딩 에러를 반환해야한다.") {
                    expect(resultError).to(matchError(NSError(domain: "decode_error", code: -2)))
                }
            }
            
            context("업로드를 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.upload(
                            path: "/upload",
                            data: Data(),
                            fileName: "test",
                            mimeType: "application/octet-stream"
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("디코딩 에러를 반환해야한다.") {
                    expect(resultError).to(matchError(NSError(domain: "decode_error", code: -2)))
                }
            }
        }
        
        describe("네트워크 요청 결과가 실패이다.") {
            beforeEach {
                stub(condition: isHost("api.example.com")) { _ in
                    return HTTPStubsResponse(error: NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet))
                }
            }
            
            context("GET 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .get
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
            
            context("POST 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .post,
                            parameters: ["data": "123"]
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
            
            context("업로드를 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.upload(
                            path: "/upload",
                            data: Data(),
                            fileName: "test",
                            mimeType: "application/octet-stream"
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
        }
        
        describe("네트워크 요청 결과가 25초 이상 반환되지 않는다.") {
            beforeEach {
                stub(condition: isHost("api.example.com")) { _ in
                    let stubData = "{\"success\": true}".data(using: .utf8)
                    let response = HTTPStubsResponse(data: stubData!, statusCode: 200, headers: ["Content-Type": "application/json"])
                    response.requestTime = 25.5
                    return response
                }
            }
            
            context("GET 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .get
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
            
            context("POST 통신을 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.request(
                            path: "/success",
                            method: .post,
                            parameters: ["data": "123"]
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
            
            context("업로드를 요청할 때") {
                var resultError: Error?
                
                beforeEach {
                    do {
                        let _: DecodableResponseMock = try await sut.upload(
                            path: "/upload",
                            data: Data(),
                            fileName: "test",
                            mimeType: "application/octet-stream"
                        )
                    } catch {
                        resultError = error
                    }
                }
                
                it("에러를 반환해야한다.") {
                    expect(resultError).toNot(beNil())
                }
            }
        }
    }
}

struct DecodableResponseMock: Decodable {
    let success: Bool
}
