# Capstone Project Database

## Table of Contents

- [Capstone Project Database](#capstone-project-database)
  - [Table of Contents](#table-of-contents)
  - [About the Project](#about-the-project)
  - [Adding a Contributor](#adding-a-contributor)
  - [Get Your Development Environment Ready](#get-your-development-environment-ready)
    - [Clone the Repo](#clone-the-repo)
      - [Windows](#windows)
      - [Linux and Mac](#linux-and-mac)
    - [Install Visual Studio Code (VSCode)](#install-visual-studio-code-vscode)
    - [Ensure You Have the Correct Version of Ruby](#ensure-you-have-the-correct-version-of-ruby)
  - [Installing Dependencies](#installing-dependencies)
  - [Running a Local Version of the Server](#running-a-local-version-of-the-server)
  - [Making Your First Change](#making-your-first-change)
  - [Starting to Contribute](#starting-to-contribute)

## About the Project

This app is intended to serve as a student developed repository for capstone projects made by UWindsor engineering students. As of now, the repo is under active development so stay tuned for changes!

>**_NOTE_**: All contributors are encouraged to add their name to the `.contributors` file at the top level of this repo - doesn't matter if you've made documentation changes, fixed a type in a view or completed refactored the backend!

## Adding a Contributor

Since we are developing in a private repo, an administrator will need to give new contributors access. Reach out to Harrison Scarfone (scarfone@uwindsor.ca) with the email title `REQUEST NEW CONTRIBUTOR ACCESS` if someone you know wants to contribute.

## Get Your Development Environment Ready

Developing on Linux/Mac is highly recommended.

### Clone the Repo
You will need to be able to use `git` on your machine. Skip this section if you've used `git` on your machine before, otherwise read the heading pertaining to your machine.

#### Windows
There are a few options for you to choose from, but I recommend setting up a linux style terminal on your machine called `git for windows`, and a download link can be found [here](https://gitforwindows.org/). Once you have installed it, use it to follow the instructions in the `Linux and Mac` instructions below. Open the program when the instructions ask you to open a `terminal`.

#### Linux and Mac
1. Open a terminal (on Mac, `command+space` to open a spotlight search and type in terminal).
2. Using the terminal, nagivate to your home directory. Create a new folder then clone the directory. Commands are shown below and they assume you want to call the folder `src`. Change `src` where you see it if you want a different name.

```bash
cd ~
mkdir src
cd src
git clone https://github.com/HarrisonScarfone/capstone_repo.git
```

### Install Visual Studio Code (VSCode)
Our team will standardize using `VSCode`, however you are free (and encouraged) to use whatever editor you want! Installation instructions for `VSCode` can be found [here](https://code.visualstudio.com/docs/setup/setup-overview).

>**_NOTE_**: For `MacOS`, I highly recommend you do not follow the instructions from the above link and instead familiarize yourself with `homebrew`, which has become sort of a de facto industry standard as a MacOS package handler (similar to `apt` on debian based linux). Instructions for that can be found [here](https://brew.sh/). The `formulae` for `VSCode` can be found [here](https://formulae.brew.sh/cask/visual-studio-code).

Once you have `VSCode` installed, you can open the new cloned directory. Be sure to open the directory (folder) inside of the `src` folder you created.

>**_NOTE_**: `Linux` and `MacOS` users are encouraged to open the repo from inside the terminal, by ensuring the `code` command opens `VSCode` (it should by default) and using the following command to open the directory `code ~/src/capstone_repo` as some Ruby `gems` (such as `solargraph`) bug out sometimes if you don't.

Once you have `VSCode` open, the following `addons` are recommended. Instructions for installing `addons` can be found [here](https://code.visualstudio.com/docs/editor/extension-marketplace). 

1. Code Spell Checker
2. Git Blame
3. Ruby
4. Ruby Solargraph
5. ruby-rubocop
6. VSCode Ruby

### Ensure You Have the Correct Version of Ruby

> :warning: **If you have not done something like this before**: Take it slow and make sure you follow the directions.  It can be challenging to undo installation of programming languages on your computer (*looking at you windows*) if you do something incorrectly. Just stick to the instructions and you'll be fine!

The version of Ruby we are using can be found in the `.ruby-version` file at the top level in the cloned directory. Assuming you cloned the directory with the steps above, you can check the contents by opening the file `.ruby-version` or if you named your folder `src`, you can use the command shown below.

```bash
cat ~/src/capstone_repo/.ruby-version
```

Instructions for installing Ruby can be found [here](https://www.ruby-lang.org/en/documentation/installation/). It is *highly* recommended that you use a [version manager](https://www.ruby-lang.org/en/documentation/installation/#managers) as described on the site.


## Installing Dependencies

Ensure that your development environment is setup, as shown [here](#get-your-development-environment-ready). Your Ruby environment should come with `bundler` already configured, but if the command fails, you can check out the [bundler docs](https://bundler.io/).

Navigate to your project directory, then run a `bundle install`, as shown below.

```bash
cd ~/src/capstone_repo
bundle install
```

The project dependencies list in the `Gemfile` should have been added, as well a `Gemfile.lock`.

## Running a Local Version of the Server

Once you have [installed the dependencies](#installing-dependencies), navigate to the project directory and run the following command.
```shell
bin/rails server
```
Or just `rails s` as shorthand notation. This will spin up an instance of the server running on `localhost` port 3000. which you can then access in your favorite web browser (preferable `Chrome` or `Firefox`) by typing in the address shown below.

```shell
localhost:3000
```

## Making Your First Change

The `git` integration in `VSCode` is freakin' sweet, and I highly recommend using it. TODO: insert video link. Since this is going to seem complicated if you have never used `git` and `GitHub` before, I will provide a video walk through [here]().

## Starting to Contribute

This assumes you have completed the [making your first change](#making-your-first-change) video, or have knowledge of `git` and `GitHub`.

Check out the [project board](https://github.com/HarrisonScarfone/capstone_repo/projects/1)! A video walk through of our workflow can be found in the video in the [making your first change section](#making-your-first-change). If you've done this sort of thing before, any issue under `Backlog` is fair game. When it comes to PRs (pull requests), we enforce the following rules, which were covered in the video:

1. You *must* have at least 1 review with approval. This will increase to 2 as soon as we have enough contributors to be feasible.
2. The CI (continuous integration) *must* pass to merge. **THERE ARE NO EXCEPTIONS TO THIS**. We have extremely basic CI and all tests and the linter/formatter must pass, its not asking much :).
3. You *must* have unit tests corresponding to any Ruby code you write. All files in `views` are exempt from code testing, but must be verified with before and after screenshots in the PR. Existing `.rake` files are currently the only exception and there will be **ABSOLUTELY NO ADDITIONS** to this rule.
4. You must verify that your code works on a local server instance before merging.
5. All PRs must be based off of and linked to an issue. If there isn't one for what you want to do, make one.
6. *Do not* approve PRs that are clearly in violation of the above rules. You *will* share *equally* in the blame if you approve breaking changes.

> :warning: **Abuse of the Above Requirements Could Result in Your Ability to Contribute Being Revoked**: Sorry to get serious, but DBAA. All contributions here are volunteer work, and not following the rules ruins it for other people which isn't fair.

>**_NOTE_**: Please Please Please ensure that you run tests locally before pushing. Both commands shown below must pass, and we only get so many compute minutes to run CI on a free repo.

```bash
bundle exec rake lint_and_format
rails test
```
