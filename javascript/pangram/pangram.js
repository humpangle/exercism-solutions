"use strict";
class Pangram {
    constructor(sentence) {
        this.sentence = sentence.toLowerCase();
    }
    isPangram1() {
        return (Array.from(this.sentence).reduce((acc, i) => {
            return /[a-z]/.test(i) && !acc.includes(i) ? acc + i : acc;
        }, '').length === 26);
    }
    isPangram2() {
        for (const i of 'abcdefghijklmnopqrstuvwxyz') {
            if (!this.sentence.includes(i)) {
                return false;
            }
        }
        return true;
    }
    isPangram() {
        const s = this.sentence.match(/[a-z]/g);
        return new Set(s).size === 26;
    }
    make() {
        const acc = { m: {}, s: [] };
        const { m: letterMap, s: letterStack } = Array.from('abcdefghijklmnopqrstuvwxyz').reduce(({ m, s }, l, i) => ({
            m: Object.assign({}, m, { [l]: i, [l.toUpperCase()]: i }),
            s: [...s, i],
        }), acc);
        return letterStack;
    }
}
console.log(new Pangram('').make());
module.exports = Pangram;
