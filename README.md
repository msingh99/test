# Handicap Review Source code

This is the primary source code for Handicap Review (HCR) site located at https://www.handicapreview.com/

HCR has been written on top of CodeIngiter 3.1.x

## Download the site

In order to fully run the site locally, you're going to need two repositories - the db and this site:

* https://bitbucket.org/handicapreviewcore/handicap-review/
* https://bitbucket.org/handicapreviewcore/handicap-db

Downloads as instructed, e.g. 
```bash
mkdir -p {were you want to store the source code}
# e.g. mkdir -p ~/Documents/HandicapReview/source
cd {source}
# e.g. cd ~/Documents/HandicapReview/source

git clone git@bitbucket.org:handicapreviewcore/handicap-review.git
git clone git@bitbucket.org:handicapreviewcore/handicap-db.git
```

You will get the following directory structure:

```
{source directory}
    \-- handicap-review/
        \-- [all the files]
    \-- handicap-db/
        \-- mysql/
```

The structure is important if you want hands-free launching of the site through Docker.

## Docker

HCR site can be ran dockerized on our local system. This will give you the ability to:
* Start from scratch at any time
* Run the HCR site without the need for installing all the tools locally
* Run multiple sites independently without collision

### Getting Started with Docker

Download and install Docker for your given environment:

* [Docker for macOS](https://docs.docker.com/docker-for-mac/)
* [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
* [Docker CE for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-ce)

### Launching Handicap Review

Change directory into Handicap's source directory, copy the .dist files locally, and run HCR

```bash
cd {source}/handicap-review/
cp docker-compose.override.dist.yml docker-compose.override.yml
docker-compose up -d
```

Site back and wait. You can run `docker-compose logs -f` to see what's going on. You want to wait until you see:
```
hcr_www  | 2019-07-19 15:21:25,673 INFO success: php-fpm entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
hcr_www  | 2019-07-19 15:21:25,673 INFO success: nginx entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
```

That means `www` (website) service is up and running, waiting for connections.

You can now view your site: http://localhost:8080/

### docker-compose.override.yml

This file is a special `docker-compose` file for locally overriding settings within the parent `docker-compose.yml`. It's useful
for development work, opening local ports into your container, etc. I recommend reading up on it when you have time.

* https://docs.docker.com/compose/extends/

#### `ports:`
This directive is how you access your containers from your local computer. By default, Docker is going to create an _internal_
network for your containers to communicate with each other. Ports, db and web, will be open, but only internally. You use this
directive to map them onto your localhost box. 

Format is: [host]:[container], e.g. `8080:80` will map port `8080` of your local box to port `80` of your container. 

This is important to understand. If you ever run into "Bind for 0.0.0.0:## failed: port is already allocated" errors, 
It means a port on your *local box* is taken by something else. Change the first number to get around that.

## Advanced Docker configurations

### Performance

There is a known issue with [macOS (and Windows?)](https://stories.amazee.io/docker-on-mac-performance-docker-machine-vs-docker-for-mac-4c64c0afdf99) 
when mounting volumes with a large number of files. It's annoying and has yet to be fixed in the years. The solution for now is to
use `docker-sync`.

#### docker-sync

To install docker-sync, you'll need `gem` to be installed locally. You can install `gem` through [homebrew](https://brew.sh/), assuming you have Homebrew installed.
```bash
gem install docker-sync
```

Once installed, it's a simple `start` command to launch the site: `docker-sync-stack start`*

<sup>*This will foreground, so I suggest opening a separate terminal window to run it</sup>

### Local DNS Resolution

If you have multiple sites or just tired of accessing "localhost" for all sites, there's a way around this using `dnsmaq`.

(more to come)
