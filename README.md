# function-harke-proteinspace

Plots were constructed from all assemblies where a peptide file was present. Predicted proteins were quantified using grep -c ">" filename.pep and a table created with assoicated metadata (eukMetaInt_proteinNum.csv). Samples processed by individual labs (HS039) were hidden with a random naming convention. Plots were generated in R with ggplot2 faceting different variables as found in the eukMetaInt_proteinNum.csv file. For plotting predicted protein abundance, plots were split by HS039, CAGs, and MAD with a CAG with high abundance.

For any questions, contact Matt Harke, matthew.harke@gmgi.org
