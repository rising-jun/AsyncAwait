//
//  ViewModel.swift
//  Asyncawait
//
//  Created by 김동준 on 2022/07/26.
//

import Foundation

final class ViewModel {
    var state = ViewModelState()
    let repository = DoodleRepository()
    
    func fetchDoodles() {
        Task.init {
            let urls = try await repository.fetchDoodles().map { $0.image }
            for url in urls {
                try await state.appendImageData(repository.fetchImages(url: url))
            }
        }
    }
}

actor ViewModelState {
    var updateDoodles: ((Data) -> ())?
    func setUpdateDoodles(_ updateDoodles: ((Data) -> ())?) {
        self.updateDoodles = updateDoodles
    }
    
    var doodleImages: [Data] = [] {
        willSet(value) {
            updateDoodles?(value.last!)
        }
    }
    func appendImageData(_ data: Data) {
        doodleImages.append(data)
    }
}
