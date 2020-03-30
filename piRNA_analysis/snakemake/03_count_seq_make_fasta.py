configfile: 'config_spocd1_pi.yaml'

rule all:
  input:
     expand("Processed/count/{sample}_count.txt", sample = config["samples"]),
     expand("Processed/fasta/{sample}_count.fasta", sample = config["samples"])


rule count_reads:
  input:
    sequences = "Processed/{sample}_sequences.txt"
  output:
    count = "Processed/count/{sample}_count.txt"
  shell:
    """
    perl ../perl/count_seq.pl  {input.sequences} > {output.count}
    """

rule make_fasta:
  input:
    count = "Processed/count/{sample}_count.txt"
  output:
    fasta = "Processed/fasta/{sample}_count.fasta"
  shell:
    """
    perl ../perl/count_seq_to_fasta3.pl  {input.count} > {output.fasta}
    """