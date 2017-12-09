def to_rnax(dna_strand):
    transcription = {'G' : 'C', 'C' : 'G', 'T' : 'A', 'A' : 'U',}
    transcribed = [transcription.get(x) for x in dna_strand]
    if all(transcribed):
        return ''.join(transcribed)
    raise ValueError()

TRANSLATION_TABLE = str.maketrans("GCTA", "CGAU")

def to_rna(dna: str) -> str:
    if not all(ord(x) in TRANSLATION_TABLE for x in dna):
        raise ValueError()

    return dna.translate(TRANSLATION_TABLE)
