//
//  AlamatKtpTests.swift
//  TestTunaikuTests
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import TestTunaiku

class AlamatKtpViewMock: AlamatKtpPresenterToView {
    var presenter: AlamatKtpViewToPresenter?

    var isPickerViewReloadDataCalled = false
    var isShowSnackbarErrorMessageCalled = false
    var isNavigateToReviewDataPageCalled = false

    func pickerViewReloadData() {
        isPickerViewReloadDataCalled = true
    }

    func showSnackbarErrorMessage(error: String) {
        isShowSnackbarErrorMessageCalled = true
    }

    func navigateToReviewDataPage() {
        isNavigateToReviewDataPageCalled = true
    }
}

class AlamatKtpInteractorMock: AlamatKtpPresenterToInteractor {
    var presenter: AlamatKtpInteractorToPresenter?

    var isGetProvinceCalled = false

    func getProvince() {
        isGetProvinceCalled = true
    }
}

class AlamatKtpTests: QuickSpec {
    override func spec() {
        describe("AlamatKtpPresenter") {
            var sut: AlamatKtpPresenter!
            var viewMock: AlamatKtpViewMock!
            var interactorMock: AlamatKtpInteractorMock!
            var housingTypeMock: [String]!
            var provinceMock: [Province]!

            beforeEach {
                viewMock = AlamatKtpViewMock()
                interactorMock = AlamatKtpInteractorMock()
                housingTypeMock = [HousingType.Rumah.rawValue, HousingType.Kantor.rawValue]
                provinceMock = [Province(nama: "Aceh"), Province(nama: "Surabaya")]
                sut = AlamatKtpPresenter(view: viewMock, interactor: interactorMock)
                sut.view = viewMock
                sut.interactor = interactorMock
                sut.housingTypeArray = housingTypeMock
                sut.provinceArray = provinceMock
            }

            context("numberOfEducationRow function is called") {
                it("function must run successfully") {
                    sut.didLoad()
                    expect(viewMock.isPickerViewReloadDataCalled).to(beTrue())
                }
            }

            context("numberOfHousingRow function is called") {
                it("function must run successfully") {
                    expect(sut.numberOfHousingRow()).to(equal(housingTypeMock.count))
                }
            }

            context("titleHousingAt function is called") {
                it("function must run successfully") {
                    expect(sut.titleHousingAt(row: 0)).to(equal(housingTypeMock[0]))
                }
            }

            context("numberOfProvinceRow function is called") {
                it("function must run successfully") {
                    expect(sut.numberOfProvinceRow()).to(equal(provinceMock.count))
                }
            }

            context("titleProvinceAt function is called") {
                it("function must run successfully") {
                    expect(sut.titleProvinceAt(row: 0)).to(equal(provinceMock[0].nama))
                }
            }

            context("validate all field function is called") {
                it("function must run successfully") {
                    sut.validateAllField(domicile: "lala", housing: "rumah", numberAddress: "5a", province: "aceh")
                    expect(viewMock.isNavigateToReviewDataPageCalled).to(beTrue())
                }
            }

            context("validate all field function is called") {
                it("function must run successfully") {
                    sut.validateAllField(domicile: "", housing: "rumah", numberAddress: "5a", province: "aceh")
                    expect(viewMock.isShowSnackbarErrorMessageCalled).to(beTrue())
                }
            }

            context("validate all field function is called") {
                it("function must run successfully") {
                    sut.validateAllField(domicile: "lala", housing: "", numberAddress: "5a", province: "aceh")
                    expect(viewMock.isShowSnackbarErrorMessageCalled).to(beTrue())
                }
            }

            context("validate all field function is called") {
                it("function must run successfully") {
                    sut.validateAllField(domicile: "lala", housing: "gfgfg", numberAddress: "", province: "aceh")
                    expect(viewMock.isShowSnackbarErrorMessageCalled).to(beTrue())
                }
            }

            context("validate all field function is called") {
                it("function must run successfully") {
                    sut.validateAllField(domicile: "lala", housing: "gfgfg", numberAddress: "5a", province: "")
                    expect(viewMock.isShowSnackbarErrorMessageCalled).to(beTrue())
                }
            }

            context("validate all field function is called") {
                it("alpha numeric validation, function must run successfully") {
                    sut.validateAllField(domicile: "lala", housing: "gfgfg", numberAddress: "5", province: "grgr")
                    expect(viewMock.isShowSnackbarErrorMessageCalled).to(beTrue())
                }
            }
        }
    }
}
