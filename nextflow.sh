#!/bin/bash

# Define paths to input data
BCL_PATH="/path/to/bcl"
REFERENCE_GENOME="/path/to/reference.fasta"

# Define the path to the Nextflow script
NEXTFLOW_SCRIPT="genomic_processing_workflow.nf"

# Run the Nextflow workflow
nextflow run $NEXTFLOW_SCRIPT --bcl_path $BCL_PATH --reference_genome $REFERENCE_GENOME -profile local
