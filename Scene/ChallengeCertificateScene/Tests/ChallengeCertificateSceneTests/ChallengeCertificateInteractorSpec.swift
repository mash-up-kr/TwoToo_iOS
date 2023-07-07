import Combine
import Foundation
import Quick
import Nimble
@testable import ChallengeCertificateScene

final class ChallengeCertificateInteractorSpec: QuickSpec {
    
    override func spec() {
        var interactor: ChallengeCertificateInteractor!
        var presenter: ChallengeCertificatePresenterMock!
        var worker: ChallengeCertificateWorkerMock!
        var router: ChallengeCertificateRouterMock!
        var cancellables: Set<AnyCancellable>!
        
        beforeEach {
            presenter = await ChallengeCertificatePresenterMock()
            router = await ChallengeCertificateRouterMock()
            worker = ChallengeCertificateWorkerMock()
            
            interactor = ChallengeCertificateInteractor(
                presenter: presenter,
                router: router,
                worker: worker
            )
            
            cancellables = []
        }
        
        describe("진입") {
            
        }
        
        describe("인증 이미지 첨부") {
            context("이미지 추가 버튼을 클릭했을 때") {
                beforeEach {
                    await interactor.didTapImageAdd()
                }
                
                it("이미지 첨부 방식 팝업을 보여준다.") {
                    let isPresentImageAttachmentMethodPopupCalled = await presenter.isPresentImageAttachmentMethodPopupCalled
                    expect(isPresentImageAttachmentMethodPopupCalled).to(beTrue())
                }
            }
            
            context("이미지 첨부 방식 팝업의 사진 촬영하기 버튼을 클릭했을 때") {
                beforeEach {
                    await interactor.didTapImageAttachmentMethodPopupCameraButton()
                }
                
                it("카메라 권한 요청을 보낸다.") {
                    expect(worker.isRequestCameraPermissionCalled).to(beTrue())
                }
                
                it("사진 접근 권한 요청을 보낸다.") {
                    expect(worker.isRequestPhotosPermissionCalled).to(beTrue())
                }
            }
            
            context("이미지 첨부 방식 팝업의 앨범에서 가져오기 버튼을 클릭했을 때") {
                beforeEach {
                    await interactor.didTapImageAttachmentMethodPopupGalleryButton()
                }
                
                it("사진 접근 권한 요청을 보낸다.") {
                    expect(worker.isRequestPhotosPermissionCalled).to(beTrue())
                }
            }
            
            describe("카메라 권한이 거부되었다.") {
                beforeEach {
                    worker.requestCameraPermissionResult = .success(false)
                }
                
                context("이미지 첨부 방식 팝업의 사진 촬영하기 버튼을 클릭했을 때") {
                    beforeEach {
                        await interactor.didTapImageAttachmentMethodPopupCameraButton()
                    }
                    
                    it("카메라 및 사진 접근 권한 팝업을 보여준다.") {
                        let isPresentCameraPermissionPopupCalled = await presenter.isPresentCameraPermissionPopupCalled
                        expect(isPresentCameraPermissionPopupCalled).to(beTrue())
                    }
                }
            }
            
            describe("사진 접근 권한이 거부되었다.") {
                beforeEach {
                    worker.requestPhotosPermissionResult = .success(false)
                }
                
                context("이미지 첨부 방식 팝업의 사진 촬영하기 버튼을 클릭했을 때") {
                    beforeEach {
                        await interactor.didTapImageAttachmentMethodPopupCameraButton()
                    }
                    
                    it("카메라 및 사진 접근 권한 팝업을 보여준다.") {
                        let isPresentCameraPermissionPopupCalled = await presenter.isPresentCameraPermissionPopupCalled
                        expect(isPresentCameraPermissionPopupCalled).to(beTrue())
                    }
                }
                
                context("이미지 첨부 방식 팝업의 앨범에서 가져오기 버튼을 클릭했을 때") {
                    beforeEach {
                        await interactor.didTapImageAttachmentMethodPopupGalleryButton()
                    }
                    
                    it("사진 접근 권한 팝업을 보여준다.") {
                        let isPresentPhotosPermissionPopupCalled = await presenter.isPresentPhotosPermissionPopupCalled
                        expect(isPresentPhotosPermissionPopupCalled).to(beTrue())
                    }
                }
            }
            
            describe("카메라와 사진 접근 권한이 허용되었다.") {
                beforeEach {
                    worker.requestCameraPermissionResult = .success(true)
                    worker.requestPhotosPermissionResult = .success(true)
                }
                
                context("이미지 첨부 방식 팝업의 사진 촬영하기 버튼을 클릭했을 때") {
                    beforeEach {
                        await interactor.didTapImageAttachmentMethodPopupCameraButton()
                    }
                    
                    it("카메라를 보여준다.") {
                        let isPresentCameraCalled = await presenter.isPresentCameraCalled
                        expect(isPresentCameraCalled).to(beTrue())
                    }
                }
            }
            
            context("사진을 촬용하였을 때") {
                beforeEach {
                    await interactor.didTakePhoto(image: .add)
                }
                
                it("촬영한 이미지로 이미지 크롭 화면을 보여준다.") {
                    let lastImageForCropView = await presenter.lastImageForCropView
                    let isPresentImageCropViewCalled = await presenter.isPresentImageCropViewCalled
                    expect(lastImageForCropView).to(equal(.add))
                    expect(isPresentImageCropViewCalled).to(beTrue())
                }
            }
            
            describe("사진 접근 권한이 허용되었다.") {
                beforeEach {
                    worker.requestPhotosPermissionResult = .success(true)
                }
                
                context("이미지 첨부 방식 팝업의 앨범에서 가져오기 버튼을 클릭했을 때") {
                    beforeEach {
                        await interactor.didTapImageAttachmentMethodPopupGalleryButton()
                    }
                    
                    it("이미지 피커를 보여준다.") {
                        let isPresentImagePickerCalled = await presenter.isPresentImagePickerCalled
                        expect(isPresentImagePickerCalled).to(beTrue())
                    }
                }
            }
            
            context("이미지 피커에서 사진을 선택했을 때") {
                beforeEach {
                    await interactor.didSelectImagePickerImage(selectedImage: .add)
                }
                
                it("선택한 이미지로 이미지 크롭 화면을 보여준다.") {
                    let lastImageForCropView = await presenter.lastImageForCropView
                    let isPresentImageCropViewCalled = await presenter.isPresentImageCropViewCalled
                    expect(lastImageForCropView).to(equal(.add))
                    expect(isPresentImageCropViewCalled).to(beTrue())
                }
            }
            
            context("이미지 크롭을 완료하였을 때") {
                beforeEach {
                    await interactor.didCropImage(image: .add)
                }
                
                it("사진을 갤러리에 저장한다.") {
                    expect(worker.isSaveImageCalled).to(beTrue())
                }
            }
            
            describe("사진을 갤러리에 저장 성공한다.") {
                beforeEach {
                    worker.saveImageResult = true
                }
                
                context("이미지 크롭을 완료하였을 때") {
                    beforeEach {
                        await interactor.didCropImage(image: .add)
                    }
                    
                    it("첨부된 이미지로 인증 사진 데이터에 업데이트한다.") {
                        expect(interactor.certificateImage).to(equal(.add))
                    }
                    
                    it("업데이트 된 인증 사진을 보여준다.") {
                        let lastCertificateImage = await presenter.lastCertificateImage
                        let isPresentCertificateImageCalled = await presenter.isPresentCertificateImageCalled
                        expect(lastCertificateImage).to(equal(.add))
                        expect(isPresentCertificateImageCalled).to(beTrue())
                    }
                }
            }
            
            describe("사진을 갤러리에 저장 실패한다.") {
                beforeEach {
                    worker.saveImageResult = false
                }
                
                context("이미지 크롭을 완료하였을 때") {
                    beforeEach {
                        await interactor.didCropImage(image: .add)
                    }
                    
                    it("사진 저장 실패 오류를 보여준다.") {
                        let lastPhotoSaveError = await presenter.lastPhotoSaveError
                        let isPresentPhotoSaveErrorCalled = await presenter.isPresentPhotoSaveErrorCalled
                        expect(lastPhotoSaveError).to(matchError(NSError(domain: "Test", code: 999)))
                        expect(isPresentPhotoSaveErrorCalled).to(beTrue())
                    }
                }
            }
        }
        
        describe("인증소감 문구 작성") {
            context("인증소감 문구를 입력 했을 때") {
                beforeEach {
                    await interactor.didEnterCertificateComment(comment: "Test")
                }
                
                it("입력된 인증소감으로 인증소감 문구 데이터를 업데이트한다.") {
                    expect(interactor.certificateComment).to(equal("Test"))
                }
            }
        }
        
        describe("인증하기") {
            describe("인증소감 문구가 존재한다.") {
                beforeEach {
                    interactor.certificateComment = "Test"
                }
                
                describe("첨부된 이미지가 존재한다.") {
                    beforeEach {
                        interactor.certificateImage = .add
                    }
                    
                    context("인증소감 문구 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateComment()
                        }
                        
                        it("인증하기를 활성화하여 보여준다.") {
                            let isPresentEnabledCertificateCalled = await presenter.isPresentEnabledCertificateCalled
                            expect(isPresentEnabledCertificateCalled).to(beTrue())
                        }
                    }
                    
                    context("인증 사진 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateImage()
                        }
                        
                        it("인증하기를 활성화하여 보여준다.") {
                            let isPresentEnabledCertificateCalled = await presenter.isPresentEnabledCertificateCalled
                            expect(isPresentEnabledCertificateCalled).to(beTrue())
                        }
                    }
                    
                    context("인증 하기 버튼을 탭 했을 때") {
                        beforeEach {
                            await interactor.didTapCertificate()
                        }
                        
                        it("첨부된 인증 사진과 입력된 인증소감 문구로 인증하기 요청을 한다.") {
                            expect(worker.lastCertificateImage).to(equal(.add))
                            expect(worker.lastCertificateComment).to(equal("Test"))
                            expect(worker.isRequestCertificateCalled).to(beTrue())
                        }
                    }
                    
                    describe("인증하기 요청 결과가 성공이다.") {
                        beforeEach {
                            worker.requestCertificateResult = true
                        }
                        
                        context("인증 하기 버튼을 탭 했을 때") {
                            beforeEach {
                                await interactor.didTapCertificate()
                            }
                            
                            it("화면을 닫는다.") {
                                let isDismissCalled = await router.isDismissCalled
                                expect(isDismissCalled).to(beTrue())
                            }
                            
                            it("인증 성공을 보여준다.") {
                                let isPresentCertificateSuccessCalled = await presenter.isPresentCertificateSuccessCalled
                                expect(isPresentCertificateSuccessCalled).to(beTrue())
                            }
                        }
                    }
                    
                    describe("인증하기 요청 결과가 실패이다.") {
                        beforeEach {
                            worker.requestCertificateResult = false
                        }
                        
                        context("인증 하기 버튼을 탭 했을 때") {
                            beforeEach {
                                await interactor.didTapCertificate()
                            }
                            
                            it("인증 실패 오류를 보여준다.") {
                                let lastCertificateError = await presenter.lastCertificateError
                                let isPresentCertificateErrorCalled = await presenter.isPresentCertificateErrorCalled
                                expect(lastCertificateError).to(matchError(NSError(domain: "Test", code: 999)))
                                expect(isPresentCertificateErrorCalled).to(beTrue())
                            }
                        }
                    }
                }
                
                describe("첨부된 이미지가 존재하지 않는다.") {
                    beforeEach {
                        interactor.certificateImage = nil
                    }
                    
                    context("인증소감 문구 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateComment()
                        }
                        
                        it("인증하기를 비활성화하여 보여준다.") {
                            let isPresentDisabledCertificateCalled = await presenter.isPresentDisabledCertificateCalled
                            expect(isPresentDisabledCertificateCalled).to(beTrue())
                        }
                    }
                    
                    context("인증 사진 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateImage()
                        }
                        
                        it("인증하기를 비활성화하여 보여준다.") {
                            let isPresentDisabledCertificateCalled = await presenter.isPresentDisabledCertificateCalled
                            expect(isPresentDisabledCertificateCalled).to(beTrue())
                        }
                    }
                }
            }
            
            describe("인증소감 문구가 존재하지 않는다.") {
                beforeEach {
                    interactor.certificateComment = ""
                }
                
                describe("첨부된 이미지가 존재한다.") {
                    beforeEach {
                        interactor.certificateImage = .add
                    }
                    
                    context("인증소감 문구 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateComment()
                        }
                        
                        it("인증하기를 비활성화하여 보여준다.") {
                            let isPresentDisabledCertificateCalled = await presenter.isPresentDisabledCertificateCalled
                            expect(isPresentDisabledCertificateCalled).to(beTrue())
                        }
                    }
                    
                    context("인증 사진 데이터가 업데이트 되었을 때") {
                        beforeEach {
                            await interactor.didUpdateCertificateImage()
                        }
                        
                        it("인증하기를 비활성화하여 보여준다.") {
                            let isPresentDisabledCertificateCalled = await presenter.isPresentDisabledCertificateCalled
                            expect(isPresentDisabledCertificateCalled).to(beTrue())
                        }
                    }
                }
            }
        }
    }
}

