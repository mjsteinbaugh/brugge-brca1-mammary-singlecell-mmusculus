# Run cellranger on Orchestra
# Not yet compiled for O2
base_dir="/n/data1/cores/bcbio/PIs/joan_brugge/brca1_mouse_mammary_scrnaseq"
# module load seq/cellranger/2.0.0

# Look up the help for v2.0.0
# cellranger count --help

# 1. If you demultiplexed with 'cellranger mkfastq' or directly with
#    Illumina bcl2fastq, then set --fastqs to the project folder containing
#    FASTQ files. In addition, set --sample to the name prefixed to the FASTQ 
#    files comprising your sample. For example, if your FASTQs are named:
#        subject1_S1_L001_R1_001.fastq.gz
#    then set --sample=subject1

# https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/count

fastqs="$base_dir/data-raw/2017-05_sequencing_run1/fastq,$base_dir/data-raw/2017-06_sequencing_run2/fastq"
transcriptome="$base_dir/annotations/refdata-cellranger-mm10-1.2.0"

cellranger count --id=sample_6189 \
                 --sample=6189 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
cellranger count --id=sample_6191 \
                 --sample=6191 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
cellranger count --id=sample_6207 \
                 --sample=6207 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
cellranger count --id=sample_6209 \
                 --sample=6209 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
cellranger count --id=sample_6308 \
                 --sample=6308 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
cellranger count --id=sample_6311 \
                 --sample=6311 \
                 --fastqs=$fastqs \
                 --transcriptome=$transcriptome
