//
// AppEventsRequestBodyTests.swift
//
// Copyright © 2020 Button, Inc. All rights reserved. (https://usebutton.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//

import XCTest
@testable import ButtonMerchant

class AppEventsRequestBodyTests: XCTestCase {
    
    func testInitialization_createsInstance() {
        let event = AppEvent(name: "test-event",
                             value: ["url": "https://example.com"],
                             attributionToken: "some token",
                             time: "2019-07-25T21:30:02.844Z",
                             uuid: "3b3024dc-e56f-412e-8015-5c2c308126fd",
                             source: .button)
        let body = AppEventsRequestBody(ifa: "some ifa", events: [event], currentTime: "some time")
        
        XCTAssertEqual(body.ifa, "some ifa")
        XCTAssertEqual(body.currentTime, "some time")
        XCTAssertEqual(body.events.count, 1)
        XCTAssertEqual(body.events.first?.name, "test-event")
        XCTAssertEqual(body.events.first?.value, ["url": "https://example.com"])
        XCTAssertEqual(body.events.first?.attributionToken, "some token")
        XCTAssertEqual(body.events.first?.time, "2019-07-25T21:30:02.844Z")
        XCTAssertEqual(body.events.first?.uuid, "3b3024dc-e56f-412e-8015-5c2c308126fd")
        XCTAssertEqual(body.events.first?.source, .button)
    }
    
    func testSerialization_createsDisctionary() {
        let event = AppEvent(name: "test-event",
                             value: ["url": "https://example.com"],
                             attributionToken: "some token",
                             time: "2019-07-25T21:30:02.844Z",
                             uuid: "3b3024dc-e56f-412e-8015-5c2c308126fd",
                             source: .button)
        let body = AppEventsRequestBody(ifa: "some ifa", events: [event], currentTime: "some time")
        
        XCTAssertEqual(body.dictionaryRepresentation as NSDictionary,
                       [
                        "ifa": "some ifa",
                        "current_time": "some time",
                        "events": [
                            [
                                "name": "test-event",
                                "value": ["url": "https://example.com"],
                                "source_token": "some token",
                                "time": "2019-07-25T21:30:02.844Z",
                                "uuid": "3b3024dc-e56f-412e-8015-5c2c308126fd",
                                "source": "button"
                            ]
                        ]])
    }
    
    func testMissingIFA_omitsIFA() {
        let event = AppEvent(name: "test-event",
                             value: ["url": "https://example.com"],
                             attributionToken: "some token",
                             time: "2019-07-25T21:30:02.844Z",
                             uuid: "3b3024dc-e56f-412e-8015-5c2c308126fd",
                             source: .button)
        let body = AppEventsRequestBody(ifa: nil, events: [event], currentTime: "some time")
        
        XCTAssertEqual(body.dictionaryRepresentation as NSDictionary,
                       [
                        "current_time": "some time",
                        "events": [
                            [
                                "name": "test-event",
                                "value": ["url": "https://example.com"],
                                "source_token": "some token",
                                "time": "2019-07-25T21:30:02.844Z",
                                "uuid": "3b3024dc-e56f-412e-8015-5c2c308126fd",
                                "source": "button"
                            ]
                        ]])
    }
}