class ChallengeCertificatePresenterMock: ChallengeCertificatePresentationLogic {
    
    var isPresentImageAttachmentMethodPopupCalled = false
    var isPresentCameraPermissionPopupCalled = false
    var isPresentPhotosPermissionPopupCalled = false
    var isPresentCameraCalled = false
    var isPresentImagePickerCalled = false
    var isPresentImageCropViewCalled = false
    var isPresentPhotoSaveErrorCalled = false
    var isPresentCertificateImageCalled = false
    var isPresentEnabledCertificateCalled = false
    var isPresentDisabledCertificateCalled = false
    var isPresentCertificateSuccessCalled = false
    var isPresentCertificateErrorCalled = false

    var lastImageForCropView: ChallengeCertificate.Model.Image?
    var lastPhotoSaveError: Error?
    var lastCertificateImage: ChallengeCertificate.Model.Image?
    var lastCertificateError: Error?

    func presentImageAttachmentMethodPopup() {
        self.isPresentImageAttachmentMethodPopupCalled = true
    }

    func presentCameraPermissionPopup() {
        self.isPresentCameraPermissionPopupCalled = true
    }

    func presentPhotosPermissionPopup() {
        self.isPresentPhotosPermissionPopupCalled = true
    }

    func presentCamera() {
        self.isPresentCameraCalled = true
    }

