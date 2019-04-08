//
//  TrailsidePlaygroundUITests.swift
//  TrailsidePlaygroundUITests
//
//  Created by Yuchen Nie on 4/6/19.
//  Copyright © 2019 Yuchen Nie. All rights reserved.
//

import XCTest

class TrailsidePlaygroundUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSaveFavorites() {
        let app = XCUIApplication()
        let searchField = app.searchFields["Search for a movie!"]
        searchField.tap()
        searchField.typeText("jurassic")

        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Jurassic World"]/*[[".cells[\"The Jurassic World theme park lets guests experience the thrill of witnessing actual dinosaurs, but something ferocious lurks behind the park's attractions – a genetically modified dinosaur with savage capabilities.  When the massive creature escapes, chaos erupts across the island.  Now it's up to Owen (Chris Pratt) and Claire (Bryce Dallas Howard) to save the park's tourists from an all-out prehistoric assault., Jurassic World, Colin Trevorrow, Released: Jun 12, 2015, PG-13, 124 minutes\"].staticTexts[\"Jurassic World\"]",".cells[\"MovieResultCellJurassicWorld\"].staticTexts[\"Jurassic World\"]",".staticTexts[\"Jurassic World\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let jurassicWorldStaticText = app.tables/*@START_MENU_TOKEN@*/.staticTexts["Jurassic World"]/*[[".cells[\"The Jurassic World theme park lets guests experience the thrill of witnessing actual dinosaurs, but something ferocious lurks behind the park's attractions – a genetically modified dinosaur with savage capabilities.  When the massive creature escapes, chaos erupts across the island.  Now it's up to Owen (Chris Pratt) and Claire (Bryce Dallas Howard) to save the park's tourists from an all-out prehistoric assault., Jurassic World, Colin Trevorrow, Released: Jun 12, 2015, PG-13, 124 minutes\"].staticTexts[\"Jurassic World\"]",".cells[\"MovieResultCellJurassicWorld\"].staticTexts[\"Jurassic World\"]",".staticTexts[\"Jurassic World\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        app.scrollViews.otherElements/*@START_MENU_TOKEN@*/.buttons["FavoritesButton"]/*[[".buttons[\"Already in Favorites\"]",".buttons[\"FavoritesButton\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app.navigationBars["Jurassic World"].buttons["Search iTunes Movies"].tap()
        app.navigationBars["Search iTunes Movies"].buttons["Favorites"].tap()
        jurassicWorldStaticText.tap()
    }
}
