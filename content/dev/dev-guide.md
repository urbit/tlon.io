# Tlon Dev Guide

## What is this guide?

This is Tlon's guide for new developers that want to build applications on Urbit. The goal of this guide is to take you from a fresh machine to a working development environment for Urbit applications. This guide assumes macOS, but Linux is also supported (see the Urbit foundation docs for Linux support) It's important this guide remains clear and correct, if you find something broken please let us know at support@tlon.io

## Pre-requisites

### Homebrew

- Homebrew is a package manager for macOS, we'll need it installed in order to install `git-lfs`.
- ```/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"```

### Git LFS

- A package that enables git to work with large files, we'll install this via brew.
- ```brew install git-lfs```

### Visual Studio Code

 - While not technically a prerequisite, there's a hoon syntax highlighting plugin available and this is the editor we recommend [Visual Studio Code](https://code.visualstudio.com/).
 - For the small text file edits in this guide, we'll simply use `nano`.

### The Urbit Git repository

  - We're going to need a local copy of the Urbit source code.
     - ```bash
        git clone https://github.com/urbit/urbit ~/urbit-git
       ```
  - Pull down the files stored using git lfs. 
    - ```bash
      cd ~/urbit-git
      git lfs install
      git lfs pull
      ```

### The Urbit binary

 - First we need to create a directory for the urbit binary, we'll create this in your home directory.
   - ```bash
     mkdir ~/urbit-dev
     ```
 - Next we're going to pull down the latest urbit binary from urbit.org from the newly created directory.
    - ```bash
      cd ~/urbit-dev
      curl -JLO https://urbit.org/install/mac/latest
      ```
  - Now we'll untar the contents of the download into our newly created directory.
    - ```bash 
      tar -zxvf ./darwin.tgz --strip=1
      ```
  - With the urbit binary installed we're ready for the basic dev workflow.

## Development basics

### Fake ships

#### What is a "fake" ship?

 - For local development we'll create a 'fake' ship, this is a local ship that is not connected to the Urbit network. This means we don't need a real ID (eg comet, planet) and can delete and recreate the ship whenever we want to reset things.

#### What is a "pill"?

 - A pill file contains a sequence of events that initializes an urbit ship (its boot sequence). If no pill is specified, the livenet pill is downloaded instead. 
 - Since OS updates propagate through the network, it's possible the default pill file could be slightly out of date.
 - We can manually get the most up to date pill file for local development by cloning down and using the up to date version in the urbit source code repo when starting our fake ship.
   - For fake development ships not talking to the regular network this works well.
   - We don't do this for 'real' ships on the actual network because if you're using a pill that's newer than what your sponsor has (the ship that you get updates from) your sponsor will think you're on an older version.
   - When this happens your sponsor will attempt to upgrade you, but will actually be downgrading you to their verison.
   - There are compiled and uncompiled pills. They are differentiated by a naming convention that adds `-brass` to the compiled pill name. For example, `multi.pill` is the name of a compiled pill and the name of its uncompiled version is `multi-brass.pill`. For the purposes of this guide we'll use compiled pills because they boot faster. An uncompiled pill lets you audit the source code if you need to.
 - In summary, if you're using a fake ship -> get the latest pill, if you're starting a real ship don't worry about pills.

#### Creating a fake ship

 - We can create a local fake ship with the below command. This will create a fake ship named `zod` in our `urbit-dev` directory using the newest `multi.pill` from the urbit code we cloned earlier. This will take a couple of minutes and generate some output in the terminal.
   - ```bash
     ./urbit -F zod -B ~/urbit-git/bin/multi.pill
     ```
 - When it's finished you'll see a command prompt like `~zod:dojo>` - this is the urbit dojo where you can enter and run urbit commands.
 - To exit the dojo type `|exit` or `ctrl-D`.

