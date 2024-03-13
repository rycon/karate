# Karate Framework
## What is this repo?
This repo contains a proof of concept that I created in my spare time. I created it to see if we could replace our Postman tests with something better. I have other PoC's as well. Some are a more work in progress than others.

Below are the notes I captured while researching, and the instructions were intended for others to follow. I have included some config files that would normally be in the .gitignore as they typically would contain tokens and other sensitive data.

The only tests in this repo that should run and pass are the PoC REST tests.

I never got a chance to get everything working as I would have liked. I wanted to get the schema's into json files, investigate some other auth options. I also wanted to get the test data into their own files and create simple requests that would look through the test data. 

I never got the Java packages working, as it would be cool to leverage the vast number of java packages out there, especially tools such as Faker.

This Readme is pretty big, and I had intended to break the details out into a Github wiki.

## What is Karate?
Karate is an open-source tool to combine API test-automation, mocks, performance-testing and UI automation into a single, unified framework. The BDD syntax popularized by Cucumber is language-neutral, and easy for even non-programmers to read. Assertions and HTML reports are built-in, and you can run tests in parallel for speed.

<p> The main focus at this moment is our GraphQL automation, to see if this is a suitable replacement for Postman. I don't see this replacing specFlow for UI Automation, although it certainly could.

<p> One thing I've liked while reading and learning more about the approach Intuit is taking with Karate, is that while they are using the BDD syntax, they are not expecting non-technical users to write tests. The idea with the BDD syntax is to keep the coding simple and straight forward without the need to write custom code behind the steps like you would see in Cucumber. All while keeping the framework flexible and allowing the test engineer to write custom code in Java or JaveScript if required. As someone with little programming experience, I was able to setup a new project, write tests, and write custom java code in about 40 hours.

<p>Below are the steps and learning I've had while setting up this PoC, there are details on creating a new project, steps a QA would follow to get setup to write tests, best practices, examples, how-to's, and other details I've captured while doing this PoC. This PoC could also be used as a template for projects to start from or learn from.