    func presentImagePicker() {
        self.isPresentImagePickerCalled = true
    }

    func presentImageCropView(with image: ChallengeCertificate.Model.Image) {
        self.isPresentImageCropViewCalled = true
        self.lastImageForCropView = image
    }

    func presentPhotoSaveError(error: Error) {
        self.isPresentPhotoSaveErrorCalled = true
        self.lastPhotoSaveError = error
    }

    func presentCertificateImage(image: ChallengeCertificate.Model.Image) {
        self.isPresentCertificateImageCalled = true
        self.lastCertificateImage = image
    }

    func presentEnabledCertificate() {
        self.isPresentEnabledCertificateCalled = true
    }

    func presentDisabledCertificate() {
        self.isPresentDisabledCertificateCalled = true
    }
    
    func presentCertificateSuccess() {
        self.isPresentCertificateSuccessCalled = true
    }
    
    func presentCertificateError(error: Error) {
        self.isPresentCertificateErrorCalled = true
        self.lastCertificateError = error
    }
}

class ChallengeCertificateWorkerMock: ChallengeCertificateWorkerProtocol {
    
    var isRequestCameraPermissionCalled = false
    var isRequestPhotosPermissionCalled = false
    var isSaveImageCalled = false
    var isRequestCertificateCalled = false

