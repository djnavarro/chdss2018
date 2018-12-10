# CHDSS Day 2: Data analysis with R

This is the git repository containing all source code and materials associated with Day 2 of the 2018 Complex Human Data Summer School, run in Melbourne December 9-14.  

https://djnavarro.github.io/chdss2018/

The goal in Day 2 is to cover topics relevant to data analysis with R. The coverage is somewhat eclectic: there are sections that discuss tools that will help you with your workflow (e.g., git, R Markdown, etc), sections that discuss how to manipulate and visualise data (e.g., tidyverse), and a section that discusses statistical modelling in R (e.g., linear models, mixed models). Given the breadth of coverage, we won't go into much detail on any topic. You should think of each section as an initial introduction to something that is itself a much larger topic.

Note to self, because I *will* forget this...

- In principle, the entire site can be generated using `rmarkdown::render_site()`
- In practice, it's super slow
- Knitting individual files works, but `xaringan` doesn't play nicely with `_site.yml` so you need to temporarily rename that. But when you do, `xaringan` will knit to the root directory, so you'll need to manually copy the HTML and static files to the `docs` directory.
- Annoying, but still way faster than rendering the whole site every time