//
// This is only a SKELETON file for the "Leap" exercise. It's been provided as a
// convenience to get you started writing code faster.
//

const Year = function YearFunc(input) {
  this.input = input;
};

Year.prototype.isLeap = function isLeap() {
  if (this.input % 4 === 0) {
    if (this.input % 100 === 0 && this.input % 400 !== 0) {
      return false;
    }
    return true;
  }
  return false;
};

module.exports = Year;
