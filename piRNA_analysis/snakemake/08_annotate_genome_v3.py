configfile: 'config_spocd1_pi.yaml'
bedtools = "/usr/local/Cellar/bedtools/2.27.1/bin/bedtools"

rule all:
  input:
  	expand("Processed/v3/mapped/{sample}_unique_sorted_edited_TE.bed", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique_sorted_edited_nTE.bed", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique_sorted_edited_genes.bed", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique_sorted_edited_others.bed", sample = config["samples"])


rule annotate_TEs:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted_edited.bed"
  output:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_TE.bed"
  params:
    bedTE = config["bedTE"]
  shell:
    """
    bedtools intersect -a {input} -b {params.bedTE} > {output}
    """

rule annotate_nTEs:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted_edited.bed"
  output:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_nTE.bed"
  params:
    bedTE = config["bedTE"]
  shell:
    """
    bedtools intersect -a {input} -b {params.bedTE} -v > {output}
    """

rule annotate_genes:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_nTE.bed"
  output:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_genes.bed"
  params:
    bedGenes = config["bedGenes"]
  shell:
    """
    bedtools intersect -a {input} -b {params.bedGenes} > {output}
    """
    
rule annotate_others:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_nTE.bed"
  output:
    "Processed/v3/mapped/{sample}_unique_sorted_edited_others.bed"
  params:
    bedGenes = config["bedGenes"]
  shell:
    "bedtools intersect -a {input} -b {params.bedGenes} -v > {output}"