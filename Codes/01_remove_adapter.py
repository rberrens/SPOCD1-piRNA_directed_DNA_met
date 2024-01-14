configfile: 'config_P20_testis_RNAseq.yaml'
cutadapt = "/usr/local/bin/cutadapt"

rule all:
  input:
     expand("cutadapt/{sample}_trimmed.txt", sample = config["samples"])

rule remove_adaptor:
  input:
    fastq = "/Volumes/ocarroll/shared/RNAseq/RNAseq_P20_testis/HWVTHAFXY_RNAseqAZpool_19s004407-1-1_Zoch_lane1{sample}_sequence.txt.gz"
    
  output:
    trimmed = "cutadapt/{sample}_trimmed.txt"
    
  shell:
    """
    cutadapt -a AGATCGGAAGAGC -m 49 -o {output.trimmed} {input.fastq}
    """