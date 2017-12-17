"use strict";
module.exports = class DnaTranscriber {
    constructor() {
        this.mapping = {
            G: 'C',
            C: 'G',
            T: 'A',
            A: 'U',
        };
    }
    toRna(dna) {
        return dna.split('').reduce((acc, i) => {
            const j = this.mapping[i];
            if (j === undefined) {
                throw new Error('Invalid input');
            }
            return acc + j;
        }, '');
    }
};
