const wait = ms => new Promise(resolve => setTimeout(resolve, ms));

exports.sleepImpl = ms => () =>
  wait(ms);
