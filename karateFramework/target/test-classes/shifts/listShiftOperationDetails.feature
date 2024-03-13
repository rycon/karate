Feature: Scenario - listShiftperationDetails
    # validate schema
    # listShiftOperationDetails for Admin user
    # repeat listShiftOperationDetails for mine site user (new scenario)
    # repeat for site 2 (new scenario)
    # repeat for site 3 (new scenario)

Background:
    * def listShiftPayload = read('classpath:queries/shifts/listShifts.graphql')
    * def listShiftOperationDetailsPayload = read('classpath:queries/shifts/listShiftOperationDetails.graphql')
    * def currentDate = commonUtils.currentTimeStamp()

@smoke
Scenario: Validate listShiftOperationDetails Schema
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "shiftId": '#(currentShift)' }
    And request { query: '#(listShiftOperationDetailsPayload)', variables: '#(variables)' }
    When method post

    # Set schema validation - example where endoint returns multiple objects in the respnse array
    * def schemaValidation = { "createdOn": '#(timeStampRegex)', "name": '#string', "units": '#string', "value": '##number'}

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Assert response object matches schema .json file
    * match response.data.listShiftOperationDetails[*] contains schemaValidation

Scenario: Get and return current site 2 shiftId for Admin user
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "shiftId": '#(currentShift)' }
    And request { query: '#(listShiftOperationDetailsPayload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.data.listShiftOperationDetails != null // response is not empty
    * match response.data.listShiftOperationDetails[0].units == 't'
    * match response.data.listShiftOperationDetails[3].units == 't/hr'
    * match response.data.listShiftOperationDetails !contains "Tonnes skipped"
