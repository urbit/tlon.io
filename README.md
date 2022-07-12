# Tlon

[Tlon](https://en.wikipedia.org/wiki/Tl%C3%B6n,_Uqbar,_Orbis_Tertius) is the company that builds [Urbit](https://urbit.org). This is the Tlon website, hosted at [tlon.io](https://tlon.io).


<details><summary>🔧</summary>
<p>

### Installation

```bash
# install zola (macOS)
$ brew install zola

# install tailwind for css
$ yarn
```

### Running

```bash
# dev
$ yarn run dev
# runs 2 dev commands in parallel:
#   - watches css/style.css and builds to static/style.css
#     on changes (for tailwind)
#   - runs `zola serve` and serves the frontend to
#     http://localhost:1111

# build
$ yarn run build
# builds and minifies css/style.css to public/style.css
# and then runs `zola build` to build the rest of the site

# you can test your build locally by running
# npx serve public -p 1111
# and then visiting http://localhost:1111
```

</p>
</details>
