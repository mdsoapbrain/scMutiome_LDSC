# scMutiome_LDSC
# LD Score Regression Analysis

This repository contains a bash script for running LD Score Regression (LDSC) analysis. The script generates annotation files, calculates LD Scores for each chromosome, and runs LDSC analysis for each summary statistics file.

## Directory Structure

The script assumes the following directory structure:

- `LDSC_chr_bed/`: Directory containing BED files for each chromosome.
- `LDSC_results/`: Directory where the output files will be stored.
- `REF/`: Directory containing reference files.
- `tmp/`: Temporary directory for storing intermediate files.
- `LDSC_inputs/`: Directory containing input files for LDSC analysis.

## Running the Script

To run the script, navigate to the directory containing the script and use the following command:

```bash
./<script_name>.sh
```
Replace <script_name> with the name of the script.

## Output
The script generates the following output:

- Annotation files for each chromosome in the LDSC_results/ directory.
- LD Scores for each chromosome in the LDSC_results/ directory.
- LDSC analysis results for each summary statistics file in the tmp/ directory.

## Dependencies
The script requires the following software:

Python
LDSC[https://github.com/bulik/ldsc]









