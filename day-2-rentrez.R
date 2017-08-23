install.packages('rentrez')
library(rentrez)
entrez_dbs()
entrez_db_summary('dbvar')
entrez_db_summary('cdd')
entrez_db_searchable('sra')
#https://www.ncbi.nlm.nih.gov/entrez/query/static/help/Summary_Matrices.html#Search_Fields_and_Qualifiers
wcancer <- entrez_search(db="pubmed", term='10.1007/s10689-007-9171-7[doi]')
wcancer$ids
wcan_summary <- entrez_summary(db='pubmed', wcancer$ids)
wcan_summary$title
wcan_summary$authors
nlp_search <- entrez_search(db="pubmed", term = "Natural Language Processing")
nlp_search
nlp_search$ids
another_nlp_search <- entrez_search(db="pubmed", term="Natural Language Processing", retmax=40)
another_nlp_search$ids
entrez_search(db='sra', term="Tetrahymena thermophila[ORGN]", retmax=0)
entrez_search(db='sra', term="(Tetrahymena thermophila[ORGN] OR Tetrahymena borealis[ORGN]) AND 2013:2015[PDAT]", retmax=0)
entrez_db_searchable('sra')
entrez_db_summary('sra')
entrez_search(db='pubmed', term="(vivax malaria) AND (folic acid antagonists)")
viv <- entrez_search(db="mesh", term ="vivax malaria")
viv$file
library(reshape2)
library(ggplo2)

papers_by_year <- function(years, search_term){
  return(sapply(years, function(y) entrez_search(db="pubmed", term=search_term, mindate=y, maxdate=y, retmax=0)$count))
}
years <- 1990:2011
total_papers <- papers_by_year(years, "")
total_papers
omics <- c("genomic", "epigenomic", "metagenomic", "proteomic", "transcriptomic", "pharmacogenomic", "connectomics")
omics
trend_data <- sapply(omics, function(t) papers_by_year(years, t))
class(trend_data)
trend_props <- data.frame(trend_data/total_papers)
trend_props
trend_props$years <- years
trend_props
trend_df <- melt(as.data.frame(trend_props), id.vars = "years")
head(trend_df)
library(ggplot2)
p <- ggplot(trend_df, aes(years, value, colour=variable))
p + geom_line(size=1) + scale_y_log10("number of papers")
all_the_links <- entrez_link(dbfrom='gene', id=351, db="all")
all_the_links
all_the_links$links
all_the_links$links$gene_pmc[1:10]
