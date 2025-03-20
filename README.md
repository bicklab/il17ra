# Genetically predicted interleukin-17-receptor-A abrogates risk of cardiovascular disease in JAK2 clonal hematopoiesis.

## Calculation for genetically predicted IL-17RA levels
We calculated genetically predicted scores of IL-17RA expression using 76 variants from a model trained with Somalogic protein measurements from the INTERVAL study (OPGS000019)

Code:
  

    file_df = pd.read_table('filetable.txt')
    batch_df = pd.read_table('batch_file.txt') 

    
    for chrom in range(1,23): 
      bgen = batch_df.iloc[chrom][1]
      bgen_bgi = batch_df.iloc[chrom][2]
      sample = batch_df.iloc[chrom][3]
      for index, row in df.iterrows():
        name = row['file_name']
        file_id = row['file_id']
        command = f"dx run swiss-army-knife \
      --priority high \
      --instance-type "mem3_ssd1_v2_x16" \
      -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-FxY60F8JkF63k38X9V5BFY55 \
      -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-FxZ2byjJkF65g2vX9Vx8vgb3 \
      -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-GbxY6YQJ5YqBqx9qX6Yyv4Bk \
      -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-Gx33yX8J2p5bpFKJQ356G20G \
      -icmd="plink2 --bgen ukb22828_c19_b0_v3.bgen ref-first \
                  --sample ukb22828_c19_b0_v3.sample \
                  --score Macrophage_migration_inhibitory_factor_19.txt 1 4 6 header list-variants cols=scoresums \
                  --out Macrophage_migration_inhibitory_factor_19" \
      --destination "project-GbjJ860J2p5ZJqZKZZVY883Z:/omics_pred/score_files/" \
      --tag plink2_score \
      -y"



      %%sh
      dx run swiss-army-knife \
         --priority low \
         --instance-type "mem3_ssd1_v2_x16" \
         -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-FxY60F8JkF63k38X9V5BFY55 \
         -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-FxZ2byjJkF65g2vX9Vx8vgb3 \
         -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-GbxY6YQJ5YqBqx9qX6Yyv4Bk \
         -iin=project-GbjJ860J2p5ZJqZKZZVY883Z:file-Gx33yX8J2p5bpFKJQ356G20G \
         -icmd="plink2 --bgen ukb22828_c19_b0_v3.bgen ref-first \
                  --sample ukb22828_c19_b0_v3.sample \
                  --score Macrophage_migration_inhibitory_factor_19.txt 1 4 6 header list-variants cols=scoresums \
                  --out Macrophage_migration_inhibitory_factor_19" \
         --destination "project-GbjJ860J2p5ZJqZKZZVY883Z:/omics_pred/score_files/" \
         --tag plink2_score \
         -y


## Association analysis
We tested the association between gIL-17RA and CVD prevalence with logistic regression and the association between JAK2-CHIP and CVD incidence with time-to-event regression. We used LASSO regression to identify gIL-17RA variants that most significantly abrogate the association between JAK2-CHIP and CVD. We adjusted for age, age-squared, genetic sex, smoking status, genetic ancestry, body mass index, low-density lipoprotein cholesterol level, and baseline status of diabetes, hypertension, and autoimmune diseases (composite of rheumatoid arthritis, psoriasis, psoriatic arthritis, ankylosing spondylitis, and systemic lupus erythematosus). As a sensitivity analysis, the patients with autoimmune diseases were removed.

Code available in: [Association code](https://github.com/bicklab/il17ra/blob/main/KZ_Omicspred_association.ipynb)


## Data
This analysis was performed on the [UK Biobank DNA Nexus Research Analysis Platform](https://ukbiobank.dnanexus.com) and BioVU Terra.bio environment.

## Acknowledgements
This work was supported by National Institutes of Health grant DP5OD029586 (A.G.B.) and National Institutes of Health grant T32GM007347 (Y.P.).  

## Contact
Kun Zhao, kun.zhao@vumc.org; Yash Pershad, yash.pershad@vanderbilt.edu
