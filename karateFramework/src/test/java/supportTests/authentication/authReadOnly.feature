Feature: Admin Auth Token Genreation

Background:
    * url authUrl
    * configure ssl = true

Scenario: Admin Auth
    * path 'token'
    * form field client_id = clientId // pulls client_id from the karate-config-{env}.js file
    * form field grant_type = 'refresh_token'
    * form field refresh_token = readOnlyRefreshToken // pulls client_id from the karate-config-{env}.js file
 
    When method post
    Then status 200

    * def readOnlyAccessToken = response.id_token