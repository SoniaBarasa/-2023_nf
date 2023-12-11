// Define the workflow
workflow genomic_processing_workflow {

    // Input parameters
    params:
    path('path/to/bcl') bcl_path
    path('path/to/reference.fasta') reference_genome

    // Create channels for the different steps
    // Channel for BCL to FASTQ conversion
    bcl_to_fastq_ch = Channel.fromPath("${bcl_path}/*.bcl")

    // Channel for Bowtie2 alignment
    bowtie2_input_ch = Channel.fromPath("path/to/fastq/*.fastq.gz")

    // Channel for GATK variant calling
    gatk_input_ch = Channel.fromPath("path/to/bowtie2_output/*.bam")

    // Step 1: BCL to FASTQ conversion using bcl2fastq
    process bcl_to_fastq {

        input:
        file bcl_file from bcl_to_fastq_ch

        output:
        path("path/to/fastq") into fastq_output_ch

        script:
        """
        # Assuming bcl2fastq is installed and in the PATH
        bcl2fastq --runfolder-dir ${bcl_file} --output-dir path/to/fastq
        """
    }

    // Step 2: Align reads to a reference genome using Bowtie2
    process bowtie2_align {

        input:
        file fastq_file from bowtie2_input_ch
        file reference_genome

        output:
        path("path/to/bowtie2_output") into bowtie2_output_ch

        script:
        """
        bowtie2 -x ${reference_genome} -U ${fastq_file} | samtools view -bS - > path/to/bowtie2_output/output.bam
        """
    }

    // Step 3: Perform variant calling using GATK
    process gatk_variant_calling {

        input:
        file bam_file from gatk_input_ch

        script:
        """
        # Assuming GATK is installed and in the PATH
        gatk HaplotypeCaller -R ${reference_genome} -I ${bam_file} -O path/to/gatk_output/output.vcf
        """
    }

    // Output channel for the final VCF file
    final_output_ch = gatk_variant_calling.out

    // View the final output channel
    final_output_ch.view()
}
