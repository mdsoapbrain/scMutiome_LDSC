#!/bin/bash

# Input parameters
BED_DIR="/home/danny/LDSC_chr_bed/"
OUTPUT_DIR="/home/danny/LDSC_results/"
BIM_DIR="/home/danny/REF"

# Other parameters
RESULTS_DIR="/home/danny/tmp/"
sumstats_dir="/home/danny/LDSC_inputs/"
weights_dir="/home/danny/REF/weights_hm3_no_hla/"

# Get list of all bed files
BED_FILES=( ${BED_DIR}*.bed )

# Generate annotation files and calculate LD Scores for each chromosome
for BED_FILE in ${BED_FILES[@]}; do
  samp=$(basename $BED_FILE .bed)
  
  for CHR in {1..22}; do
    BIMFILE=${BIM_DIR}/1000G_EUR_Phase3_plink/1000G.EUR.QC.${CHR}.bim

    python /home/danny/ldsc/make_annot.py --bed-file ${BED_FILE} --bimfile ${BIMFILE} --annot-file ${OUTPUT_DIR}/${samp}.${CHR}.annot.gz 

    python /home/danny/ldsc/ldsc.py --l2 --bfile ${BIM_DIR}/1000G_EUR_Phase3_plink/1000G.EUR.QC.${CHR} --ld-wind-cm 1 --annot ${OUTPUT_DIR}/${samp}.${CHR}.annot.gz --thin-annot --out ${OUTPUT_DIR}/${samp}.${CHR} \
    --print-snps /home/danny/REF/1000G_EUR_Phase3_baseline/print_snps.txt &> ${OUTPUT_DIR}${samp}.${CHR}.ldsclog
  done

  # Run LDSC analysis for each sumstats file
  sumstats_files=( "${sumstats_dir}"/*.sumstats.gz )
  for sumstats_file in "${sumstats_files[@]}"; do
    # Extract the filename without the directory path and extension
    filename=$(basename "$sumstats_file")
    filename_without_ext="${filename%.*}"

    # Output file path
    output_file="${RESULTS_DIR}${samp}_${filename_without_ext}_h2"

    # Run LDSC analysis
    python /home/danny/ldsc/ldsc.py \
    --h2 "$sumstats_file" \
    --ref-ld-chr "${OUTPUT_DIR}${samp}." \
    --w-ld-chr "${weights_dir}weights." \
    --out "$output_file" \
    --overlap-annot \
    --frqfile-chr /home/danny/REF/1000G_Phase3_frq/1000G.EUR.QC. \
    --print-coefficients

    # Print a newline for clarity
    echo
  done
done
