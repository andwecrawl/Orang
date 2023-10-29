//
//  AddViewController+.swift
//  Orang
//
//  Created by yeoni on 2023/10/06.
//

import UIKit
import PhotosUI

// speciesPicker
extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Species.allCases.count
    }
    
    // 해당 셀을 선택했을 때 어떻게 할지 action을 여기서 지정!
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let selected = Species.allCases[row]
        viewModel.species.value = selected
    }
    
    // 말 그대로 타이틀 지정해 주기!!
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(Species.allCases[row].toString)"
    }
}


// datePicker
extension AddViewController {
    func setupDatePicker(textField: UITextField) {
        // 여기서 datePicker를 weak로 써줘야 하나?
        let datePicker = UIDatePicker()
        datePicker.tag = textField.tag
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .inline
        
        let range = getMaxMinDate(date: datePicker.date)
        datePicker.maximumDate = range.max
        datePicker.minimumDate = range.min
        
        // 원하는 언어로 지역 설정
        datePicker.locale = Locale(identifier: "ko-KR")
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        textField.inputView = datePicker
        textField.text = datePicker.date.toFormattedString()
    }
    
    
    func getMaxMinDate(date: Date) -> (max: Date?, min: Date?) {
        
        let calendar = Calendar(identifier: .gregorian)
        var components = DateComponents()
        components.calendar = calendar
        components.year = -1
        components.month = 12
        let maxDate = calendar.date(byAdding: components, to: date)
        components.year = -31
        let minDate = calendar.date(byAdding: components, to: date)
        return (maxDate, minDate)
    }
    
    
    // 값이 변할 때 마다 동작
    @objc func dateChange(_ sender: UIDatePicker) {
        if sender.tag == 1 {
            viewModel.birthday.value = sender.date
        } else {
            viewModel.belongDate.value = sender.date
        }
    }
}


// profile Image
extension AddViewController: PHPickerViewControllerDelegate {
    @objc func profileImageButtonClicked() {
        // picker 기본 설정!!
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        // 이미지 클릭 시 화면 dismiss
        picker.dismiss(animated: true)
        
        // itemProvider == 선택한 asset을 보여주는 역할을 함!!
        if let itemProvider = results.first?.itemProvider,
           itemProvider.canLoadObject(ofClass: UIImage.self) {
            let type: NSItemProviderReading.Type = UIImage.self
            itemProvider.loadObject(ofClass: type) { [weak self](image, error) in
                if let image = image as? UIImage {
                    DispatchQueue.main.async {
                        self?.mainView.profileImageView.image = image
                    }
                } else {
                    // 다시 시도 Alert
                    print(error)
                    self?.sendOneSidedAlert(title: "이미지를 저장할 수 없습니다!", message: "한 번 더 시도해 주세요!")
                }
            }
        }
    }
}


