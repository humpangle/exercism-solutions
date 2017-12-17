export = class DnaTranscriber {
  mapping: { [key: string]: string } = {
    G: 'C',
    C: 'G',
    T: 'A',
    A: 'U',
  };

  toRna(dna: string) {
    return dna.split('').reduce((acc, i) => {
      const j = this.mapping[i];
      if (j === undefined) {
        throw new Error('Invalid input');
      }
      return acc + j;
    }, '');
  }
};
