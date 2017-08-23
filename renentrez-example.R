#short demo of rentrez
# if you rather python tools look at biopython -- has entrez search

library(devtools)
install_github("ropensci/rentrez")

#Uses the EUtils API
#Read more [EUtils](http://www.ncbi.nlm.nih.gov/books/NBK25500/)
#Working with the EUtils API will often require making multiple calls using the entrez package.
#Python has similar functionality in the Biopython module; http://biopython.org/wiki/Main_Page

#Use DOI from an article on women's cancer. 
#A Simple Example:
#Use a DOI to return the PMID of an article using `entrez_search`
#Tamoxifen and contralateral breast cancer in BRCA1 and BRCA2 carriers: An update (DOI: 10.1002/ijc.21536)

library(rentrez)
wcancer_paper <- entrez_search(db="pubmed", term="10.1002/ijc.21536[doi]")
# uncomment these to run diff. article searches
#wcancer_paper <- entrez_search(db="pubmed", term="10.1002/ijc.21536[doi]")
#wcancer_paper <- entrez_search(db="pubmed", term="10.1007/s10689-007-9171-7[doi]")
wcancer_paper$ids

#Link data NCBI has for the article using `entrez_link`
wcancer_data <- entrez_link(db="all", id=wcancer_paper$ids, dbfrom="pubmed")
wcancer_data

# See what databases are linked to the PMID
wcancer_data$links

wcancer_gene <- entrez_fetch(db="protein", id=wcancer_data$links$pubmed_gene, rettype="fasta")
cat(substr(wcancer_gene, 1, 237))


  