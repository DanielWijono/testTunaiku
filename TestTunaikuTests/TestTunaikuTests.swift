//
//  DataDiriUnitTest.swift
//  TestTunaikuTests
//
//  Created by Daniel Wijono on 24/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import Foundation
import Nimble
import Quick
@testable import TestTunaiku

class DataDiriViewMock: DataDiriPresenterToView {

    var presenter: DataDiriViewToPresenter?
    var isGoToAlamatKtpPageCalled = false
    var isShowSnackbarErrorCalled = false

    func goToAlamatKtpPage() {
        isGoToAlamatKtpPageCalled = true
    }

    func showSnackbarError(messsage: String) {
        isShowSnackbarErrorCalled = false
    }
}

class DataDiriUnitTest: QuickSpec {
    override func spec() {
        describe("dataDiriPresenter") {
            var sut: DataDiriPresenter!
            var viewMock: DataDiriViewMock!
            var educationArrayMock: [String]!

            beforeEach {
                viewMock = DataDiriViewMock()
                sut = DataDiriPresenter()
                educationArrayMock = [Education.SD.rawValue, Education.SMP.rawValue, Education.SMA.rawValue,
                Education.S1.rawValue, Education.S2.rawValue, Education.S3.rawValue]
                sut.educationArray = educationArrayMock
                sut.view = viewMock
            }

            context("numberOfEducationRow function is called") {
                it("function must run successfully") {
                    expect(sut.numberOfEducationRow()).to(equal(educationArrayMock.count))
                }
            }

            context("titleEducationAt function is called") {
                it("function must run successfully") {
                    expect(sut.titleEducationAt(row: 1)).to(equal(educationArrayMock[1]))
                }
            }

            context("validateCharacters function is called") {
                it("test text count equals to 9, function must run successfully") {
                    expect(sut.validateCharacters(replacementString: "lala", textCount: 9)).to(equal(true))
                }
            }

            context("validateCharacters function is called") {
                it("test text count equals more than 10, function must run successfully") {
                    expect(sut.validateCharacters(replacementString: "lala", textCount: 11)).to(equal(false))
                }
            }

            context("validateCharacters function is called") {
                it("test delete if text count already reach maximum( 10 characters ), function must run successfully") {
                    expect(sut.validateCharacters(replacementString: "", textCount: 10)).to(equal(true))
                }
            }

            context("validateNumbers function is called") {
                it("test text count , function must run successfully") {
                    expect(sut.validateNumber(replacementString: "123", textCount: 15)).to(equal(true))
                }
            }

            context("validateNumbers function is called") {
                it("test if input letter, should be equal to false , function must run successfully") {
                    expect(sut.validateNumber(replacementString: "fkfk", textCount: 15)).to(equal(false))
                }
            }

            context("validateNumbers function is called") {
                it("test delete if text count already reach maximum( 16 characters ), function must run successfully") {
                    expect(sut.validateNumber(replacementString: "", textCount: 16)).to(equal(true))
                }
            }

            context("validateAllField function is called") {
                it("test happy flow, function must run successfully") {
                    sut.validateAllField(nationalId: "1234567890123456", bankAccount: "5657538585", education: "S1", dob: "26-02-2020", fullname: "lalala")
                    expect(viewMock.isGoToAlamatKtpPageCalled).to(beTrue())
                }
            }

            context("validateAllField function is called") {
                it("test national id failed case, function must run successfully") {
                    sut.validateAllField(nationalId: "1234567890", bankAccount: "5657538585", education: "S1", dob: "26-02-2020", fullname: "lalala")
                    expect(viewMock.isShowSnackbarErrorCalled).to(equal(false))
                }
            }

            context("validateAllField function is called") {
                it("test bank account failed case , function must run successfully") {
                    sut.validateAllField(nationalId: "1234567890123456", bankAccount: "565", education: "S1", dob: "26-02-2020", fullname: "lalala")
                    expect(viewMock.isShowSnackbarErrorCalled).to(equal(false))
                }
            }

            context("validateAllField function is called") {
                it("test education failed case , function must run successfully") {
                    sut.validateAllField(nationalId: "1234567890123456", bankAccount: "5657538585", education: "", dob: "26-02-2020", fullname: "lalala")
                    expect(viewMock.isShowSnackbarErrorCalled).to(equal(false))
                }
            }

            context("validateAllField function is called") {
                it("test dob failed case , function must run successfully") {
                    sut.validateAllField(nationalId: "1234567890123456", bankAccount: "5657538585", education: "S1", dob: "", fullname: "lalala")
                    expect(viewMock.isShowSnackbarErrorCalled).to(equal(false))
                }
            }
        }
    }
}
