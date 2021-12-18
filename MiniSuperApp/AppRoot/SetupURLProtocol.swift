//
//  SetupURLProtocol.swift
//  MiniSuperApp
//
//  Created by Damor on 2021/12/18.
//

import Foundation

func setupURLProtocol() {
    let topupResponse: [String: Any] = [
        "status": "success"
    ]
    
    let topupResponseData = try! JSONSerialization.data(withJSONObject: topupResponse, options: [])
    
    //AddCard
    let addCardResponse: [String: Any] = [
        "card": [
            "id": "999",
            "name": "새 카드",
            "digits": "**** 0101",
            "color": "",
            "isPrimary": false
        ]
    ]
    
    let addCardResponseData = try! JSONSerialization.data(withJSONObject: addCardResponse, options: [])
    
    //CardOnFile
    let cardOnFileResponse: [String: Any] = [
        "cards": [
            [
                "id": "0",
                "name": "우리은행",
                "digits": "0123",
                "color": "#f19a38ff",
                "isPrimary": false
            ],
            [
                "id": "1",
                "name": "신한은행",
                "digits": "0937",
                "color": "#f23338ff",
                "isPrimary": false
            ],
            [
                "id": "2",
                "name": "국민은행",
                "digits": "6223",
                "color": "#65c466ff",
                "isPrimary": false
            ],
        ]
    ]
    
    let cardOnFileResponseData = try! JSONSerialization.data(withJSONObject: cardOnFileResponse, options: [])
    
    SuperAppURLProtocol.successMock = [
        "/api/v1/topup": (200, topupResponseData),
        "/api/v1/addCard": (200, addCardResponseData),
        "/api/v1/cards": (200, cardOnFileResponseData),
    ]
}