#### Fake ship networking

 - Fake ships on the same machine can automatically talk to each other (as long as they're from the same star). Let's create a second fake ship named `~bus` and confirm this.
   - ```bash
     ./urbit -F bus -B ~/urbit-git/bin/multi.pill
     ```
 - Now you'll have two local ships, `~zod` and `~bus`.
 - From the newly created `~bus` dojo enter `|hi ~zod` and you'll see that urbit's networking finds the first fake ship we created.
 - Exit the `~bus` dojo with `|exit` or `ctrl-D`.

### Desks

#### What is a desk?

A desk is an independently revision-controlled branch of a ship that uses the Clay filesystem. Each desk contains its own apps, type definitions, files, etc. You can think of a desk like a git branch you're working in.

A basic ship has a `%base`, `%garden`, `%landscape`, `%bitcoin`, and `webterm` desk. The `%base` desk has the kernel and base system software, while other desks are each for different apps.

A desk is a series of numbered commits, the most recent of which represents the current state of the desk. A commit is composed of an absolute time when it was created, a list of zero or more parents, and a map from paths to data.

For building applications to distribute on Urbit, we'll want to work on a new desk.

#### Desk basics

##### Mounting and unmounting Desks

 - Mounting a desk allows you to add files to it (it creates a directory you can see on the host filesystem). Run these commands in the dojo.
   - ```bash
     |mount %base
     ```
 - You can similarly unmount a desk
   - ```bash
     |unmount %base
     ```

##### Setting up a new desk

 - To create a new desk we'll need to merge from an existing one, think of this like creating a new branch.
 - Let's create a new `hello` desk by merging from `%garden` (`garden` is just an old name for the application now referred to as `landscape`).
 - **Note**: Thinking about dependencies:
   - When we merge from `%garden` we start with its base files in our application.
   - Since we're copying these files over, its possible an API change could happen in `urbit-git` while we're building our app.
   - It's good practice to run the merge command at the start of development and prior to deployment (after a fresh pull of `urbit-git`) to make sure it works with the up to date system changes.
  - Let's start up our fake `zod`.
    - ```bash
      cd ~/urbit-dev
      ./urbit zod
      ```
  - Create our desk in the dojo by merging from `%garden`
    - ```bash
      |merge %hello our %garden
      ```
  - Mount `%hello` so we can access it from the host filesystem.
    - ```bash
      |mount %hello
      ```
  - Exit the Dojo with `|exit` or `ctrl-D`.
 - Now we should see `hello` inside the `zod` directory, populated with files.
   - The `sys.kelvin` file specifies the kernel version it's compatible with.
   - The optional `desk.ship` file specifies the original publisher of this desk. Since we merged this from `%garden` its currently set to `~mister-dister-dozzod-dozzod`. Let's change this to our fake ship `~zod`. In practice you'll set this to the ID you want to be seen as the publisher (likely your own Urbit ID). Currently there is no verification that makes sure publishers are honest about this, but eventually there will be.
   - ```bash
     echo "~zod" > ~/urbit-dev/zod/hello/desk.ship
     ```
 - If we had Gall agents in this desk which should be automatically started when the desk is installed, we'd add them to a hoon list in the `desk.bill` file. From our `%garden` merge we currently have this:
   - ```bash
     :~  %docket
         %treaty
         %hark-store
         %hark-system-hook
         %settings-store
     ==
     ```
 - Since we're not adding any agents in this example, we'll remove the `desk.bill` file and some other garden specific directories.
   - ```bash
       rm -rf ~/urbit-dev/zod/hello/desk.bill app gen ted
     ```
 - If you `ls` you should see the following in `hello`:
   - `desk.docket-0 desk.ship     lib           mar           sur           sys.kelvin`
 - The final file we need to edit is `desk.docket-0`. This one's more complicated, so we'll need a text editor.
   - ```bash
     nano desk.docket-0
     ```
   - In the text editor you'll see the following that came in from `%garden`:
   - ```bash
     :~ title+'System'
        info+'An app launcher for Urbit.'
        color+0xee.5432
        version+[1 0 2]
        website+'https://tlon.io'
        license+'MIT'
        base+'grid'
        glob-http+['https://bootstrap.urbit.org/glob-0v4.64ana.19ug9.ik7l6.og080.68ce4.glob' 0v4.64ana.19ug9.ik7l6.og080.68ce4]
     ==
     ```
   - We're going to modify this for our app to the below:
   - ```bash
     :~  title+'Hello'
         info+'A simple hello world app.'
         color+0x81.88c9
         version+[0 0 1]
         website+'https://urbit.org/docs/userspace/dist/guide'
         license+'MIT'
         base+'hello'
         glob-ames+[~zod 0v0]
         image+'https://media.urbit.org/docs/userspace/dist/wut.svg'
     ==
     ```
  - This is a `docket` file. This file sets various options for the desk with a tile and usually a brower-based front-end of some kind. 
  - It mainly configures the appearance of an app's tile, the source of its glob (bundle of client resources like HTML, JS, and CSS files), and some additional metadata.
    - We've given the app a `%title` of "Hello", which will be displayed on the app tile and will be the name of the app when others browse to install it. 
    - We've given the app tile a `%color` of #8188C9, and specified the URL of an `%image` to display on the tile.
    - The `%base` clause specifies the base URL path for the app. We've specified "hello" so it'll be `http://localhost:80/apps/hello/...` in the browser.
      - **Note**: `%base` is only put into `/apps/[base]` here *because* the app is served as a glob through docket. A `%site` would be free to bind wherever.
      - **Note**: `:80` is dependent on urbit being able to bind to that default. If it's in use by something else the port will likely be `:8080`, but you can see which one is in use by looking at the output generated in the terminal when you start your ship. Use the one your ship shows, this guide will assume the defaults are working for examples.
    - For the glob, we've used a clause of `%glob-ames`, which means the glob will be served from a ship over Ames, as opposed to being served over HTTP with a `%glob-http` clause or having an Eyre binding with a `%site clause`. 
    - Next we've specified `[~zod 0v0]`. Since `~zod` is the fakeship we'll install it on, the `%docket` agent will wait for a local upload of the glob, so we can just specify `0v0` here as it'll get overwritten later.
    - The `%version` clause specifies the version as a triple of major version, minor version and patch version. The rest is just some additional informative metadata which will be displayed in App Info.
- With that saved we now have everything we need in the `hello` directory.

##### Committing and installing the changes

 - Let's start our fake ~zod again.
   - ```bash
     cd ~/urbit-dev/
     ./urbit zod
     ```
- Commit and install our changes.
  - ```bash
    |commit %hello
    |install our %hello
    ```
  - You'll see `docket: awaiting manual glob for %hello desk` this is because our `desk.docket-0` files includes a `%glob-ames` clause which specifies our ship as the source, so it's waiting for us to upload the glob.
- Open a browser and navigate to `http://localhost:80`. To get the login code, enter `+code` into the dojo prompt for your ship. For fake `~zod`s, the code is always `lidlut-tabwed-pillex-ridrup`. You'll see our tile, but it says installing with a spinner due to the missing glob.
- **Note**: Why are we using globs to hold separate files instead of copying everything into Clay?
  - We do this as a current VM memory limits work around. Large minimized JS blobs in Clay can't be reduced because each one is one line and unique. This means Clay will grow in size with every JavaScript file permenantly. The decision was made to have the JS remembered by the userspace application instead of writing to clay.
  - This prevents Clay from growing permenantly in size.
  - In the future this will be resolved in two ways: Hoon front-end development and Clay tombstones (so we can fully forget older JS blobs we no longer need).
  - For the purposes of this guide you don't need to worry about this, it's just helpful context for advanced users.

##### Create files for glob

We'll now create the files for the glob. We'll use a very simple static HTML page that just displays "Hello World!" and an image. Typically we'd have a more complex JS web app that talked to apps on our ship through the server API, but for the sake of simplicity we'll forgo that. Let's hop back in the Unix terminal.
 - ```bash
   cd ~
   mkdir hello-glob
   cd hello-glob
   mkdir img
   curl https://media.urbit.org/docs/userspace/dist/pot.svg --output img/pot.svg
   ```
- We've grabbed an image to use in our "Hello world!" page. The next thing we need to add is an `index.html` file in the root of the folder. The `index.html` file is mandatory; it's what will be loaded when the app's tile is clicked. Let's open our preferred editor and create it.
  - ```bash
    nano index.html
    ```
- Paste the following into the editor and save it.
  - ```html
    <!DOCTYPE html>
    <html>
      <head>
        <title>Hello World</title>
        <style>body { text-align: center; }</style>
      </head>
      <body>
        <h1>Hello World!</h1>
        <img src="img/pot.svg" alt="pot" width="219" height="196" />
      </body>
    </html>
    ```

##### Upload to glob

We can now create a glob from the directory. To do so, navigate to `http://localhost:80/docket/upload` in the browser. This will bring up the `%docket` app's Globulator tool.

- Simply select the `hello` desk from the drop-down, click `Choose file` and select the `hello-glob` folder in the the file browser, then hit `glob!`.
- Now if we return to our ship's homescreen, we should see the tile looks as we specified in the docket file: `http://localhost:80`
- And if we click on the tile, it'll load the `index.html` in our glob.
- Our app is working!

##### Publish

The final step is publishing our desk with the `%treaty` agent so others can install it. To do this, there's a simple command in the dojo.
 - ```bash
   :treaty|publish %hello
   ```
   - **Note**: For desks without a docket file (and therefore without a tile and glob), treaty can't be used. Instead you can make the desk public with `|public %desk-name`.
   - **Note**: Desks aren't publicly readable by default, `:treaty|publish` publishes the metadata and also makes the desk publicly readable, like `|public`.

##### Remote install

Let's spin up another fake ship so we can try to install our newly published app.

 - ```bash
   cd ~/urbit-dev
   ./urbit -F bus
   ```
   - Note: For desks without a docket file (and therefore without a tile and glob), users cannot install them through the web interface. Instead remote users can install it from the dojo with `|install ~our-ship %desk-name`.
- In the browser, navigate to http://localhost:8081 and login with `~bus`'s code which can be found by running `+code` in the dojo for `bus`. In this case, the default is `riddec-bicrym-ridlev-pocsef`. Next, type `~zod/` in the search bar, and it should pop up a list of `~zod`'s published apps, which in this case is our `Hello` app.
- When we click on the app, it'll show some of the information from the clauses in the docket file.
- Click `Get App` and it'll ask as if we want to install it.
- Finally, click `Get "Hello"` and it'll be installed as a tile on `~bus` which can then be opened.

##### Summary and links

You've done it! You now have a basic understanding of how to create local fake ships to develop with, how to create a basic glob for a front-end, and how to publish your application to the network.

From here you can use your local environment to learn Hoon and then build and publish applications to the network.

There's a lot of detail to get into from here, but the workflow above will give you the basics to explore further.

 - More about [Docket Files](https://urbit.org/docs/userspace/dist/docket)
 - More about [Glob](https://urbit.org/docs/userspace/dist/glob)
 - Learn [Hoon](https://urbit.org/docs/hoon/overview)

### Advanced tips and tricks

#### Faster fake ship booting

A common part of the development workflow is deleting and creating fake ships. The couple of minutes this takes slows down development. Instead we can create a backup copy of a freshly created fake ship. This way when you want to delete some fake ship you've been working on and reset it, it can be done instantly rather than having to wait for a new one to be created.
 - We'll do this now by backing up the fake `~zod` we just created.
 - First start up `~zod` from our `~/urbit-dev` directory. Notice that we don't need the `-F` argument this time because `~zod` is already created.
   - ```bash
     ./urbit zod
     ```
 - Next mount every desk (this is so we don't have to do this every time after resetting our fake ship). Each of these is one dojo command.
   - ```bash
     |mount %base
     |mount %garden
     |mount %landscape
     |mount %bitcoin
     |mount %webterm
     ```
 - Next shutdown `~zod` with `|exit` or `ctrl-D`.
 - Now we're going to make a copy of our fake ship `~zod` and call it `zod.bk`
   - ```bash
     cp -r zod zod.bk
     ```
 - Then you'll dev with `~zod` like normal, but when you're ready to reset it to a fresh state, instead of creating a new one we'll just delete `~zod` and copy the backup over.
   - ```bash
     rm -r zod
     cp -r zod.bk zod
     ```
 - This will create a new `zod` directory and you can run it as usual with `./urbit zod`.