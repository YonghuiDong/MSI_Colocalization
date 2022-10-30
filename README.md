# Demo Code for MSI Colocalization Analysis

## Introduction

In-source fragmentation (ISF) is a naturally occurring phenomenon in various ion sources including soft ionization techniques such as matrix-assisted laser desorption/ionization (MALDI). It has traditionally been minimized as it makes the dataset more complex and often leads to mis-annotation of metabolites. Here, we introduce an approach termed PICA (for Pixel Intensity Correlation Analysis) that takes advantage of ISF in MALDI imaging to increase confidence in metabolite identification. In PICA, the extraction, and association of in-source fragments to their precursor ion results in “pseudo-MS/MS spectra” that can be used for identification. We examined PICA using three different datasets, two of them were published previously and included validated metabolites annotation. We show that highly colocalized ions possessing Pearson Correlation Coefficient (PCC) > 0.9 for a given precursor ion, are mainly its in-source fragments, natural isotopes, adduct ions, or multimers. These ions provide rich information for their precursor ion identification. In addition, our results show that moderately colocalized ions (PCC < 0.9) may be structurally related to the precursor ion, which allows the identification of unknown metabolites through known ones. Finally, we propose three strategies to reduce the total computation time for PICA in MALDI imaging. To conclude, PICA provides an efficient approach to extract and group ions stemming from the same metabolites in MALDI imaging and thus allows high-confidence metabolite identification.

## Demo code

The R demo code can be downloaded from the [demo directory](https://github.com/YonghuiDong/MSI_Colocalization/tree/master/Demo). Both Rmd and HTML format are provided.

## Demo data

The demo data is can be donwloaded from MetaboLights with the identifier [MTBLS487](https://www.ebi.ac.uk/metabolights/MTBLS487) or from our [GitHub repo]()

## Acknowledgements

We would like to thank Dr. Zoe Hall for kindly permitting us to use their [MSI dataset](https://www.ebi.ac.uk/metabolights/MTBLS487). 

## How to Cite
