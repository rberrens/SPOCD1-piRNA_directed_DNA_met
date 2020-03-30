configfile: 'config_spocd1_pi.yaml'
bowtie = "/usr/local/Cellar/bowtie/1.2.1.1/bin/bowtie"
samtools = "/usr/local/Cellar/samtools/1.9/samtools"
bedtools = "/usr/local/Cellar/bedtools/2.27.1/bin/bedtools"

rule all:
  input:
  	expand("Processed/v3/mapped/{sample}_teRNA.sam", sample = config["samples"]),
  	expand("Processed/v3/unmapped/{sample}_teRNA_unmmaped.fasta", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique.sam", sample = config["samples"]),
  	expand("Processed/v3/unmapped/{sample}_unique_unmmaped.fasta", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique_sorted.bed", sample = config["samples"]),
  	expand("Processed/v3/mapped/{sample}_unique_sorted_edited.bed", sample = config["samples"])
  	
    
rule map_teRNA:
  input:
    "Processed/unmapped/{sample}_nrRNA_unmmaped.fasta"
  output:
    teRNA = "Processed/v3/mapped/{sample}_teRNA.sam",
    unmapped = "Processed/v3/unmapped/{sample}_teRNA_unmmaped.fasta"
  params:
    teRNA = config["teRNA"]
  shell:
    """
    {bowtie} -v 3 --un {output.unmapped} -f \
    {params.teRNA} {input} {output.teRNA} 
    """ 

rule map_unique:
  input:
    "Processed/v3/unmapped/{sample}_teRNA_unmmaped.fasta"
  output:
    unique = "Processed/v3/mapped/{sample}_unique.sam",
    unmapped = "Processed/v3/unmapped/{sample}_unique_unmmaped.fasta"
  params:
    genome = config["genome"]
  shell:
    """
    {bowtie} -v 3 -m 1 -S --un {output.unmapped} -f --no-unal \
    {params.genome} {input} {output.unique} 
    """ 

rule convert_sam_to_bam:
  input:
    "Processed/v3/mapped/{sample}_unique.sam"
  output:
    temp("Processed/v3/mapped/{sample}_unique.bam")
  shell:
    """
    samtools view -b -S -o {output} {input}
    """

rule sort_bam:
  input:
    "Processed/v3/mapped/{sample}_unique.bam"
  output:
    temp("Processed/v3/mapped/{sample}_unique_sorted.bam")
  shell:
    """
    samtools sort -o {output} {input}
    """

rule convert_bam_to_bed:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted.bam"
  output:
    temp("Processed/v3/mapped/{sample}_unique_sorted.bed")
  shell:
    """
    bedtools bamtobed -i {input} > {output} 
    """

rule edit_bed:
  input:
    "Processed/v3/mapped/{sample}_unique_sorted.bed"
  output:
    "Processed/v3/mapped/{sample}_unique_sorted_edited.bed"
  shell:
    """
    perl ../perl/bed_edit.pl {input} > {output} 
    """

    
    
    
    