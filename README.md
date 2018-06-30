# This is the source for https://tlon.io

The live contents live in `/dist`.

You can generate the output by using the Urbit static site generator.

Steps:

- Clone this repo inside of `home/web/pages` in a running Urbit.
- Run `|start %static` to start the static site generator.
- Run `:static|build %/web/pages/tlon.io/index %/web/pages/tlon.io/dist` to compile the output.

That's it.

Notes:

- `css/custom.css` exists because of a few base.css bugs
- `base.css` shouldn't be included, but should be a dependency. Not sure what the best way to do that is.
