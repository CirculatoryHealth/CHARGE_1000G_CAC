#!/bin/bash
#
/hpc/local/CentOS7/dhl_ec/software/snptest_v2.5.4-beta3_linux_x86_64_static/snptest_v2.5.4-beta3 -data /hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_EAGLE2_1000Gp3v5HRCr11/aegs.qc.1kgp3hrcr11.idfix.chr6.vcf.gz /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/SNP/20210924.CAC.AEGS123.sample -assume_chromosome 6 -pheno Fat40 -frequentist 1 -method expected -use_raw_phenotypes -hwe -lower_sample_limit 10 -cov_names Age Sex PC1 PC2 CHIP ORyear -exclude_samples_where "SELECTION"=="not_selected"  -snpid 6:12908077 -o /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/SNP/CAC_overallplaque/snptest_results/Fat40/AEGS.VARIANT.1kGp3v5GoNL5.Fat40.EXCL_DEFAULT.6_12908077.chr6.out -log /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/SNP/CAC_overallplaque/snptest_results/Fat40/AEGS.VARIANT.1kGp3v5GoNL5.Fat40.EXCL_DEFAULT.6_12908077.chr6.log 
