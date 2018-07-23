# Cell Ranger
# 2018-06-19

module load bcl2fastq/2.20.0.422
module load cellranger/2.1.1

localcores=$SLURM_CPUS_PER_TASK
localmem=128



# mkfastq ======================================================================
# # https://support.10xgenomics.com/single-cell-gene-expression/software/pipelines/latest/using/mkfastq
# Point to the Illumina BCL run directory
# Use a CSV file to specify the samples (see 10X website for examples)
# cellranger mkfastq --help
# If you want to remove the Undetermined FASTQs from the output to save space, you can run mkfastq with the --delete-undetermined

# cellranger mkfastq \
#     --run=../data-raw/20180508_10X_OlderParousMice/180424_SL-HXM_0704_AFCHK2VYCCXY \
#     --csv=mkfastq.csv \
#     --localcores=$localcores \
#     --localmem=$localmem



# count ========================================================================
# WT-A-CML6022-p8
# WT-B-CML3403-p7
# WT-C-CML0001-p4
# Het-A-CML6029-p9
# Het-B-CML6028-p7
# Het-C-CML6027-p4

fastqs="HK2VYCCXY"
transcriptome="/n/data1/cores/bcbio/10x_genomics/cellranger/refdata/refdata-cellranger-mm10-1.2.0"

# cellranger count \
#     --id=WT-A-CML6022-p8 \
#     --sample=WT-A-CML6022-p8 \
#     --fastqs=$fastqs  \
#     --transcriptome=$transcriptome \
#     --localcores=$localcores \
#     --localmem=$localmem \
#     --nosecondary

cellranger count \
    --id=WT-B-CML3403-p7 \
    --sample=WT-B-CML3403-p7 \
    --fastqs=$fastqs  \
    --transcriptome=$transcriptome \
    --localcores=$localcores \
    --localmem=$localmem \
    --nosecondary

cellranger count \
    --id=WT-C-CML0001-p4 \
    --sample=WT-C-CML0001-p4 \
    --fastqs=$fastqs  \
    --transcriptome=$transcriptome \
    --localcores=$localcores \
    --localmem=$localmem \
    --nosecondary

cellranger count \
    --id=Het-A-CML6029-p9 \
    --sample=Het-A-CML6029-p9 \
    --fastqs=$fastqs  \
    --transcriptome=$transcriptome \
    --localcores=$localcores \
    --localmem=$localmem \
    --nosecondary
cellranger count \
    --id=Het-B-CML6028-p7 \
    --sample=Het-B-CML6028-p7 \
    --fastqs=$fastqs  \
    --transcriptome=$transcriptome \
    --localcores=$localcores \
    --localmem=$localmem \
    --nosecondary

cellranger count \
    --id=Het-C-CML6027-p4 \
    --sample=Het-C-CML6027-p4 \
    --fastqs=$fastqs  \
    --transcriptome=$transcriptome \
    --localcores=$localcores \
    --localmem=$localmem \
    --nosecondary
