import Foundation

final class CarouselViewModel {
    let clients: [Client]
    init(clients: [Client]) {
        self.clients = clients
    }
}

extension CarouselViewModel: CarouselViewModelProtocol {
    var slideViewModels: [CarouselSlideViewModelProtocol] {
        var viewModels: [CarouselSlideViewModelProtocol] = []
        viewModels.append(InstitutionsSlideViewModel(clients: clients))
        viewModels.append(contentsOf: clients.map({ ClientCarouselSlideViewModel(client: $0) }))
        return viewModels
    }
}
