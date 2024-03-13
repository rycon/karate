function fn() {
  karate.configure('connectTimeout', 5000);
  karate.configure('readTimeout', 5000);
  karate.configure('ssl', true);
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'stage'; //default to stage if no env is set at run time
  }

var config = {
  env: env,
  // Global Variables
  baseResponseTime: 7000,
  site1Id: "9d900b61-195c-433c-94ee-155a2570d653",
  site2Id: "0fd37374-4add-b21e-fa35-20dab7f8e600",
  site3Id: "6599161d-ab54-289a-0e17-c4c8551540ec",


  //Java Dependencies
  faker: Java.type('net.datafaker.Faker'),

  // shortcuts
  commonUtils: Java.type('utils.commonUtils'),

  // Schema validation variables
  // regex for a guid pattern: 9d900b61-195c-433c-94ee-155a2570d653
  guidRegex: '#regex^[{]?[0-9a-fA-F]{8}-([0-9a-fA-F]{4}-){3}[0-9a-fA-F]{12}[}]?$',
  // regex for timestamp pattern: 2021-11-25T22:02:11.691Z
  timeStampRegex: '#regex^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}(\.[0-9]+)?([zZ]|([\+-])([01]\d|2[0-3]):?([0-5]\d)?)?'
}

  return config;
}