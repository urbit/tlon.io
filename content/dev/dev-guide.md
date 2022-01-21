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
 - While not technically a prerequisite, there's a hoon syntax highlighting plugin available and this is the editor we recommend: https://code.visualstudio.com/
 - For the small text file edits in this guide, we'll simply use `nano`.

### Urbit Install
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
      tar zxvf ./darwin.tgz --strip=1
      ```
  - With the urbit binary installed we're ready for the basic dev workflow.

## Development Basics

### Fake Ships
#### What is a "fake" ship?
 - For local development we'll create a 'fake' ship, this is a local ship that is not connected to the urbit network. This means we don't need a real ID (eg comet, planet) and can delete and recreate the ship whenever we want to reset things.
#### Creating a fake ship
 - We can create a local fake ship with the below command. This will create a fake ship named zod in our `urbit-dev` directory. This will take a couple of minutes and generate some output in the terminal.
   - ```bash
     ./urbit -F zod
     ```
 - When it's finished you'll see a command prompt like `~zod:dojo>` - this is the urbit dojo where you can enter and run urbit commands.
 - To exit the dojo type `|exit`
#### Fake ship networking
 - Fake ships on the same machine can automatically talk to each other. Let's create a second fake ship named `~bus` and confirm this.
   - ```bash
     ./urbit -F bus
     ```
 - Now you'll have two local ships, `~zod` and `~bus`.
 - From the newly created `~bus` dojo enter `|hi ~zod` and you'll see that urbit's networking finds the first fake ship we created.
 - Exit the `~bus` dojo with `|exit`

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
 - Next shutdown `~zod` with `|exit`
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

### Desks
#### What is a desk?
A desk is an independently revision-controlled branch of a ship that uses the Clay filesystem. Each desk contains its own apps, mark definitions, files, etc. You can think of a desk like a git branch you're working in.

A basic ship has a `%base`, `%garden`, `%landscape`, `%bitcoin`, and `webterm` desk (we mounted these earlier). The `%base` desk has the kernel and base system software, while other desks are usually each for different apps. 

A desk is a series of numbered commits, the most recent of which represents the current state of the desk. A commit is composed of an absolute time when it was created, a list of zero or more parents, and a map from paths to data.

For building applications to distribute on urbit, we'll want to work on a new desk.

#### Desk Basics

##### Mounting and Unmounting Desks
 - Mounting a desk allows you to add files to it (it creates a directory you can see on your mac). Run these commands in the dojo.
   - ```bash
     |mount %base
     ```
 - You can similarly unmount a desk
   - ```bash
     |unmount %base
     ```
##### Setting Up a New Desk
 - To create a new desk we'll need to merge from an existing one. Typically this will be `%base`, think of this like creating a new branch. A simple example of this command is below, but don't enter it yet - we'll need to do something else first.
   - ```bash
     |merge %mydesk our %base
     ```
 - Every new desk needs a number of base files, in order to simplify this a bit we've created a script that symlinks all the files necessary for interacting with the `%base` and `%garden` desks.
 - In order to use this we'll first want to clone down a local copy of the `urbit` code.
   - ```bash
     git clone https://github.com/urbit/urbit ~/urbit-git
     ```
 - In `urbit-git/pkg` we can see `base-dev` and `garden-dev` desks. These desks contain symlinks to all of the `/sur`, `/lib` and `/mar` files necessary for interacting with the `base` and `garden` desks. Don't worry about these details for now, but we'll be using these to set up our initial environment.
 - Let's create a new `hello` desk.
 - First navigate to the `pkg` directory in `urbit-git`
   - ```bash
     cd ~/urbit-git/pkg
     ```
 - Next create a `hello` directory
   - ```bash
     mkdir hello
     ```
 - Next run the included `symbolic-merge.sh` script from the `pkg` directory.
   - ```bash
     ./symbolic-merge.sh base-dev hello
     ./symbolic-merge.sh garden-dev hello
     ```
 - Now we should see `lib`, `mar`, and `sur` inside `hello`.
 - Our desk must include a `sys.kelvin` file which specifies the kernel version it's compatible with. Let's create that.
   - ```bash
     echo "[%zuse 420]" > sys.kelvin
     ```
 - We can also add a `desk.ship` file to specify the original publisher of this desk. Since we're going to use our fake ship `~zod` let's add `~zod` as the publisher.
   - ```bash
     echo "~zod" > desk.ship
     ```
 - If we had Gall agents in this desk which should be automatically started when the desk is installed, we'd add them to a hoon list in the `desk.bill` file. It would look something like this:
   - ```bash
      :~  %some-app
          %another
      ==
     ```
   - Since we're not adding any agents in this example, we'll **omit the `desk.bill` file**.
 - The final file we need is `desk.docket-0`. This one's more complicated, so we'll need to edit it in a text editor.
   - ```bash
     nano desk.docket-0
     ```
   - In the text editor paste the following and save:
   - ```bash
     :~  title+'Hello'
         info+'A simple hello world app.'
         color+0x81.88c9
         image+'https://media.urbit.org/docs/userspace/dist/wut.svg'
         base+'hello'
         glob-ames+[~zod 0v0]
         version+[0 0 1]
         website+'https://urbit.org/docs/userspace/dist/guide'
         license+'MIT'
     ==
     ```
  - This is a `docket` file. This file sets various options for the desk with a tile and usually a brower-based front-end of some kind. 
  - It mainly configures the appearance of an app's tile, the source of its glob (bundle of client resources like HTML, JS, and CSS files), and some additional metadata.
    - We've given the app a `%title` of "Hello", which will be displayed on the app tile and will be the name of the app when others browse to install it. We've given the app tile a `%color` of #8188C9, and also specified the URL of an `%image` to display on the tile.
    - The `%base` clause specifies the base URL path for the app. We've specified "hello" so it'll be `http://localhost:80/apps/hello/...` in the browser. 
    - For the glob, we've used a clause of `%glob-ames`, which means the glob will be served from a ship over Ames, as opposed to being served over HTTP with a `%glob-http` clause or having an Eyre binding with a `%site clause`. 
    - Next we've specified `[~zod 0v0]`. Since `~zod` is the fakeship we'll install it on, the `%docket` agent will wait for a separate upload of the glob, so we can just specify `0v0` here as it'll get overwritten later.
    - The `%version` clause specifies the version as a triple of major version, minor version and patch version. The rest is just some additional informative metadata which will be displayed in App Info.
