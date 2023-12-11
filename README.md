This is a Nextflow workflow which performs the initial steps in genomic data processing, including the conversion of BCL (Base Call) files to FASTQ format, alignment of reads to a reference genome sequence, and variant calling. The workflow utilizes various bioinformatics tools for each step.


Workflow Steps:
Step 1: Conversion of BCL to FASTQ
Tool Used: [bcl2fastq](https://
support.illumina.com/sequencing/sequencing_software/bcl2fastq-conversion-software.html)
This step converts raw BCL files located in the specified bcl directory to the standard FASTQ format, which is commonly used for storing raw sequencing data.


Step 2: Alignment to Reference Genome
Tool Used: Bowtie2
This step aligns the converted FASTQ reads to a reference genome sequence, enabling the identification of the genomic locations of the sequenced fragments.

Step 3: Variant Calling
Tool Used: GATK (Genome Analysis Toolkit)
This step performs variant calling on the aligned reads to identify genomic variants such as single nucleotide polymorphisms (SNPs) and insertions/deletions (indels).
