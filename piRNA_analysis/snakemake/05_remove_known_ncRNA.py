configfile: 'config_spocd1_pi.yaml'
bowtie = "/usr/local/Cellar/bowtie/1.2.1.1/bin/bowtie"

rule all:
  input:
  	expand("Processed/mapped/{sample}_mirna_mature.sam", sample = config["samples"]),
  	expand("Processed/unmapped/{sample}_mirna_mature_unmmaped.fasta", sample = config["samples"]),
  	expand("Processed/mapped/{sample}_mirna_hairpin.sam", sample = config["samples"]),
  	expand("Processed/unmapped/{sample}_mirna_hairpin_unmmaped.fasta", sample = config["samples"]),
  	expand("Processed/mapped/{sample}_ncRNA.sam", sample = config["samples"]),
  	expand("Processed/unmapped/{sample}_ncRNA_unmmaped.fasta", sample = config["samples"]),
  	expand("Processed/mapped/{sample}_nrRNA.sam", sample = config["samples"]),
  	expand("Processed/unmapped/{sample}_nrRNA_unmmaped.fasta", sample = config["samples"])

rule map_mirna_mature:
  input: 
    fasta = "Processed/fasta/{sample}_count.fasta"
  output:
    mirna_mature = "Processed/mapped/{sample}_mirna_mature.sam",
    unmapped = "Processed/unmapped/{sample}_mirna_mature_unmmaped.fasta"
  params:
    mirnas = config["mirnas"]
  shell:
    """
    {bowtie} -v 0 -f --un {output.unmapped} {params.mirnas} {input.fasta} \
    {output.mirna_mature} 
    """
    
rule map_mirna_hairpin:
  input: 
    fasta = "Processed/unmapped/{sample}_mirna_mature_unmmaped.fasta"
  output:
    mirna_mature = "Processed/mapped/{sample}_mirna_hairpin.sam",
    unmapped = "Processed/unmapped/{sample}_mirna_hairpin_unmmaped.fasta"
  params:
    mirnas = config["mirnas_hairpin"]
  shell:
    """
    {bowtie} -v 0 -f --un {output.unmapped} {params.mirnas} {input.fasta} \
    {output.mirna_mature} 
    """    
 	
rule map_ncRNA:
  input:
    "Processed/unmapped/{sample}_mirna_hairpin_unmmaped.fasta"
  output:
    ncRNA = "Processed/mapped/{sample}_ncRNA.sam",
    unmapped = "Processed/unmapped/{sample}_ncRNA_unmmaped.fasta"
  params:
    ncRNA = config["ncRNA"]
  shell:
    """
    {bowtie} -v 0 --un {output.unmapped} -f \
    {params.ncRNA} {input} {output.ncRNA} 
    """ 
    
rule map_nrRNA:
  input:
    "Processed/unmapped/{sample}_ncRNA_unmmaped.fasta"
  output:
    nrRNA = "Processed/mapped/{sample}_nrRNA.sam",
    unmapped = "Processed/unmapped/{sample}_nrRNA_unmmaped.fasta"
  params:
    nrRNA = config["nrRNA"]
  shell:
    """
    {bowtie} -v 0 --un {output.unmapped} -f \
    {params.nrRNA} {input} {output.nrRNA} 
    """ 
    
