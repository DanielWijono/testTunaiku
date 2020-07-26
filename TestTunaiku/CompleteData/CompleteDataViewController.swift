//
//  CompleteDataViewController.swift
//  TestTunaiku
//
//  Created by Daniel Wijono on 26/07/20.
//  Copyright © 2020 Daniel Wijono. All rights reserved.
//

import UIKit

class CompleteDataViewController: UIViewController {

    //data diri page
    @IBOutlet weak var nationalIdValue: UILabel!

    @IBOutlet weak var fullnameValue: UILabel!

    @IBOutlet weak var bankAccountValue: UILabel!

    @IBOutlet weak var educationValue: UILabel!

    @IBOutlet weak var dobValue: UILabel!

    //alamat ktp page
    @IBOutlet weak var domicileValue: UILabel!

    @IBOutlet weak var housingTypeValue: UILabel!

    @IBOutlet weak var numberAddressValue: UILabel!

    @IBOutlet weak var provinceValue: UILabel!

    var presenter: CompleteDataViewToPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = CompleteDataPresenter(view: self)
        presenter?.getData()
        self.title = "Complete Data Page"
    }
}

extension CompleteDataViewController: CompleteDataPresenterToView {
    func setData(dataDiri: DataDiriEntity, alamatKtp: AlamatKtpEntity) {
        nationalIdValue.text = dataDiri.nationalId
        fullnameValue.text = dataDiri.fullname
        bankAccountValue.text = dataDiri.bankAccount
        educationValue.text = dataDiri.education
        dobValue.text = dataDiri.dob

        domicileValue.text = alamatKtp.domicile
        housingTypeValue.text = alamatKtp.housingType
        numberAddressValue.text = alamatKtp.numberAddress
        provinceValue.text = alamatKtp.province
    }
}
