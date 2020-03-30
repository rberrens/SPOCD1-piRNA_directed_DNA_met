configfile: 'config_spocd1_pi.yaml'

rule all:
  input:
    expand("Processed/count/{sample}_length_count_after_cutadapt.txt", sample = config["samples"])


rule length:
  input:
    seq = "Processed/count/{sample}_count.txt"
  output:
    txt = "Processed/count/{sample}_length_count_after_cutadapt.txt"
  shell:
    """
    perl ../perl/count_seq_length.pl {input.seq} | perl ../perl/count_last_column.pl > {output.txt}
    """
