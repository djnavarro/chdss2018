# CHDSS 2018

This repository contains source materials and content for the 2018 Complex Human Data Summer School. It is organised as an R Markdown website that is hosted at:

https://djnavarro.github.io/chdss2018/

The structure of the site is slightly unusual for an R Markdown website. Because an R Markdown site expects all `.Rmd` files to be in the root directory, all of the "main" pages that make up the website are stored there, and the resources for each day of the workshop are stored in static subdirectories `day0`, `day1`, etc, that are copied to the site folder when the site is rendered. 

By default, R Markdown websites place the static files in `_site`, but in this case the site folder has been moved to `docs` to ensure that this directory is rendered on GitHub pages.

The Day 2 content is slightly different, however, as it was designed to be an R Markdown website in and of itself. The way I've dealt with this is to exclude the `day2` directory from the main site, so when you do this:

```
rmarkdown::render_site(input = ".")
```

everything renders *except* Day 2. To render all the pages in day 2, the command needed is

```
rmarkdown::render_site(input = "day2")
```

Then you need to manually copy the `./day2/_site/` directory to `./docs/day2/`. It's a little clunky buty it works. Another thing to keep in mind, regarding the Day 2 content, in practice, it's super slow to render the whole thing, so you might want to knit individual files. That works fine for the regular tutorial pages, but it produces weirdness with the slides because `xaringan` doesn't play nicely with `day2/_site.yml` so you need to temporarily rename that to make th slides render. That works fine, but when you do, `xaringan` will knit to theday 2 directory, not the `day2/_site` directory, so you'll need to manually copy the HTML and static files. Annoying, but still way faster than rendering the whole site every time