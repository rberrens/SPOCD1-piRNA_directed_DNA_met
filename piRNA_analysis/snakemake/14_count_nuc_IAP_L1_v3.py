configfile: 'config_spocd1_pi_simple.yaml'

rule all:
  input:
     expand("Processed/v3/FUTA/{sample}_IAPEz_nuc_count.txt", sample = config["samples"]),
     expand("Processed/v3/FUTA/{sample}_IAPEy_nuc_count.txt", sample = config["samples"]),
     expand("Processed/v3/FUTA/{sample}_L1A_nuc_count.txt", sample = config["samples"]),
     expand("Processed/v3/FUTA/{sample}_L1T_nuc_count.txt", sample = config["samples"]),
     expand("Processed/v3/FUTA/{sample}_L1Gf_nuc_count.txt", sample = config["samples"]),
     expand("Processed/v3/FUTA/{sample}_L1F2_nuc_count.txt", sample = config["samples"])
     
rule IAPEz:
  input:
    IAP = "Processed/v3/view/spocd1_pi_IAPEz_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_IAPEz_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.IAP} > {output.count_nuc}
    """
    
rule IAPEy:
  input:
    IAP = "Processed/v3/view/spocd1_pi_IAPEy_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_IAPEy_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.IAP} > {output.count_nuc}
    """


rule L1A:
  input:
    L1 = "Processed/v3/view/spocd1_pi_L1MdA_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_L1A_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.L1} > {output.count_nuc}
    """
    
rule L1T:
  input:
    L1 = "Processed/v3/view/spocd1_pi_L1MdT_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_L1T_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.L1} > {output.count_nuc}
    """
    
rule L1Gf:
  input:
    L1 = "Processed/v3/view/spocd1_pi_L1MdGf_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_L1Gf_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.L1} > {output.count_nuc}
    """

rule L1F2:
  input:
    L1 = "Processed/v3/view/spocd1_pi_L1MdF2_{sample}.txt"
  output:
    count_nuc = "Processed/v3/FUTA/{sample}_L1F2_nuc_count.txt"
  shell:
    """
    perl ../perl/First_tenth_base_ID_seq_3.pl {input.L1} > {output.count_nuc}
    """
    
