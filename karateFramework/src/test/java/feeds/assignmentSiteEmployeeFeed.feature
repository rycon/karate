Feature: assignmentSiteEmployee Feed tests

# Test Steps:
    # validate schema
    # listShiftOperationDetails for Admin user
    # repeat listShiftOperationDetails for mine site user (new scenario)
    # repeat for site 2 (new scenario)
    # repeat for site 3 (new scenario)

Background:
    * url baseUrl
    * def payload = read('classpath:queries/feeds/assignmentEmployeeFeed.graphql')

@smoke
    Scenario: Validate assignmentEmployeeFeed Schema
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "a665cd80-51ce-4434-b44f-b504e0b18e6c", "lastUpdateAt": 0, "limit": 1}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # Set schema validation
    # TODO breakout in to a data file
    # a preceeding ## will assert "blank or this type" 
    * def schemaValidation =
        """
            {
                "data": {
                    "assignmentEmployeeFeed": [
                        {
                            "id": '#(guidRegex)',
                            "assignmentId": '#(guidRegex)',
                            "siteEmployeeId": '#(guidRegex)',
                            "assignmentRoleId": '#(guidRegex)',
                            "comment": '## #string',
                            "updatedAt": '#number',
                            "isDeleted": '#boolean',
                            "version": '#number'
                        }   
                    ]
                }
            }
        """

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Assert response object matches schema
    * match response == schemaValidation

@positive
Scenario: Return assignmentEmployeeFeed Details as Admin user - Limit 1
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "a665cd80-51ce-4434-b44f-b504e0b18e6c", "lastUpdateAt": 0, "limit": 1}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.data.assignmentEmployeeFeed != null // response is not empty
    * match response.data.assignmentEmployeeFeed[0].comment  == null
    * match response.data.assignmentEmployeeFeed[0].id  == '#(guidRegex)' //regex assertion as ID changes frequently

@positive
Scenario: Return assignmentEmployeeFeed Details as Admin user - Limit 10
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "a665cd80-51ce-4434-b44f-b504e0b18e6c", "lastUpdateAt": 0, "limit": 10}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.data.assignmentEmployeeFeed != null // response is not empty
    * match response.data.assignmentEmployeeFeed[0].comment  == null
    * match response.data.assignmentEmployeeFeed[0].id  == '#(guidRegex)'

@positive
Scenario: Return empty assignmentEmployeeFeed array as Admin user - lastUpdateAt current time
    Given url baseUrl
    And header Authorization = adminAuth
    * def currentDate = commonUtils.currentUnixTime()
    And def variables = { "equipmentId": "a665cd80-51ce-4434-b44f-b504e0b18e6c", "lastUpdateAt": '#(currentDate)', "limit": 1}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //error object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.data.assignmentEmployeeFeed == '#present'
    * match response.data.assignmentEmployeeFeed[0].id  == '#notpresent'

@positive
Scenario: Invalid equipmentId returns empty array
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "afffcff0-51ce-ffff-ff4f-b504e0b1ffff", "lastUpdateAt": 0, "limit": 10}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#notpresent' //errors object not returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.data.assignmentEmployeeFeed == '#present'
    * match response.data.assignmentEmployeeFeed[0].id  == '#notpresent'

@negative
Scenario: Negative - equipmentId is required
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "lastUpdateAt": 0, "limit": 10 }
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#present' //error object returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.errors[0].message  == "Variable 'equipmentId' has coerced Null value for NonNull type 'ID!'"

@negative
Scenario: Negative - lastUpdateAt is requird
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "afffcff0-51ce-ffff-ff4f-b504e0b1ffff", "limit": 10}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#present' //error object returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.errors[0].message  == "Variable 'lastUpdateAt' has coerced Null value for NonNull type 'Float!'"

@negative
Scenario: Negative - limit is requird
    Given url baseUrl
    And header Authorization = adminAuth
    And def variables = { "equipmentId": "afffcff0-51ce-ffff-ff4f-b504e0b1ffff", "lastUpdateAt": 0}
    Then request { query: '#(payload)', variables: '#(variables)' }
    When method post

    # base assertions
    * status 200
    * match response.errors == '#present' //error object returned
    * assert responseTime < baseResponseTime

    # Test specific assertions
    * match response.errors[0].message  == "Variable 'limit' has coerced Null value for NonNull type 'Int!'"