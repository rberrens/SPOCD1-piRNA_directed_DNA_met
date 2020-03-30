configfile: 'config_spocd1_pi.yaml'
cutadapt = "/usr/local/bin/cutadapt"

rule all:
  input:
     expand("Reads/{sample}_trimmed.txt", sample = config["samples"])

rule remove_adaptor:
  input:
    fastq = "Reads/CCTUAANXX_sRNAS1_19s001788-1-1_{sample}_sequence.txt.gz"
    
  output:
    trimmed = "Reads/{sample}_trimmed.txt"
    
  shell:
    """
    cutadapt -a AGATCGGAAGA -o {output.trimmed} -m 16 --trimmed-only {input.fastq}
    """