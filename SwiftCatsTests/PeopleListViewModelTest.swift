//
//  PeopleListViewModelTest.swift
//  SwiftCatsTests
//
//  Created by Ajina Raju George on 4/21/20.
//  Copyright © 2020 Yilei He. All rights reserved.
//

import XCTest
@testable import  SwiftCats

class PeopleListViewModelTest: XCTestCase {
    var subject: PeopleListViewModel!
    var mockNetworkServiceClient: MockNetworkServiceSuccessStub!

    override func setUp() {
        mockNetworkServiceClient = MockNetworkServiceSuccessStub()
        subject = PeopleListViewModel(networkService: mockNetworkServiceClient)
    }

    override func tearDown() {
        mockNetworkServiceClient = nil
        subject = nil
    }

    func testNumberofSections() {
        subject.fetchPeopleList()
        XCTAssertEqual(subject.numberOfSections, 2)
    }

    func testNumberOfCats_maleSection() {
        subject.fetchPeopleList()
        XCTAssertEqual(subject.numberOfRowsinSection(at: 0), 4)
    }
   
    func testNumberOfCats_femaleSection() {
        subject.fetchPeopleList()
        XCTAssertEqual(subject.numberOfRowsinSection(at: 1), 3)
    }

    func testGenderSectionTitle() {
        subject.fetchPeopleList()
        XCTAssertEqual(subject.sectionTitle(at: 0), "Male")
        XCTAssertEqual(subject.sectionTitle(at: 1), "Female")
    }
    
    func testCatNames_forFeMaleSection() {
        subject.fetchPeopleList()
        XCTAssertEqual(subject.titleForRow(at: 0, in: 0),"Garfield")
    }
    
    func testViewModelTriggerCallbackIsCalledWhenFailureScene() {
        let mockAPIClient = MockNetworkServiceFailureStub()
        let exp = expectation(description: "Trigger should complete")
        mockAPIClient.getPeople { _ in exp.fulfill()}
        waitForExpectations(timeout: 0.01)
        XCTAssertEqual(subject.peopleCellViewModel.count, 0)
    }
    
    func testNoOFCellWhenNoServerResponse() {
        let mockAPIErrorClient = MockNetworkServiceFailureStub()
        subject =  PeopleListViewModel(networkService: mockAPIErrorClient)
        subject.fetchPeopleList()
        XCTAssertEqual(subject.numberOfSections, 0)
    }
}
