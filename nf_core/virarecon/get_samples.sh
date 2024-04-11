# Use a for loop to obtain sample files using fastq-dump
#for i in $(cat nf_core/virarecon/samples.txt); do fastq-dump --split-files $i; done

# Compact the fastq files after download
#gzip *.fastq

# Create a new directory and move the compressed fastq files there
#mv *.fastq.gz data

# Generate samplesheet using nf-core provided python script
#wget -L https://raw.githubusercontent.com/nf-core/viralrecon/master/bin/fastq_dir_to_samplesheet.py

"""Run the python script: this script processes FastQ files in the data directory, and based on specified patterns, it generates a samplesheet in CSV format named samplesheet.csv. The patterns (-r1 and -r2) help the script identify the relevant FastQ files for processing"""
#python3 fastq_dir_to_samplesheet.py data samplesheet.csv -r1 _1.fastq.gz -r2 _2.fastq.gz

# Run viralrecon
nextflow run nf-core/viralrecon -profile singularity \
--max_memory '12.GB' --max_cpus 4 \
--input samplesheet.csv \
--outdir results/viralrecon \
--protocol amplicon \
--genome 'MN908947.3' \
--primer_set artic \
--primer_set_version 3 \
--skip_kraken2 \
--skip_assembly \
--skip_pangolin \
--skip_nextclade \
--platform illumina