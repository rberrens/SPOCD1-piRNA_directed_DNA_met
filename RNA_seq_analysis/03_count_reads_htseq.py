configfile: "config_P20_testis_RNAseq.yaml"
htseqcount = "/usr/local/bin/htseq-count"

rule all:
	input:
		expand("out_hisat2/count_{sample}.txt", sample = config["samples"])

rule htseq:
    input:
        "out_hisat2/{sample}.sam"
        
    output:
        "out_hisat2/count_{sample}.txt"
   
    shell:
    	"{htseqcount} {input} /Users/ykabayam/Documents/RNA-seq/Mus_musculus.GRCm38.95.gtf > {output}"