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
}

class DataDiriPresenterMock: DataDiriInteractorToPresenter {

}

class DataDiriInteractorMock: DataDiriPresenterToInteractor {
    var presenter: DataDiriInteractorToPresenter?
}

class DataDiriUnitTest: QuickSpec {
    override func spec() {
        describe("dataDiriPresenter") {
            var sut: DataDiriPresenter!
            var viewMock: DataDiriViewMock!
            var interactorMock: DataDiriInteractorMock!
            var educationArrayMock: [String]!

            beforeEach {
                viewMock = DataDiriViewMock()
                interactorMock = DataDiriInteractorMock()
                sut = DataDiriPresenter(view: viewMock, interactor: interactorMock)
                educationArrayMock = [Education.SD.rawValue, Education.SMP.rawValue, Education.SMA.rawValue,
                Education.S1.rawValue, Education.S2.rawValue, Education.S3.rawValue]
                sut.educationArray = educationArrayMock
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
        }
    }
}
