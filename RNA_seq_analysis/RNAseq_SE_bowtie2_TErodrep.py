configfile: 'config_P20_testis_RNAseq.yaml'
bowtie2 = "/usr/local/Cellar/bowtie2/2.3.4.3/bin/bowtie2"

rule all:
	input:
		expand("out_bowtie2/{sample}_rodrep.sam", sample = config["samples"]),
		expand("out_bowtie2/count_{sample}_rodrep_hit.txt", sample = config["samples"])

rule bowtie2:
    input:
        "cutadapt/{sample}_trimmed.txt.gz"
    output:
        "out_bowtie2/{sample}_rodrep.sam"
    log:
        "logs/bowtie2/{sample}_rodrep.log"
    shell:
    	"{bowtie2} --qc-filter --no-unal -x /Users/ykabayam/Documents/RNA-seq/RepBase24.01.fasta/rodrep_Mus -U {input} -S {output}"

rule count_hit:
	input:
		"out_bowtie2/{sample}_rodrep.sam"
	output:
		"out_bowtie2/count_{sample}_rodrep_hit.txt"
	shell:
		"perl ../perl/count_column_2.pl {input} > {output}"