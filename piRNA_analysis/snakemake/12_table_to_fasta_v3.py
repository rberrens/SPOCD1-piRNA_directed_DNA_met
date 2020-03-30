configfile: 'config_spocd1_pi_simple.yaml'
cutadapt = "/usr/local/bin/cutadapt"
bowtie = "/usr/local/Cellar/bowtie/1.2.1.1/bin/bowtie"

rule all:
  input:
     expand("Processed/v3/fasta/spocd1_pi_IAPEz_{sample}.fasta", sample = config["samples"]),
     expand("Processed/v3/fasta/spocd1_pi_IAPEy_{sample}.fasta", sample = config["samples"]),
     expand("Processed/v3/fasta/spocd1_pi_L1MdA_{sample}.fasta", sample = config["samples"]),
     expand("Processed/v3/fasta/spocd1_pi_L1MdT_{sample}.fasta", sample = config["samples"]),
     expand("Processed/v3/fasta/spocd1_pi_L1MdGf_{sample}.fasta", sample = config["samples"]),
     expand("Processed/v3/fasta/spocd1_pi_L1MdF2_{sample}.fasta", sample = config["samples"]) 


rule IAPEz:
  input:
    table = "Processed/v3/view/spocd1_pi_IAPEz_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_IAPEz_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """
    
rule IAPEy:
  input:
    table = "Processed/v3/view/spocd1_pi_IAPEy_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_IAPEy_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """

rule L1MdA:
  input:
    table = "Processed/v3/view/spocd1_pi_L1MdA_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdA_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """

rule L1MdT:
  input:
    table = "Processed/v3/view/spocd1_pi_L1MdT_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdT_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """

rule L1MdGf:
  input:
    table = "Processed/v3/view/spocd1_pi_L1MdGf_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdGf_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """

rule L1MdF2:
  input:
    table = "Processed/v3/view/spocd1_pi_L1MdF2_{sample}.txt"
  output:
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdF2_{sample}.fasta"
  shell:
    """
    perl ../perl/table_to_fasta.pl  {input.table} > {output.fasta}
    """
    