- With that saved we now have everythign we need in the `hello` directory.
##### Installing The New Desk Into Fake Zod
- First we're going to create a new fake zod that's bootstrapped with a pill from our urbit-git repo. The pills are stored in git lfs and need to be pulled into our repo first.
  - ```bash
    cd ~/urbit-git
    git lfs install
    git lfs pull
    ```
- Next we're going to create the fake zod using the `multi-brass.pill` we just pulled down.
  - ```bash
    cd ~/urbit-dev
    ./urbit -F zod -B ~/urbit-git/bin/multi-brass.pill
    ```
- Once our new fake zod is booted we'll create and mount a new `%hello` desk in dojo.
  - ```bash
    |merge %hello our %base
    |mount %hello
    ```
- We should now see `hello` inside our `zod` directory.
- Currently it's just a clone of `%base` so let's delete its contents.
  - ```bash
    cd ~/urbit-dev/zod
    rm -r hello/*
    ```
- Next we'll copy the contents of the `hello` desk we created earlier. We'll need to use `cp -LR` to resolve all the symlinks.
  - ```bash
    cp -LR ~/urbit-git/pkg/hello/* hello/
    ```
- Back in the `zod` dojo we can commit the changes and install the desk.
  - ```bash
    |commit %hello
    |install our %hello
    ```
  - You'll see `docket: awaiting manual glob for %hello desk` this is because our `desk.docket-0` files includes a `%glob-ames` clause which specifies our ship as the source, so it's waiting for us to upload the glob.
- Open a browser and navigate to `http://localhost:80` and login with the default fake zod code `lidlut-tabwed-pillex-ridrup`. You'll see our tile, but it says installing with a spinner due to the missing glob.
##### Create Files for Glob
We'll now create the files for the glob. We'll use a very simple static HTML page that just displayes "Hello World!" and an image. Typically we'd have a more complex JS web app that talked to apps on our ship through Eyre's channel system, but for the sake of simplicity we'll forgo that. Let's hop back in the Unix terminal.
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
    <!DOCTYPE html> <html> <head> <style> div { text-align: center; }
    </style> </head> <title>Hello World</title> <body> <div>
    <h1>Hello World!</h1> <img src="img/pot.svg" alt="pot" width="219"
    height="196" /> </div> </body> </html>
    ```
##### Upload to Glob
We can now create a glob from the directory. To do so, navigate to http://localhost:80/docket/upload in the browser. This will bring up the %docket app's Globulator tool.

- Simply select the `hello` desk from the drop-down, click `Choose file` and select the `hello-glob` folder in the the file browser, then hit `glob!`.
- Now if we return to our ship's homescreen, we should see the tile looks as we specified in the docket file: http://localhost:80
- And if we click on the tile, it'll load the index.html in our glob.
- Our app is working!
##### Publish
The final step is publishing our desk with the `%treaty` agent so others can install it. To do this, there's a simple command in the dojo.
 - ```bash
   :treaty|publish %hello
   ```
   - Note: For desks without a docket file (and therefore without a tile and glob), treaty can't be used. Instead you can make the desk public with `|public %desk-name`.

##### Remote Install
Let's spin up another fake ship so we can try to install our newly published app.

 - ```bash
   cd ~/urbit-dev
   ./urbit -F bus
   ```
   - Note: For desks without a docket file (and therefore without a tile and glob), users cannot install them through the web interface. Instead remote users can install it from the dojo with `|install ~our-ship %desk-name`.
- In the browser, navigate to http://localhost:8081 and login with `~bus`'s code `riddec-bicrym-ridlev-pocsef`. Next, type `~zod/` in the search bar, and it should pop up a list of `~zod`'s published apps, which in this case is our `Hello` app.
- When we click on the app, it'll show some of the information from the clauses in the docket file.
- Click `Get App` and it'll ask as if we want to install it.
- Finally, click `Get "Hello"` and it'll be installed as a tile on `~bus` which can then be opened.

##### Summary and Links
You've done it! You now have a basic understanding of how to create local fake ships to develop with, how to create a basic glob for a front-end, and how to publish your application to the network.

From here you can use your local environment to learn hoon and then build and publish applications to the network.

There's a lot of detail to get into from here, but the workflow above will give you the basics to explore further.

 - More about [Docket Files](https://urbit.org/docs/userspace/dist/docket)
 - More about [Glob](https://urbit.org/docs/userspace/dist/glob)
 - Learn [Hoon](https://urbit.org/docs/hoon/overview)
