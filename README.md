# TechTV Downloader Bash script

Download all videos from an MIT TechTV collection.

**This has only been tested on Mac OS X Yosemite.**

Find a collection's videos.rss file by right-clicking the "RSS" link from any TechTV collection and selecting "Download Linked File". Then download every video from the collection by calling this script from the command-line:

    $ ./techtv.sh videos.rss
    
The -t flag runs the script in Test Mode, displaying how files would be downloaded and named without downloading any video. This will test whether the script is properly parsing your RSS file and is able to find each video's corresponding web page.

    $ ./techtv.sh -t videos.rss
    
Some original files were lost in a TechTV server incident a few years back. This script normally downloads transcoded MP4 streaming files if the originals cannot be found. If you only want to download original source files, use the -o flag.

    $ ./techtv.sh -o videos.rss
    
If you only want to download videos that are missing their original files but were transcoded to stream, use the -b flag.

    $ ./techtv.sh -b videos.rss

This script visits every page in a TechTV collection and check if the original video file is available. If there is no original file, it will download the basic.mp4 file, which is what plays in the browser window when you visit the webpage yourself.

This script then saves each video in the same directory as the script file, giving it the title from the web page and appropriate file extension. If there are any characters in the title of the video that wouldn't be safe for filenames, those characters are converted to underscores.

Philip Tan (philip@mit.edu)
MIT Game Lab

Installation
------------

1. Create a new folder to hold all the videos you are about to download.
2. Download techtv.sh and put it in the new folder.
3. Use a browser to visit the TechTV collection you wish to download. Find the "RSS" link and right-click on it. Download the RSS file (usually "videos.rss") to your new folder.
3. Open Terminal on Mac OS X. Use the "cd" command to navigate to your new folder.
4. Type the following in Terminal. Substitute "videos.rss" with the name of the RSS file you just downloaded.

        $ chmod +x techtv.sh
        $ ./techtv.sh videos.rss

5. The script will visit each page in the collection and will display the name given to each video as it downloads.

Usage:

      Usage:
          ./techtv.sh [options] FILE

      Options:
          -t    Test mode. Don't download any videos.
          -o    Only attempt to download original source video files.
          -b    Only attempt to download stream-quality video MP4 files missing their original source files.


Thanks to TechTV for many years of wonderful service!
------

**techtv.sh** © 2017 Philip Tan. Released under the [MIT License].<br>
Authored and maintained by Philip Tan with help from [contributors].

Readme format borrowed from [hicat](https://github.com/rstacruz/hicat/blob/master/Readme.md) by [@rstacruz](https://github.com/rstacruz).

> [gamelab.mit.edu](http://gamelab.mit.edu/) &nbsp;&middot;&nbsp;
> GitHub [@mitgamelab](https://github.com/mitgamelab) &nbsp;&middot;&nbsp;
> Twitter [@mitgamelab](https://twitter.com/mitgamelab)

[MIT License]: http://mit-license.org/
[contributors]: http://github.com/mitgamelab/techtv/contributors
