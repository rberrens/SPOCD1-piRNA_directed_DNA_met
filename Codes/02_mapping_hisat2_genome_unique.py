configfile: 'config_P20_testis_RNAseq.yaml'
hisat2 = "/usr/local/Cellar/hisat2/2.1.0/bin/hisat2"

rule all:
	input:
		expand("out_hisat2/{sample}.sam", sample = config["samples"])

rule hisat2:
    input:
        read=["cutadapt/{sample}_trimmed.txt"]
        
    output:
        "out_hisat2/{sample}.sam"
    log:
        "logs/hisat2/{sample}.log"
    shell:
    	"{hisat2} --thread 4 --qc-filter --trim5 2 -x /Users/Shared/ykabayam/tools/Mus_musculus/grcm38_tran/genome_tran -U {input.read} -S {output}"
    