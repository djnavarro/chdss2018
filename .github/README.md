# CHDSS 2018

https://djnavarro.github.io/chdss2018/

This unifies the three separate repositories:

- the website
- the day2 site
- the resources for other days

It's set up so that when you try to render the site from the root page, it completely ignores day2. From the project root:

```
rmarkdown::render_site(input = ".")
rmarkdown::render_site(input = "day2")
```

Then you need to manually copy the `./day2/_site/` directory to `./docs/day2/`


## Notes on the day2 subsite

Note to self, because I *will* forget this...

- In principle, the entire site can be generated using `rmarkdown::render_site()` as noted above
- In practice, it's super slow
- Knitting individual files works, but `xaringan` doesn't play nicely with `_site.yml` so you need to temporarily rename that. But when you do, `xaringan` will knit to the root directory, so you'll need to manually copy the HTML and static files to the `docs` directory.
- Annoying, but still way faster than rendering the whole site every time