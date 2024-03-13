Feature: Get current shiftId

Background:
    * def payload = read('classpath:queries/shifts/listShifts.graphql')
    * def currentDate = commonUtils.currentTimeStamp()

@ignore
Scenario: Get and return current shiftId
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "site": '#(site2Id)', "shiftDate": '#(currentDate)' }
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    Then status 200

    * def shiftId2 = response.data.listShifts[0].id