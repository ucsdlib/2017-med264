rentrez
=======

`rentrez` provides functions that work with the [NCBI Eutils](http://www.ncbi.nlm.nih.gov/books/NBK25500/) API to search, download data from, and otherwise interact with NCBI databases.

    library(devtools)
    install_github("ropensci/rentrez")

Uses the EUtils API
===================

-   Read more \[EUtils\](<http://www.ncbi.nlm.nih.gov/books/NBK25500/>
-   Working with the EUtils API will often require making multiple calls using the entrez package.
-   Python has similar functionality in the Biopython module; <http://biopython.org/wiki/Main_Page>

### A Simple Example:

**Use a DOI to return the PMID of an article using `entrez_search`**

Use an article DOI: [Cancer risk reduction and reproductive concerns in female BRCA1/2 mutation carriers](http://dx.doi.org/10.1007/s10689-007-9171-7). DOI of 10.1007/s10689-007-9171-7.

``` r
library(rentrez)
#wcancer_paper <- entrez_search(db="pubmed", term="10.1007/s10689-007-9171-7[doi]")
wcancer_paper <- entrez_search(db="pubmed", term="10.1002/ijc.21536[doi]")

wcancer_paper$ids
```

    # [1] "16331614"

**Link data NCBI has for the article using `entrez_link`**

``` r
wcancer_data <- entrez_link(db="all", id=wcancer_paper$ids, dbfrom="pubmed")
wcancer_data
```

    # elink object with contents:
    #  $links: IDs for linked records from NCBI
    # 

``` r
wcancer_data$links
```

    # elink result with information from 29 databases:
    #  [1] pubmed_homologene          pubmed_medgen             
    #  [3] pubmed_pmc_refs            pubmed_pubmed             
    #  [5] pubmed_pubmed_alsoviewed   pubmed_pubmed_citedin     
    #  [7] pubmed_pubmed_combined     pubmed_pubmed_five        
    #  [9] pubmed_pubmed_reviews      pubmed_pubmed_reviews_five
    # [11] pubmed_bind                pubmed_books_refs         
    # [13] pubmed_drugs               pubmed_gene               
    # [15] pubmed_gene_rif            pubmed_geoprofiles        
    # [17] pubmed_mesh_major          pubmed_nuccore_refseq     
    # [19] pubmed_nuccore_weighted    pubmed_nucleotide_refseq  
    # [21] pubmed_pccompound          pubmed_pccompound_mesh    
    # [23] pubmed_pcsubstance         pubmed_pcsubstance_mesh   
    # [25] pubmed_protein_refseq      pubmed_protein_weighted   
    # [27] pubmed_pubmed_pmh_cited    pubmed_taxonomy_entrez    
    # [29] pubmed_unigene

In R the wcancer\_data object cantains a

### Getting data from an article

1.  We've found an article on [Cancer risk reduction and reproductive concerns in female BRCA1/2 mutation carriers](http://dx.doi.org/10.1007/s10689-007-9171-7). With a DOI of 10.1007/s10689-007-9171-7.
2.  We will find the PMID via the DOI using the entrez function `entrez_search`.

``` r
library(rentrez)
wcancer_risk  <- entrez_search(db = "pubmed", term = "10.1016/j.ympev.2010.07.013[doi]")
#wcancer_risk <- entrez_search(db="pubmed", term="10.1007/s10689-007-9171-7[doi]")
wcancer_risk$ids
```

    # [1] "20674752"

Now, what sorts of data are available from other NCBI database for this paper?

``` r
wcancer_data <- entrez_link(db="all", id=wcancer_risk$ids, dbfrom="pubmed")
wcancer_data
```

    # elink object with contents:
    #  $links: IDs for linked records from NCBI
    # 

In this case all the data is in the `links` element -- the databases linked off the PMID in NCBI:

``` r
wcancer_data$links$pubmed_popset
```

    # [1] "307082412" "307075396" "307075338" "307075274"

``` r
id <- wcancer_data$links$pubmed_popset
wcancer_gene <- entrez_fetch(db="protein", id=id, rettype="fasta")
cat(substr(wcancer_gene, 1, 237))
```

    # >gi|307082412|gb|HQ122450.1| Enchelycore carychroa cytochrome oxidase subunit 1 gene, partial cds; mitochondrial
    # GTCGGCACTGCCCTAAGTCTCCTTATTCGAGCTGAACTTAGTCAACCTGGTGCCCTCTTAGGTGACGACC
    # AGATTTACAACGTCATCGTGACAGCCCATGCCTTCGTAATAATCTTCTTTATA
