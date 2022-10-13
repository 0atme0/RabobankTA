//
//  CSVParserTests.swift
//  RabobankTATests
//
//  Created by atme on 10/10/2022.
//

import XCTest
@testable import RabobankTA

public let emptyColumns = "Year,Make,Model,Description,Price\r\n1997,Ford,,descrition,3000.00\r\n1999,Chevy,Venture,another description,\r\n"

public let newLineSeparation = "Year,Make,Model,Description,Price\r\n1997,Ford,E350,descrition,3000.00\r\n1999,Chevy,Venture,another description,4900.00\r\n"

public let newLineSeparationNoCR = "Year,Make,Model,Description,Price\n1997,Ford,E350,descrition,3000.00\n1999,Chevy,Venture,another description,4900.00\n"

public let newLineSeparationNoEnd = "Year,Make,Model,Description,Price\r\n1997,Ford,E350,descrition,3000.00\r\n1999,Chevy,Venture,another description,4900.00"

public let withoutHeader = "1997,Ford,E350,descrition,3000.00\r\n1999,Chevy,Venture,another description,4900.00"

public let longerColumns = "Year,Make,Model,Description,Price\r\n1997,Ford,E350,descrition,3000.00\r\n1999,Chevy,Venture,another description,4900.00,extra column\r\n"

public let withRandomQuotes = "1996,Ford,E350,\"Super, \"\"luxurious\"\" truck\""

public let withQuotesInQuotes = "Year,Make,Model,Description,Price\r\n1997,Ford,\"E350\",descrition,3000.00\r\n1999,Chevy,Venture,\"another, \"\"amazing\"\", description\",4900.00"

public let withNewLinesInQuotes = "Year,Make,Model,Description,Price\n1997,Ford,\"E350\",descrition,3000.00\n1999,Chevy,Venture,\"another, \"\"amazing\"\",\n\ndescription\n\",4900.00\n"

public let withTabSeparator = "Year\tMake\tModel\tDescription\tPrice\r\n1997\tFord\t\"E350\"\tdescrition\t3000.00\r\n1999\tChevy\tVenture\t\"another\t \"\"amazing\"\"\t description\"\t4900.00\r\n"

public let singleString = "1999,Chevy,Venture,\"another, \"\"amazing\"\",\n\ndescription\n\",4900.00"

final class CSVParserests: XCTestCase {
    
    var testString: String!
    let csvParser = CSVParser()
    
    func testThatItParsesLinesSeperatedByNewLines() {
        testString = newLineSeparation
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another description","4900.00"]
        ]
        
        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
    }
    
    func testThatItParsesLinesSeperatedByNewLinesNoCR() {
        testString = newLineSeparationNoCR
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another description","4900.00"]
        ]
        
        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
    }
    
    func testThatItParsesLinesSeperatedByNewLinesWithoutNewLineAtEnd() {
        
        testString = newLineSeparationNoEnd
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another description","4900.00"]
        ]
        
        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
    }

    func testThatItParsesHeadersCorrectly() {
        
        testString = newLineSeparationNoEnd
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let header = tableEntity.columnsInHeader?.values
        let expectedArray = ["Year","Make","Model","Description","Price"]
        
        XCTAssertEqual(header, expectedArray)
        
    }
    
    func testThatItParsesRowsWithoutHeaders() {

        testString = withoutHeader

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)}, withHeader: false)
        let header = tableEntity.columnsInHeader?.values
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another description","4900.00"]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
        XCTAssertNil(header)

    }
    
    func testThatItParsesRowsLongerThanHeaders() {

        testString = longerColumns
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another description","4900.00","extra column"]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])

        let expectedKeyedRows = [
            ["Year":"1997", "Make": "Ford", "Model": "E350", "Description": "descrition", "Price":"3000.00"],
            ["Year":"1999", "Make": "Chevy", "Model": "Venture", "Description":"another description", "Price":"4900.00"]
        ]

        XCTAssertEqual(tableEntity.keyedRows?[0], expectedKeyedRows[0])
        XCTAssertEqual(tableEntity.keyedRows?[1], expectedKeyedRows[1])
    }

    func testThatItParsesFieldswithQuotes() {

        testString = withRandomQuotes

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)}, withHeader: false)
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1996","Ford","E350","Super, \"luxurious\" truck"]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
    }
    
    func testThatItParsesFieldswithNewLinesInQuotes() {

        testString = withNewLinesInQuotes

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another, \"amazing\",\n\ndescription\n","4900.00"]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
    }

    func testThatItParsesFieldswithQuotesInQuotes() {

        testString = withQuotesInQuotes

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader

        let expectedArray = [
            ["1997","Ford","E350","descrition","3000.00"],
            ["1999","Chevy","Venture","another, \"amazing\", description","4900.00"]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])
    }

    func testThatCanReturnKeyedRows() {

        testString = withQuotesInQuotes

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let keyed = tableEntity.keyedRows

        let expectedArray = [
            ["Year":"1997","Make":"Ford","Model":"E350","Description":"descrition","Price":"3000.00"],
            ["Year":"1999","Make":"Chevy","Model":"Venture","Description":"another, \"amazing\", description","Price":"4900.00"]
        ]

        XCTAssertEqual(keyed?[0], expectedArray[0])
        XCTAssertEqual(keyed?[1], expectedArray[1])
    }

    func testThatItCanParseArbitrarySeparators() {

        testString = withTabSeparator
        
        let csv = csvParser.parseCsv(testString, separator: "\t")
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let keyed = tableEntity.keyedRows


        let expectedArray = [
            ["Year":"1997","Make":"Ford","Model":"E350","Description":"descrition","Price":"3000.00"],
            ["Year":"1999","Make":"Chevy","Model":"Venture","Description":"another\t \"amazing\"\t description","Price":"4900.00"]
        ]

        XCTAssertEqual(keyed?[0], expectedArray[0])
        XCTAssertEqual(keyed?[1], expectedArray[1])
    }

    func testThatItCanGetCells() {
        testString = singleString

        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let rows = tableEntity.columnsInHeader

        let expectedArray = [
            "1999",
            "Chevy",
            "Venture",
            "another, \"amazing\",\n\ndescription\n",
            "4900.00"
        ]

        XCTAssertEqual(rows?.values, expectedArray)
    }

    func testWhenCellsAreEmpty() {

        testString = emptyColumns
        
        let csv = csvParser.parseCsv(testString)
        let tableEntity = TableEntity(rows: csv.map{RowEntity(values: $0)})
        let body = tableEntity.rowsWOHeader
        let keyed = tableEntity.keyedRows
        
        let expectedArray = [
            ["1997","Ford","","descrition","3000.00"],
            ["1999","Chevy","Venture","another description",""]
        ]

        XCTAssertEqual(body[0].values, expectedArray[0])
        XCTAssertEqual(body[1].values, expectedArray[1])

        let expectedKeyedRows = [
            ["Year":"1997", "Make": "Ford", "Description":"descrition", "Price":"3000.00"],
            ["Year":"1999", "Make": "Chevy", "Model":"Venture", "Description":"another description"]
        ]

        XCTAssertEqual(keyed?[0], expectedKeyedRows[0])
        XCTAssertEqual(keyed?[1], expectedKeyedRows[1])
    }
    
}
