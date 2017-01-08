//
//  TicketDefaultService.swift
//  ZendeskExercise
//
//  Created by Ismail on 07/01/2017.
//  Copyright © 2017 Zendesk. All rights reserved.
//


import UIKit
import ZendeskNetworking
import ObjectMapper

// MARK: - Path
private let kTicketDefaultServicefetchTicketPath = "/views/39551161/tickets.json"

// MARK: - Response Keys
private let kTicketDefaultServiceFetchResponseTicketKey = "tickets"


// MARK: - Error
private let kTicketDefaultServiceErrorDomain = "com.ismail.bozkurt.zendesk.client.ticket.service.error"
private let kTicketDefaultServiceJSONSerializationErrorCode = -10000
private let kTicketDefaultServiceInvalidJSONContentErrorCode = -10001

// MARK: - Credentials
// TODO: remove credentials from code
private let kTicketDefaultServiceCredentialsUsername = "acooke+techtest@zendesk.com"
private let kTicketDefaultServiceCredentialsPassword = "mobile"


// MARK: - Query

let kTicketDefaultServiceFetchTicketSortByQueryKey = "sort_by"
private enum FetchTicketQuerySort: String {
    case subject = "subject"
    case id = "id"
    case status = "status"
}
let kTicketDefaultServiceFetchTicketSortOrderQueryKey = "sort_order"
let kTicketDefaultServiceFetchTicketSortOrderQueryAscending = "asc"
let kTicketDefaultServiceFetchTicketSortOrderQueryDescending = "desc"


class TicketDefaultService: NSObject, TicketService {
    
    // MARK: - Properties
    private var restClient: RestClient
    
    // MARK: - Life cycle
    init(restClient: RestClient) {
        self.restClient = restClient
    }
    
    // MARK: - TicketService
    
    @discardableResult
    func fetchTickets(sortBy: TicketSortOrderOption, ascending: Bool, completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask {
        let url = TicketDefaultService.buildFetchTicketUrl(sortBy: sortBy, ascending: ascending)
        let auhtHeader = TicketDefaultService.buildFetchTicketHeaders()
        let dataTask = self.restClient.GET(url: url,
                                           headers: auhtHeader,
                                           completion:
            { [weak self] (data: Data?, response: URLResponse?, error: Error?) in
                self?.handleResponse(data: data, response: response, error: error, completion: { (tickets: [Ticket]?, error: Error?) in
                    DispatchQueue.main.async {
                        completion(tickets, error)
                    }
                })
        })
        
        return dataTask
    }
    
    // MARK: - Private Helpers
    
    private func handleResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping  TicketServiceFetchTicketCompletion) {
        DispatchQueue.global().async {
            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, TicketDefaultService.buildError(code: kTicketDefaultServiceInvalidJSONContentErrorCode))
                return
            }
            
            let responseData: [String: Any]!
            do {
                responseData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
            } catch {
                completion(nil, TicketDefaultService.buildError(code: kTicketDefaultServiceJSONSerializationErrorCode))
                return
            }
            
            guard let ticketsJSON = responseData[kTicketDefaultServiceFetchResponseTicketKey] as? [[String: Any]] else {
                completion(nil, TicketDefaultService.buildError(code: kTicketDefaultServiceInvalidJSONContentErrorCode))
                return
            }
            
            let tickets = Mapper<Ticket>().mapArray(JSONArray: ticketsJSON)
            completion(tickets, error)
        }
    }

    // MARK: - Private Factory

    fileprivate class func buildFetchTicketUrl(sortBy: TicketSortOrderOption, ascending: Bool) -> URL {
        let baseUrl = EndPointFactory.baseUrl()
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.path += kTicketDefaultServicefetchTicketPath
        
        urlComponents?.queryItems = [self.buildFetchTicketsSortByQueryItem(sortBy: sortBy),
                                     self.buildFetchTicketsSortOrderQueryItem(ascending: ascending)]
        
        return (urlComponents?.url)!
    }
    
    fileprivate class func buildFetchTicketsSortByQueryItem(sortBy: TicketSortOrderOption) -> URLQueryItem {
        let queryItem: URLQueryItem!
        
        switch sortBy {
        case .id:
            queryItem = URLQueryItem(name: kTicketDefaultServiceFetchTicketSortByQueryKey,
                                     value: FetchTicketQuerySort.id.rawValue)
        case .subject:
            queryItem = URLQueryItem(name: kTicketDefaultServiceFetchTicketSortByQueryKey,
                                     value: FetchTicketQuerySort.subject.rawValue)
        case .status:
            queryItem = URLQueryItem(name: kTicketDefaultServiceFetchTicketSortByQueryKey,
                                     value: FetchTicketQuerySort.status.rawValue)
        }
        
        return queryItem
    }
    
    fileprivate class func buildFetchTicketsSortOrderQueryItem(ascending: Bool) -> URLQueryItem {
        let queryItem: URLQueryItem!
        
        if ascending {
            queryItem = URLQueryItem(name: kTicketDefaultServiceFetchTicketSortOrderQueryKey,
                                     value: kTicketDefaultServiceFetchTicketSortOrderQueryAscending)
        }
        else {
            queryItem = URLQueryItem(name: kTicketDefaultServiceFetchTicketSortOrderQueryKey,
                                     value: kTicketDefaultServiceFetchTicketSortOrderQueryDescending)
        }
        
        return queryItem
    }
    
    fileprivate class func buildFetchTicketHeaders() -> [String: String] {
        let requestHeaderSerializer = RequestHeaderSerializer()
        requestHeaderSerializer.setAutherizationHeader(username: kTicketDefaultServiceCredentialsUsername,
                                                       password: kTicketDefaultServiceCredentialsPassword)
        return requestHeaderSerializer.headers
    }
    
    fileprivate class func buildError(code: Int) -> NSError {
        let error = NSError(domain: kTicketDefaultServiceErrorDomain,
                            code: code,
                            userInfo: nil)
        return error
    }
}