    var lastImageForSaving: ChallengeCertificate.Model.Image?
    var lastCertificateImage: ChallengeCertificate.Model.Image?
    var lastCertificateComment: String?

    var requestCameraPermissionResult: Result<Bool, Error>?
    var requestPhotosPermissionResult: Result<Bool, Error>?
    var saveImageResult: Bool?
    var requestCertificateResult: Bool?

    func requestCameraPermission() async throws -> Bool {
        self.isRequestCameraPermissionCalled = true
        
        switch self.requestCameraPermissionResult {
            case .success(let success):
                return success
                
            case .failure(let error):
                throw error
                
            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    func requestPhotosPermission() async throws -> Bool {
        self.isRequestPhotosPermissionCalled = true
        
        switch self.requestPhotosPermissionResult {
            case .success(let success):
                return success
                
            case .failure(let error):
                throw error
                
            case .none:
                throw NSError(domain: "Test", code: 999)
        }
    }
    
    func saveImage(image: ChallengeCertificate.Model.Image) async throws {
        self.isSaveImageCalled = true
        self.lastImageForSaving = image
        
        if let result = self.saveImageResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
    
    func requestCertificate(certificateImage: ChallengeCertificate.Model.Image, certificateComment: String) async throws {
        self.isRequestCertificateCalled = true
        self.lastCertificateImage = certificateImage
        self.lastCertificateComment = certificateComment
        
        if let result = self.requestCertificateResult, !result {
            throw NSError(domain: "Test", code: 999)
        }
    }
}

class ChallengeCertificateRouterMock: ChallengeCertificateRoutingLogic {
    
    var isDismissCalled = false
    
    func dismiss() {
        self.isDismissCalled = true
    }
}
