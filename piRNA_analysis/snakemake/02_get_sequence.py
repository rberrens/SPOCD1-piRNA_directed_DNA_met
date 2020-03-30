configfile: 'config_spocd1_pi.yaml'

rule all:
  input:
     expand("Processed/{sample}_sequences.txt", sample = config["samples"])

rule get_sequences:
  input:
    trimmed = "Reads/{sample}_trimmed.txt"
  output:
    sequences = "Processed/{sample}_sequences.txt"
  shell:
    """
    perl ../perl/pick_only_seq_from_fastq.pl {input.trimmed} > {output.sequences}
    """