configfile: 'config_spocd1_pi_simple.yaml'
bowtie = "/usr/local/Cellar/bowtie/1.2.1.1/bin/bowtie"

rule all:
  input:
     expand("Processed/v3/mapped/{sample}_consensus_L1A_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1A_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1A_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1A_v3_gapcount.txt", sample = config["samples"]),
     expand("Processed/v3/mapped/{sample}_consensus_L1T_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1T_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1T_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1T_v3_gapcount.txt", sample = config["samples"]),
     expand("Processed/v3/mapped/{sample}_consensus_L1Gf_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_gapcount.txt", sample = config["samples"]),
     expand("Processed/v3/mapped/{sample}_consensus_L1F2_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1F2_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1F2_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_L1F2_v3_gapcount.txt", sample = config["samples"]),
     expand("Processed/v3/mapped/{sample}_consensus_IAPEy_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_gapcount.txt", sample = config["samples"]),
     expand("Processed/v3/mapped/{sample}_consensus_IAPEz_v3.sam", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_plus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_minus.txt", sample = config["samples"]),
     expand("Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_gapcount.txt", sample = config["samples"])
     

rule mapL1A:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdA_{sample}.fasta"
  output:
    L1 = "Processed/v3/mapped/{sample}_consensus_L1A_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 ../consensus/L1Md-A2 {input.fasta} \
    {output.L1} 
    """
    
rule L1A_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1A_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1A_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule L1A_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1A_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1A_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule L1A_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_L1A_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_L1A_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1A_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """
  
rule mapL1T:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdT_{sample}.fasta"
  output:
    L1 = "Processed/v3/mapped/{sample}_consensus_L1T_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 /Users/Shared/ykabayam/tools/Mus_musculus/UCSC_mm10/Sequence/Consensus_repeat/L1_consensus/L1MdTf1_7398_2 {input.fasta} \
    {output.L1} 
    """
    
rule L1T_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1T_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1T_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule L1T_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1T_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1T_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule L1T_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_L1T_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_L1T_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1T_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """    

rule mapL1Gf:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdGf_{sample}.fasta"
  output:
    L1 = "Processed/v3/mapped/{sample}_consensus_L1Gf_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 /Users/Shared/ykabayam/tools/Mus_musculus/UCSC_mm10/Sequence/Consensus_repeat/L1_consensus/L1MdGf1_7085 {input.fasta} \
    {output.L1} 
    """
    
rule L1Gf_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1Gf_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule L1Gf_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1Gf_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule L1Gf_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1Gf_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """
    
rule mapL1F2:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_L1MdF2_{sample}.fasta"
  output:
    L1 = "Processed/v3/mapped/{sample}_consensus_L1F2_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 /Users/Shared/ykabayam/tools/Mus_musculus/UCSC_mm10/Sequence/Consensus_repeat/L1_consensus/L1MdF1_6382 {input.fasta} \
    {output.L1} 
    """
    
rule L1F2_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1F2_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1F2_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule L1F2_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_L1F2_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1F2_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule L1F2_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_L1F2_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_L1F2_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_L1F2_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """

rule mapIAPEz:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_IAPEz_{sample}.fasta"
  output:
    IAP = "Processed/v3/mapped/{sample}_consensus_IAPEz_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 ../consensus/IAPEZI {input.fasta} \
    {output.IAP} 
    """

rule IAPz_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_IAPEz_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule IAPz_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_IAPEz_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule IAPz_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEz_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """


rule mapIAPEY:
  input: 
    fasta = "Processed/v3/fasta/spocd1_pi_IAPEy_{sample}.fasta"
  output:
    IAP = "Processed/v3/mapped/{sample}_consensus_IAPEy_v3.sam"
  shell:
    """
    {bowtie} -v 3 -f --best -k 1 ../consensus/IAPEY {input.fasta} \
    {output.IAP} 
    """

rule IAPy_plus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_IAPEy_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_plus.txt"
  shell:
    """
    perl ../perl/filter_plus.pl  {input.sam} > {output.list}
    """

rule IAPy_minus:
  input:
    sam = "Processed/v3/mapped/{sample}_consensus_IAPEy_v3.sam"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_minus.txt"
  shell:
    """
    perl ../perl/filter_minus.pl  {input.sam} > {output.list}
    """

rule IAPy_pair:
  input:
    plus = "Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_plus.txt",
    minus = "Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_minus.txt"
  output:
    list = "Processed/v3/pingpong/{sample}_consensus_IAPEy_v3_gapcount.txt"
  shell:
    """
    perl ../perl/Souatari_allgap.pl {input.minus} {input.plus} | perl ../perl/sum_count.pl | \
    perl ../perl/count_last_column.pl | perl ../perl/ping-pong_range.pl > {output.list}
    """







    
    
    
    
    
    