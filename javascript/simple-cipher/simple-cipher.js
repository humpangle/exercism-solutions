"use strict";
module.exports = class Cipher {
    constructor(key = 'a'.repeat(10)) {
        this.letters = 'abcdefghijklmnopqrstuvwxyz';
        if (!/^[a-z]+$/.test(key)) {
            throw new Error('Bad key');
        }
        this.key = key;
        this.keyLen = this.key.length;
    }
    encode(word, encode = true) {
        let encoded = '';
        for (let index = 0; index < word.length; index++) {
            const element = word[index];
            const key = this.key[index % this.keyLen];
            const elementIndex = this.letters.indexOf(element);
            const keyIndex = this.letters.indexOf(key);
            const encodedIndex = encode
                ? elementIndex + keyIndex
                : elementIndex - keyIndex + 26;
            encoded += this.letters[encodedIndex % 26];
        }
        return encoded;
    }
    decode(word) {
        return this.encode(word, false);
    }
};
