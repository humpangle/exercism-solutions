const TwoFer = function TwoFerFunc() {};

TwoFer.prototype.twoFer = function twoFer(who) {
  // your code goes here
  // You will have to use the parameter who
  // in some way. In this example, it is just
  // returned, but your solution will have to
  // use a conditional.
  return `One for ${who || 'you'}, one for me.`;
};

module.exports = TwoFer;
