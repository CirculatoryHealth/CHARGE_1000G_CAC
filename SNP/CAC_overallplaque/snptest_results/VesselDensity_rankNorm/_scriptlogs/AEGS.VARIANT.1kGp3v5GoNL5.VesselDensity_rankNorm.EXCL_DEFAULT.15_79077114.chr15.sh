/hpc/local/CentOS7/dhl_ec/software/snptest_v2.5.4-beta3_linux_x86_64_static/snptest_v2.5.4-beta3 -data /hpc/dhl_ec/data/_ae_originals/AEGS_COMBINED_EAGLE2_1000Gp3v5HRCr11/aegs.qc.1kgp3hrcr11.idfix.chr15.vcf.gz /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/20200912.CAC.AEGS123.sample -assume_chromosome 15 -pheno VesselDensity_rankNorm -frequentist 1 -method expected -use_raw_phenotypes -hwe -lower_sample_limit 10 -cov_names Age Sex PC1 PC2 CHIP ORyear -exclude_samples_where "SELECTION"=="not_selected"  -snpid 15:79077114 -o /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/CAC_overallplaque/snptest_results/VesselDensity_rankNorm/AEGS.VARIANT.1kGp3v5GoNL5.VesselDensity_rankNorm.EXCL_DEFAULT.15_79077114.chr15.out -log /hpc/dhl_ec/svanderlaan/projects/lookups/AE_20200512_COL_MKAVOUSI_MBOS_CHARGE_1000G_CAC/CAC_overallplaque/snptest_results/VesselDensity_rankNorm/AEGS.VARIANT.1kGp3v5GoNL5.VesselDensity_rankNorm.EXCL_DEFAULT.15_79077114.chr15.log 