- [Karate Framework](#karate-framework)
  - [What is this repo?](#what-is-this-repo)
  - [What is Karate?](#what-is-karate)
  - [Installations](#installations)
    - [Install Java 11](#install-java-11)
    - [Install Maven](#install-maven)
    - [Install Git](#install-git)
    - [Install Visual Studio Code](#install-visual-studio-code)
    - [Install VSCode Extensions](#install-vscode-extensions)
        - [Required](#required)
        - [(Highly) Suggested](#highly-suggested)
        - [Other](#other)
    - [Configure KarateIDE Plugin](#configure-karateide-plugin)
      - [Set Test Environment](#set-test-environment)
  - [New Project Setup](#new-project-setup)
    - [karate-config.js file](#karate-configjs-file)
    - [karate-config-.js](#karate-config-js)
    - [Suggested Folder Setup](#suggested-folder-setup)
    - [Parallel Test Execution](#parallel-test-execution)
    - [AWS Credentials](#aws-credentials)
    - [.gitignore file](#gitignore-file)
    - [Future considerations for custom utils](#future-considerations-for-custom-utils)
  - [Writing Tests](#writing-tests)
    - [Testing an endpoint prior to writing your scenario tests](#testing-an-endpoint-prior-to-writing-your-scenario-tests)
    - [.Feature files](#feature-files)
      - [Test variables and referencing test data in another file](#test-variables-and-referencing-test-data-in-another-file)
    - [Test data files](#test-data-files)
      - [GraphQL requests](#graphql-requests)
      - [Writing assertions](#writing-assertions)
      - [Schema Validation](#schema-validation)
      - [Test tags](#test-tags)
    - [Test Loops](#test-loops)
    - [testRunner.java](#testrunnerjava)
    - [Business flow scenarios](#business-flow-scenarios)
  - [Test setup and teardown](#test-setup-and-teardown)
  - [Running Tests](#running-tests)
    - [From the terminal (cli)](#from-the-terminal-cli)
    - [From VSCode](#from-vscode)
    - [Linting and Code Best Practices](#linting-and-code-best-practices)
  - [Test Reports](#test-reports)
  - [Test Environments](#test-environments)
  - [Training](#training)
  - [Solutions to potential problems](#solutions-to-potential-problems)
    - [Java Certificate](#java-certificate)
    - [ClassPath](#classpath)
      - [Set Classpath in VScode](#set-classpath-in-vscode)
  - [Future considerations](#future-considerations)
  - [Resources Used](#resources-used)

## Installations
<strong>This section will need to be completed by everyone.</strong>

### Install Java 11
Install Java 11 from [this page](https://www.oracle.com/ca-en/java/technologies/javase/jdk11-archive-downloads.html) for your OS of choice. If you are Windows and are uncertain of what to install, download the Windows x64 Installer. Oracle requires you to create an account to download.

<p> Once installed, verify that Java is in your path. Open your terminal (powershell or terminal for windows) and execute the below command. If you don't receive an error message than Java is successfully installed. If you see an error message, you will need to add java to your path. See Maven install steps below.

<p><strong>Make sure you install the latest java 11 version, Karate does not work on other versions of java. [See this github issue for more details](https://github.com/karatelabs/karate/issues/208). Maven will enforce JDK11, so you will know if you have an incorrect version installed.</strong>

```bash
java -version
```


### Install Maven
Install the latest maven from [this page](https://maven.apache.org/install.html), the download link is at the top right of the page. Download the Binary zip archive.

<p>Follow the installation instructions from the install page. It would be best to extract the folder to C:\Program Files\

<p>Once extracted you will need to add the maven folder location to you PATH. For windows:


1. Press windows key, and search for "Environment Variables"
2. From the "System Properties - Advance" tab click the "Environment Variables" button in the lower right corner
3. From the "Environment Variables" window, click on Path and then the edit button
4. Click the "new" button, and add the Maven file location from above, ex: C:\Program Files\apache-maven-3.x.x\bin
5. While you are here, verify that the java path from the install above is also in your path 
6. You only need to do the above for the "User variables" section
7. Close and then reopen your terminal, and type the below command, if there is no error message, maven is installed correctly

```bash
mvn -v
```

<p> If you are on MacOS or Linux adding to the path is different. We can add instructions if anyone uses these OS's.

### Install Git
Follow the [git install](https://github.com/git-guides/install-git) instructions. Feel free to download the github desktop app as well. While doing git commands from the terminal is easy once you are used to it, the desktop is easy to use as well.

Once installed, make sure your name and email are configured, 

* [github desktop](https://github.com/git-guides/install-git)
* [command line](https://github.com/git-guides/install-git)
* [learn the git commands](https://www.hostinger.com/tutorials/basic-git-commands)
  
### Install Visual Studio Code
Download and install [Visual Studio Code](https://code.visualstudio.com/download)

### Install VSCode Extensions
Once VSCode is installed, install the following extensions.

<p><strong>Make sure to read the details of each extension to get an understanding of what each does.</strong>

##### Required
* Extension pack for Java
* Karate
* karateIDE
* cucumber full support
* Gitlens
* YAML
* GraphQL

##### (Highly) Suggested
* <u>Code spell checker</u>- spell checker
* <u>indent-rainbow</u> - colours the white spaces of an indent, makes it easier to work with json and yaml files
* <u>Rainbow brackets</u> - colours the opening and closing brackets, especially helpful when they are nested
* <u>Open in Browser</u> - right click on HTML reports, click open in browser, and view the report
* <u>TODO tree</u> - see a list of all todo's, fixme', etc. that are in your project, good for reminders on what needs to be fixed or worked on

##### Other
* <u>Markdown all in one</u> - useful collection of tools to view .md files, auto add table of contents, and more!

### Configure KarateIDE Plugin
Once the above steps are completed, you will need to configure the KarateIDE.

#### Set Test Environment
1. From the VSCode left toolbar click on the Karate IDE Icon (A large 'K')
2. At the top of the Karate IDE side menu, there is the executions header
3. Look for an icon labeled Karate Env, click it
4. A VScode dropdown will open, type in the name of your primary test env, in our case stage
5. This will use the stage env credentials (stored in the karate-config-stage.js file)
6. Changing this value will allow you to test against a different env without the need to make changes to a config file


## New Project Setup
<strong>Ignore this section if you are not setting up a new project</strong>

[I suggest reading this git ticket to get some context on why Karate functions the way it does.](https://github.com/karatelabs/karate/issues/398)

<p>These are the steps I followed to get Karate configured for use, <u>this only needs to be done one time per project</u>.

<p>Open your terminal in the folder you want to use for the project, and execute the following command:

<strong>Note:</strong> Make sure to replace X.X.X with the latest version from the [Karate repo](https://github.com/karatelabs/karate), also ensure to set your project name, everything else can remain as per below.

```java
mvn archetype:generate \
-DarchetypeGroupId=com.intuit.karate \
-DarchetypeArtifactId=karate-archetype \
-DarchetypeVersion=X.X.X \
-DgroupId=com.COMPANYNAME \
-DartifactId= {REPLACE WITH PROJECT NAME}
```

### karate-config.js file
This file is used to set Karate configurations such as timeout value's, SSL verification, store common variables, or set environment specific variables. This file should be used for common configurations that are used across many files, such as id's, tokens, etc. You can also reference tests to generate logins tokens, get ID's from endpoints etc. and store them as variables to be referenced in tests.

<p>Karate supports testing across different test environments, see below for details.

<p>Note to self: re-read the section and add more details.

### karate-config-<env>.js
When your project gets complex, you can have separate karate-config-<env>.js files that will be processed for that specific value of karate.env. This is especially useful when you want to maintain passwords, secrets, or even URL-s specific to a test environment.

<p>These files <u>NEED</u> to be part of the .gitignore, and must not be pushed to a git repo. Having these files outside of the repo makes them the ideal place to store sensitive details such as auth credentials.

<p><strong>You will need to share these files with other QA's on your team</strong></p>

### Suggested Folder Setup
It's suggested that you have a folder hierarchy only one or two levels deep - where the folder names clearly identify which 'resource', 'entity' or which API is the web-service under test.

Example folder structure:
```java
📦src
 ┗ 📂test
 ┃ ┣ 📂java
 ┃ ┃ ┣ 📂test_folder_1
 ┃ ┃ ┃ ┣ 📜test1.feature
 ┃ ┃ ┃ ┣ 📜test1_data.json
 ┃ ┃ ┃ ┣ 📜test2.feature
 ┃ ┃ ┃ ┗ 📜testRunner.java
 ┃ ┃ ┣ 📂test_folder_2
 ┃ ┃ ┃ ┣ 📜newTest1.feature
 ┃ ┃ ┃ ┣ 📜newTest1_data.json
 ┃ ┃ ┃ ┣ 📜newTest2.feature
 ┃ ┃ ┃ ┗ 📜testRunner.java
 ┃ ┃ ┣ 📂supportTests
 ┃ ┃ ┃ ┣ 📂uth
 ┃ ┃ ┃ ┃ ┣ 📜authUser1.feature
 ┃ ┃ ┃ ┃ ┗ 📜authUser2.feature
 ┃ ┃ ┃ ┣ 📂utils
 ┃ ┃ ┃ ┃ ┣ 📜commonUtils.java
 ┃ ┃ ┃ ┃ ┗ 📜someMoreUtils.js
 ┃ ┃ ┣ 📜.gitignore
 ┃ ┃ ┣ 📜karate-config-rc.json
 ┃ ┃ ┣ 📜karate-config-stage.json
 ┃ ┃ ┣ 📜karate-config.json
 ┃ ┃ ┗ 📜logback-test.xml
 ┃ ┗ 📂resources
 ┃ ┃ ┗ 📂queries
 ┃ ┃ ┃ ┣ 📜testEndpoint1.graphql
 ┃ ┃ ┃ ┣ 📜testEndpoint2.graphql
 ┃ ┃ ┃ ┣ 📜testEndpoint1.json
 ┃ ┃ ┃ ┗ 📜testEndpoint1.yaml
```
<p>The idea is to have all of the files for an endpoint or scenario together. This will make it clear where test data and other related files live. This could include custom java or javascript classes created only for a specific set of tests, otherwise common java classes should be in a utils folder.

<p>After some thought, I think it's best to have the queries in a separate folder as they are shared across tests. This will make it easier to update as the endpoints change. As per the folder tree above, the resources folder lives next to the java folder and is where I've placed our query .graphQL files.

<p>Common Java and javascript utility files are stored in the utils folder

<p>In order to use the /resources location for your test queries, you need to modify the pom.xml file as per below. Karate has strong feelings around keeping the test data next to the .feature files, but as per above, I think having the queries in 1 place is best. This can always be ignored by you if you feel that the query files belong next to the .feature files.

```xml
        <testResources>
            <testResource>
                <directory>src/test/resources</directory>
                <excludes>
                    <exclude>**/*.java</exclude>
                </excludes>
            </testResource>
        </testResources>
```
<p>We will still keep any test input/output data inline with the .feature file it belongs to.

### Parallel Test Execution
Karate supports running tests in parallel, and if test scenarios are written correctly, we can leverage to drastically cut down on execution time.

TODO: Parallel execution and runner files [Github issue #3]()

[See Karate documentation](https://github.com/karatelabs/karate#parallel-execution)

### AWS Credentials
Can/should we setup the same way as the UI automation? Or do we need to go the postman route? 
<p> We can use karate-config-*.js to specify our credentials, and have those files in our .gitignore file so they aren't pushed to the repo.

<p>Currently I've gone the config file route as it keeps the project, user setup, and test execution more simple.

### .gitignore file
The .gitignore file is used to tell git what files or folders should not be pushed to the repo. Every project attached to a cloud repo needs to have a .gitignore file. At the bare minimum the hidden folders create by a users IDE (.vscode, .intellij, etc.) should be in the ignore file. The hidden folders are used to store the user config for the persons IDE. Since everyone has their IDE configured to their liking, these folders can override what someone has set. Plus having these folders in the repo causes unneeded clutter.

<p>We will need to have the environment specific karate-config-{env}.js files referenced. These files contain the sensitive connection information. .HTML and other report files are also best to have in the .gitignore file as they are also clutter.

[Read more about the .gitignore file](https://www.freecodecamp.org/news/gitignore-what-is-it-and-how-to-add-to-repo/)

### Future considerations for custom utils
We could look at creating a QA package that can be referenced by Maven with common Java classes to be shared across projects. I have no experience with this. We could also hosts our own package repo with known stable versions for us to pull from. This would help us share utilities without the need for all projects to share a test code base like we do with UI automation. 

TODO: Package common utils [Github issue #7]()

## Writing Tests
Unlike other BDD frameworks that are based on Cucumber where the step directions must be written prior to building the .feature files, Karate has the majority of the step directions already written. All we need to do is call the step and add our data as per the test.

<p>There are likely a few custom step we will need to write, such as our auth call, but we likely won't need much.

### Testing an endpoint prior to writing your scenario tests
It's best to test your endpoint prior to or during writing your automation tests. This will allow you to be more familiar with the endpoint, build the call payload, and put the endpoint through it's paces. You will catch bugs faster this way, and will allow you to get a good understanding of what to automate. And more importantly, what not/cannot be automated.

I would suggest using [Insomnia](https://insomnia.rest/) rather than Postman to do your initial tests of your API as Postman has become very bloated and slow. The main benefit to Insomnia is it's graphQL implementation. Insomnia will pull the schema and other details directly from your project endpoint. This will allow auto complete, schema reference, and other features that Postman lacks.

### .Feature files
These files are where the test cases per endpoint are written. They follow the Cucumber (BDD) format of Give, When, Then. It's best to keep all test scenarios for an endpoint under test within one .feature file. 

<p>Each test scenario within the .feature file should test a specific outcome. It's best to refrain from having one scenario cover multiple test outcomes. By doing this, we make the intention of each test scenario very clear. This is reflected in reporting, and makes maintenance of failed tests much easier.

<p>Say a test scenario is leaving all mandatory fields blank, if that test fails, you need to evaluate all assertions to see where the failure is. If the scenario only covers ones missing mandatory field, than the evaluation is much easier to perform.

[See Karate documentation](https://github.com/karatelabs/karate#syntax-guide) to learn more about writing .feature files.

#### Test variables and referencing test data in another file
The Background section of the .feature file is used to set variables for data that is common to all tests within the .feature file. For example, you can reference the baseUrl from the karate-config_{env}.js file rather than having a hardcoded value. You can also store your graphQL requests in a .graphql file. If the url changes, we only need to update it in one place. Same with the graphQL call, if it changes, we only need to make one update.

<p>It's best practice to store common details in a config file, if these details change, we only have to make a change in one place.

Example:
```gherkin
Background:
    * url baseUrl // gets value from the karate-config.js file
    * header Accept = 'application/json' //headers can be specified for one off's
    * def baseResponseTime expectedResponseTime // get's the response time from the karate-config.js file 

    // Define graphQL payload's for use in below tests
    * def teasQuery = read('classpath:queries/allTeas.graphql')
    * def teaByNameQuery = read('classpath:queries/teaByName.graphql')
```

TODO: Add details around how to best build a .feature file, the sections, how data can be used to execute multiple tests off the same test code, etc.

<p> Sample .feature File:

```gherkin
Feature: Scenario - listShiftperationDetails for each user at all sites // not related to below test, but used as an example
    # get current shift for Site1 
    # send currentShift ID to listShiftperationDetails for Admin user
    # send currentShift ID to listShiftperationDetails for mine user
    # repeat above for site2
    # repeat for site3

Background:
    * url baseUrl
    // Define graphQL payload's for use in below tests
    * def teaByNameQuery = read('classpath:queries/teaByName.graphql')
    * def baseResponseTime = expectedResponseTime  // gets the universal response time from the .config file

Scenario: Test Lavender Tea response
    Given url baseUrl
    And def variables = { name: 'Lavender Tea'} // this data could come from a test data file
    And request { query: '#(teaByNameQuery)', variables: '#(variables)' } // reference variables set above, can also reference a test data .json/.yaml files

    // base assertions
    * status 200
    * match response.errors == '#notpresent'
    * assert responseTime < baseResponseTime

    // Test specific assertions
    * match response.data.teaByNameQuery != null // response is not empty
    * match response.data.teaByNameQuery[0].comment  == null
    * match response.data.teaByNameQuery[0].name  == "Lavender Tea"
    ...
```

<p>The above example, will:

<p>Feature section

1. State the test scenario name, which will appear in reports, and the test runner, these are best kept unique and descriptive
2. Comments (#) are used to layout the test steps that the test will follow. These help the QA brain storm what they intend to test, and allow other QA to see a high level overview of what the test is accomplishing

<p>Background Section

1. set the request url from the baseUrl set in the karate-config_{env}.js file
2. define a variable called teaByNameQuery that contains the graphQL request data

<p>Scenario Section

1. set the url from the variable in the background section
2. define a variable called operations with the desired response fields
3. define a variable called variables with the test specific data to be used in the call
4. use the variables in the request to be sent in a test step

<p>Assertions

1. I've added a "based assertions" section that all tests will verify, such as response code, response time, and the absence of an error object
2. Then there are the test specific assertions such as the response object is not empty, the comment field is not empty, and an explicit assertion that a field has a value that is expected

TODO: Find a way to reference Base assertions across the tests [Github issue #4]()

<br>

### Test data files
Our response test data can be stored in .yaml, csv, .json and other file types. Yaml has an advantage over json as you can have comment's and it supports inline json for response validation. I don't have an example where we are using these files, and may not be the best way to test our endpoints.

#### GraphQL requests
A .graphql file is used to store the graphql query or mutation payload. The intention is that the request is outside of the .feature file is easily maintained. If the request is updated in the future we only need to make the update in one place. If each feature file had the payload embedded, we would need to update each of those tests. Due the complexity of some tests, this could be out of control quickly. After updating the payload, the test assertions would only need to fixed where broken.

<p>Within a .graphql file, it's best to use the standard graphQL variables. Then, from within the .feature file you can send the variables specific to your test scenario. This allows the test to dictate the test variables, and allows the payload to remain agnostic.

<p>TODO: I want to investigate passing in the output keys per test as well.

<p>Sample .graphQL file:

```graphql
{
  query findTeaByName($name: String!){
          teas(name: $name){
              name
              price
      }
}
```

#### Writing assertions

TODO: add details
[See Karate documentation for more](https://github.com/karatelabs/karate#payload-assertions)

#### Schema Validation
<p>For schema validation we are not using the same assertion style as our Postman tests. In Postman we are taking the response object and creating a JSON schema, then asserting the response matches the schema. In Karate this is not best practice.

<p>There are a few reasons as to why this is not best practice, the main reasons are execution time and readability. If we wanted to validate the schema as we do in Postman, we would need to install several 3rd party Maven modules, write and maintain a conversion java script, each of which adds a bit more overhead and complexity. When this is executed against potentially several dozen tests the execution time adds up.

<p>Another reason to use the Karate way, is to increase test readability. A simple JSON schema can be hundreds of lines, and would need to be in a separate .json file to not clutter the .feature file. This requires a person to switch between files to read the intent of the test.

<p>Karate takes the json returned in the response, removes the field data, and replaces it with the expected field validations. For example, if a comment is expected to be returned as a string, we would replace the "string" value with '#string'. Regex can also be used to validate the value is within spec. This validation can get as complex as the response 
itself. 

<p>In some cases the field could be a string or null and would represented as:

```java
'## #string'
```

<p>For regex it's probably best to have the validation stored in the karate-config.js file. Regex can quickly become messy to read, and a well named variable will convey what the regex is validating

[See Karate documentation for more details and examples](https://github.com/karatelabs/karate#schema-validation)

<p>Example schema validation:

```gherkin
    # Set schema validation
    * def guidRegex = guidRegex
    * def schemaValidation =
    """
      {
        "data": {
          "assignmentEmployeeFeed": [
              {
                  "id": '#regex^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$',
                  "assignmentId": '#(guidRegex)',
                  "siteEmployeeId": '#(guidRegex)',
                  "assignmentRoleId": '#(guidRegex)',
                  "comment": '## #string',
                  "updatedAt": '#number',
                  "isDeleted": '#boolean',
                  "version": '#number'
              }   ,
          ]
        }
      }
    """

    # Assert response object matches schema .json file
    * match response == schemaValidation

```

How the regex variable is stored in the karate-config.js file

```js
  var config = {
    env: env,
    // Global Variables
    baseResponseTime: 7000,
    // Schema validation variables
    // regex for a guid - 9d900b61-195c-433c-94ee-155a2570d653
    guidRegex: '#regex^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$'
  }
```

<p>Above, you can see examples of the regex inline with the schema, or referenced from the karate-config.js file. For the comment field, it can be returned either as a string or <i>null</i>. In this case we use '## #string' to assert.


#### Test tags
Tags are very useful and have a vast array of uses. They can be used to denote what type of test a scenario is (positive, negative, e2e, smoke, etc.), if a test should be ignored, if the test should be debugged (while writing or problem solving), if a test is only relevant for a specific test env, and a lot more.

<p>These tags are then used as conditions when the test suite is run. Using the --smoke condition will only run smoke tests. Most tags are not set by Karate, and can be any meaningful value. There are some specific Karate tags, see the below link to Karate documentation for details.

<p><strong>Use Cases</strong>

* only run the smoke tests
* only run all positive tests
* ignore a test that is in a fail state
* execute tests for a specific test env
* ignore a setup test such as token gen

[See Karate documentation for more](https://github.com/karatelabs/karate#tags)

### Test Loops
Once a base test scenario is written, Karate supports looping through data scenarios. From the example further up the document, you could have test data for other tea types, and assertions for the response specific to that tea stored in a .yaml file.

<p>Hopefully it's clear as to why this is a benefit. Having 1 test scenario supported by data that lives outside the test steps allows us to maintain and fix broken tests easily. Most tests are broken to due stale or changed data.

TODO: Work on PoC for this.

### testRunner.java 
I need to find a resource to understand how can we can leverage these.

TODO: testRunner.java [Github issue #4]()

<br>

### Business flow scenarios
The VSCode KarateIDE plugin has functionality where you can select multiple .feature files, right click, and generate a Business Flow Test. From here we can chain multiple graphQL requests together in one .feature file to simulate the flow of data between endpoints. Effectively an end to end or integration test.

<p>Having a whole scenario in one .feature file will keep tests contained which is an automation best practice. We don't want to reference other files and have our tests dependant on the stability or presence of another test.

<br>

## Test setup and teardown
In the karate-config files, .feature files can be referenced and if written correctly, can return a variable for use in tests. For example, a getCurrentShift.feature file could be created, referenced in the config file to run once at the start of the test execution, and then store the guid in a variable that can be used in multiple tests. 

See [Karate documentation for more details](https://stackoverflow.com/questions/63950335/how-do-i-execute-something-on-test-suite-setup-teardown)

There is also a way to do teardown at the end of a script as well. This can be useful to remove or reset data after a test is finished. This needs to be explored.

Example test setup that calls the authAdmin.feature file which sends a GET request to our auth endpoint. The auth token is stored as a variable for use in our tests. This will only be called once when the test suite is run.

```javascript
// Genereate and store authentication id_token in config object
var adminAuth = karate.callSingle("classpath:supportTests/authentication/authAdmin.feature", config);
config.adminAuth = adminAuth.adminAccessToken;
```

<p>What the autAdmin.feature file contains:

```gherkin
Feature: Admin Auth Token Genreation

Background:
    * url authUrl
@ignore
Scenario: Admin Auth
    * path 'token'
    * form field client_id = clientId // pulls client_id from the karate-config-{env}.js file
    * form field grant_type = 'refresh_token'
    * form field refresh_token = adminRefreshToken // pulls client_id from the karate-config-{env}.js file

    When method post
    Then status 200

    * def adminAccessToken = response.id_token
```

See [Stackoverflow article for more details](https://stackoverflow.com/questions/63950335/how-do-i-execute-something-on-test-suite-setup-teardown).

## Running Tests
### From the terminal (cli)
TODO: Test execution: [Github issue #5]()

<br>

### From VSCode
The easiest way to execute tests in VSCode is to use the KarateIDE extension referenced and in the Instillation section of this doc. From the VSCode left toolbar, clicking on the K icon will load the test runner. See the extension documentation for details.

<p>Execute only current .feature file

<p>Execute all test in a folder

<p>Execute whole test suite

<p>Execute subgroup of tests

<br>

### Linting and Code Best Practices
Linting is important to help all people working on a codebase follow the same coding styles and enforce formatting rules. This makes it easier to read and understand the code that is written.

<p>I need to investigate linters to see if there is something we can use.

<p>It's also best for all projects to follow the same coding styles and formatting when writing tests. This will allow QA from other projects to onboard quicker, provide better PR feedback, and will allow others to provide better support for questions if we all follow the same standards. This can be discussed as a team to see what would work best.

## Test Reports
KarateIDE will generate reports as a test is run, these can be viewed and saved as HTML. You can also view the request and response details for each test as well. The reports are useful for debugging, and can be added to the change request as proof of testing.

TODO: Investigate reports [Github issue #6]()

## Test Environments
Karate supports testing across multiple environments either using the same test data, or if a env has unique data the data can be specific at test execution.

TODO: Add details and examples.

## Training
The intention is to include training material within this repo for anyone to learn how to write automation with Karate.

<p>We could also host the training material on a github page rather in these repos. I'm leaning towards this. These training material can also be in the same repo as our framework utils package if we get that working.

## Solutions to potential problems
### Java Certificate
If you are executing your tests, and you are coming across a SSL certificate error message, you will need to add the below to your karate-config.js file. This will enable SSL verification for all tests globally.

```java
 karate.configure('ssl', true);
```

### ClassPath
This <i>MAY</i> be needed for Karate to find our test file /resource folder. I'm not convinced it's needed.

```bash
mvn dependency:build-classpath
```

#### Set Classpath in VScode
<p> <strong>ctrl+shift+p</strong> then enter KarateIDE: Configure Classpath -> select Karate {latest version}

## Future considerations
* Karate can also be used for performance testing, [potential how-to](https://kalimoh.blogspot.com/2020/06/performance-testing-with-karate-gatling.html)

## Resources Used
* https://github.com/karatelabs/karate
* https://automationpanda.com/2018/12/10/testing-web-services-with-karate/
* https://www.kloia.com/blog/step-1-introduction-to-karate-project-setup-hello-world
* https://aru-sha4.medium.com/java-check-style-and-formatting-using-maven-a1a1b4e6e10a
* https://www.youtube.com/watch?v=pYyRvly4cG8
* https://www.codemotion.com/magazine/frontend/web-developer/graphql-testing-karate/
