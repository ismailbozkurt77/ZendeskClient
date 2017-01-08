## Summary

Zendesk client app to monitor service tickets

## Requirements

- iOS 10.0
- Xcode 8.1
- Swift 3

## Frameworks

- [ZendeskNetworking](https://github.com/ismailbozkurt77/ZendeskNetworking)
- [ObjectMapper](https://github.com/Hearst-DD/ObjectMapper)


## Architecture 

A variant of [VIPER](https://www.objc.io/issues/13-architecture/viper/) architecture implemented, in order to create the most possible encapsulation within the project.

## Modules

### Ticket List
#### Builder
[TicketListModuleBuilder](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/TicketListModuleBuilder.swift) builds ticket list viper module and returns the corresponding viewController instance. Builders are the entry point of every module and only component which knows the exact classes of the components. The other components communicate with each other via protocols.
#### Presenter
[TicketListPresenter](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/Presenter/TicketListPresenter.swift) conforms the [TicketListEventHandler](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/Presenter/TicketListEventHandler.swift) protocol to talk with View. It is responsible for handling the system/user events. Moreover it manages and populates the [TicketListView](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/View/TicketListView.swift) with [ViewModel](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/View/TicketViewModel.swift)s
#### Interactor
[TicketListDefaultInteractor](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/Interactor/TicketListDefaultInteractor.swift) conforms the [TicketListInteractor](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/Interactor/TicketListInteractor.swift), which is responsible of defining all business rules of ticket list module.
#### Wireframe
Wireframes are resposible of the navigation between the VIPER modules. Since there is only one viper module in the application, no wireframe is implemented.
#### View
[Views](https://github.com/ismailbozkurt77/ZendeskClient/tree/master/ZendeskExercise/Modules/TicketList/View) are simply views. But in VIPER, viewControllers are also considered as views. So the view will hand over the user or system defined events to eventHandler which is [TicketListPresenter](https://github.com/ismailbozkurt77/ZendeskClient/blob/master/ZendeskExercise/Modules/TicketList/Presenter/TicketListPresenter.swift). Also the other responsibilities of the Views are handling the all UI related tasks like animations, etc.
#### Service
In theory the interactor is the one who contacts with the entities and server. However the network requests are usually long and ugly. so we use a dedicated service class to encapsulate all network calls. [TicketListService](https://github.com/ismailbozkurt77/ZendeskClient/tree/master/ZendeskExercise/Services/Ticket) uses a rest client to make rest api calls.

## Technical Debts
1. Removing the user authentication credetials from the code is the most urgent task. Implementing a proper login and if neccessary storing user username and pasword on keychain is the best practise for users' security.
1. Improving the [ZendeskNetworking](https://github.com/ismailbozkurt77/ZendeskNetworking) or using the most used Swift networing api. ZendeskNetworking currently supports on HTTP Get mehod and has limited features compared to frameworks like [Alamofire](https://github.com/Alamofire/Alamofire)
1. Better unit tests with proper mocking and stubing support.
