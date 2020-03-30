configfile: 'config_spocd1_pi.yaml'

rule all:
  input:
  	expand("Processed/v3/mapped/{sample}_teRNA_ext.sam", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_teRNA_family.txt", sample = config["samples"])

rule extract:
  input:
    "Processed/v3/mapped/{sample}_teRNA.sam"
  output:
    temp=("Processed/v3/mapped/{sample}_teRNA_ext.sam")
  shell:
    """
    perl ../perl/extract_3_column_sam.pl {input} > {output}
    """


rule give_TE_family:
  input:
    "Processed/v3/mapped/{sample}_teRNA_ext.sam"
  output:
    "Processed/v3/mapped/{sample}_teRNA_family.txt"
  params:
    familyTE = config["familyTE"]
  shell:
    """
    perl ../perl/pick_retroclass_family.pl {params.familyTE} {input} > {output}
    """
