Feature: Do a full end to end run on the endpoint against https://reqres.in/

# Test Steps:
    # create a new user using a post request
    # use id from post request to make patch/put request
    # do get request to return updated data

# This is not the best example as the get request at the end is returning 404, but the basic idea is there

Background:
    * url restUrl
    * def fakerOj = new faker()

@smoke
Scenario: Create a new user, update the user, and verify the update - using inline payload
    Given path '/users'
    And def fName = fakerObj.name().firstName()
    And def payload = '{ "name": "#(fName)", "job": "leader" }'
    And request payload
    When method post

    # Basic assertions
    Then status 201
    And assert responseTime < 7000

    # assertions
    Then match $.id == '#present'

    Then def id = $.id

    # use id returned from above to do an patch
    Given path '/users/{id}'.replace('{id}', id)
    And def payload = '{ "name": "#(fName)", "job": "patch" }'
    And request payload
    When method patch

    # Basic assertions
    * status 200
    * assert responseTime < 7000

    # assertions
    * match $.updatedAt == '#present'

    # use id from initial post to get the updaed user details
    Given path '/users/{id}'.replace('{id}', id)
    When method get

    # Basic assertions
    * assert responseTime < 7000

@smoke
Scenario: Create a new user, update the user, and verify the update - using json file
    Given path '/users'
    And def fName = fakerObj.name().firstName()
    Then def payload = read('reqres.json')
    Then replace payload.name = "#(fName)"
    Then replace payload.job = "leader"
    And request payload
    When method post

    # Basic assertions
    Then status 201
    And assert responseTime < 7000

    # assertions
    Then match $.id == '#present'

    Then def id = $.id

    # use id returned from above to do an patch
    And def fName = fakerObj.name().firstName()
    Given path '/users/{id}'.replace('{id}', id)
    And def payload = '{ "name": "#(fName)", "job": "patch" }'
    And request payload
    When method patch

    # Basic assertions
    * status 200
    * assert responseTime < 7000

    # assertions
    * match $.updatedAt == '#present'

    # use id from initial post to get the updaed user details
    Given path '/users/{id}'.replace('{id}', id)
    When method get

    # Basic assertions
    * assert responseTime < 7000