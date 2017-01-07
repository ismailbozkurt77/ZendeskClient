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


let kTicketDefaultServicefetchTicketPath = "/views/39551161/tickets.json"

let kTicketDefaultServiceFetchResponseTicketKey = "tickets"

let kTicketDefaultServiceErrorDomain = "com.ismail.bozkurt.zendesk.client.ticket.service.error"
let kTicketDefaultServiceJSONSerializationErrorCode = -10000
let kTicketDefaultServiceInvalidJSONContentErrorCode = -10001

class TicketDefaultService: NSObject, TicketService {
    
    // MARK: - Properties
    private var restClient: RestClient
    
    // MARK: - Life cycle
    init(restClient: RestClient) {
        self.restClient = restClient
    }
    
    // MARK: - TicketService
    
    @discardableResult
    func fetchTickets(completion: @escaping TicketServiceFetchTicketCompletion) -> URLSessionTask {
        let url = self.buildFetchTicketUrl()
        let auhtHeader = self.buildFetchTicketHeaders()
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
                completion(nil, self.buildError(code: kTicketDefaultServiceInvalidJSONContentErrorCode))
                return
            }
            
            let responseData: [String: Any]!
            do {
                responseData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
            } catch {
                completion(nil, self.buildError(code: kTicketDefaultServiceJSONSerializationErrorCode))
                return
            }
            
            guard let ticketsJSON = responseData[kTicketDefaultServiceFetchResponseTicketKey] as? [[String: Any]] else {
                completion(nil, self.buildError(code: kTicketDefaultServiceInvalidJSONContentErrorCode))
                return
            }
            
            let tickets = Mapper<Ticket>().mapArray(JSONArray: ticketsJSON)
            completion(tickets, error)
        }
    }

    // MARK: - Private Factory

    fileprivate func buildFetchTicketUrl() -> URL {
        let baseUrl = EndPointFactory.baseUrl()
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        urlComponents?.path += kTicketDefaultServicefetchTicketPath
        
        return (urlComponents?.url)!
    }
    
    fileprivate func buildFetchTicketHeaders() -> [String: String] {
        let requestHeaderSerializer = RequestHeaderSerializer()
        requestHeaderSerializer.setAutherizationHeader(username: "acooke+techtest@zendesk.com",
                                                       password: "mobile")
        return requestHeaderSerializer.headers
    }
    
    fileprivate func buildError(code: Int) -> NSError {
        let error = NSError(domain: kTicketDefaultServiceErrorDomain,
                            code: code,
                            userInfo: nil)
        return error
    }
}
