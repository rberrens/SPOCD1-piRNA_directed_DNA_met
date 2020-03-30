# run fastq quality control fastqc (v0.11.9)
fastqc ${NAME}

# trimming sequences using trim-galore v0.6.5
trim_galore --paired --length 25 --trim-n --clip_R2 5 --fastqc ${READ1} ${READ2}

# bismark alignment v0.22.3 for alignment, algined to genome GRCm38 with bowtie2-2.3.5
bismark --score_min L,0,-0.4 \
--genome /hps/research1/marioni/Rebecca/annotation/mouse/ENSEMBL_genome/ \
-1 ${READ1} \
-2 ${READ2}

# deduplicate reads 
deduplicate_bismark -p ${NAME}

# methylation extraction
bismark_methylation_extractor -s --no_header --bedGraph ${NAME}

# bismark reports
bismark2report
bismark2summary