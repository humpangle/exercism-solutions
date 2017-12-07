def to_rna0(dna_strand):
    transcription = {'G': 'C', 'C': 'G', 'T': 'A', 'A': 'U', }
    transcribed = [transcription.get(x) for x in dna_strand]
    if all(transcribed):
        return ''.join(transcribed)
    raise ValueError()


def to_rna(dna: str) -> str:
    translation_table = str.maketrans("GCTA", "CGAU")
    if not all(ord(x) in translation_table for x in dna):
        raise ValueError()

    return dna.translate(translation_table)
