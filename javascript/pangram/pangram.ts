class Pangram {
  sentence: string;

  constructor(sentence: string) {
    this.sentence = sentence.toLowerCase();
  }

  isPangram1(): boolean {
    return (
      Array.from(this.sentence).reduce((acc, i) => {
        return /[a-z]/.test(i) && !acc.includes(i) ? acc + i : acc;
      }, '').length === 26
    );
  }

  isPangram2(): boolean {
    for (const i of 'abcdefghijklmnopqrstuvwxyz') {
      if (!this.sentence.includes(i)) {
        return false;
      }
    }
    return true;
  }

  isPangram(): boolean {
    const s = this.sentence.match(/[a-z]/g) as string[];
    return new Set(s).size === 26;
  }

  make() {
    const acc = { m: {}, s: [] } as { m: object; s: number[] };
    const { m: letterMap, s: letterStack } = Array.from(
      'abcdefghijklmnopqrstuvwxyz'
    ).reduce(
      ({ m, s }, l, i) => ({
        m: { ...m, [l]: i, [l.toUpperCase()]: i },
        s: [...s, i],
      }),
      acc
    );
    return letterStack;
  }
}

export = Pangram;

console.log(new Pangram('').make());
