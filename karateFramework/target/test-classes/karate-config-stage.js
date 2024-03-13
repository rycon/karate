// This file supercedes the karate-config.js file, any value here will overwrite what is set in the other file
// Use this for env specific variables suchs as URL, auth creds, etc.
// Be careful and aware of who you give this file to. There are senstive details in here. This file should NEVER be pushed to a repo
// It's included in the .gitignore file and won't be pushed to git
function fn() {
var config = {
    // Login and Auth details
    baseUrl: '{redacted}',
    restUrl: "https://reqres.in/api",
    authUrl: '{redacted}',
    clientId: '{redacted}',
    adminRefreshToken: '{redacted}',
    borerMaintenanceRefreshToken: '{redacted}',
    borerSupervisorRefreshToken: '{redacted}',
    operatorRefreshToken: '{redacted}',
    readOnlyRefreshToken: '{redacted}',
    staffRefreshToken: '{redacted}'
}

// Genereate and store authentication id_token in config object
var adminAuth = karate.callSingle("classpath:supportTests/authentication/authAdmin.feature", config);
config.adminAuth = adminAuth.adminAccessToken;

// TODO: Add remaining auths

var currentShift1 = karate.callSingle("classpath:supportTests/getCurrentShift/getCurrentShift1.feature", config);
config.currentShift1 = currentShift1.shift1Id;

var currentShift2 = karate.callSingle("classpath:supportTests/getCurrentShift/getCurrentShift2.feature", config);
config.currentShift2 = currentShift2.shift2Id;

var currentShift3 = karate.callSingle("classpath:supportTests/getCurrentShift/getCurrentShift2.feature", config);
config.currentShift3 = currentShift3.shift3Id;

    return config;
}