Feature: List Current Shift per site
    # validate schema
    # get current site 1 shift ID
    # get current site 2 shift ID
    # get current site 3 shift ID

Background:
    * def payload = read('classpath:queries/shifts/listShifts.graphql')
    * def currentDate = commonUtils.currentTimeStamp()

@smoke
Scenario: Validate listShift Schema
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "site": '#(site3Id)', "shiftDate": '#(currentDate)' }
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # Set schema validation
    * def schemaValidation =
    """
    {
        "data": {
            "listShifts": [
                {
                    "id": '#(guidRegex)',
                    "name": '#string',
                    "start": '#(timeStampRegex)'
                }   
            ]
        }
    }
    """

    # base assertions - can we lump together? TODO:
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Assert response object matches schema .json file
    * match response == schemaValidation

Scenario: Get and return current site 3 shiftId
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "site": '#(site3Id)', "shiftDate": '#(currentDate)' }
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions - data chnages frequently, cannot do like for like assertions
    * match response.data.listShifts != null // response is not empty
    * match response.data.listShifts[0].id  == '#(guidRegex)'