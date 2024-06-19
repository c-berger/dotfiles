
  ------------------------------------------------------------------------
   About pdfview.wlx v1.09
  ------------------------------------------------------------------------

    pdfview.wlx is a basic lister plugin for Total Commander to display 
    pdf-files (portable document format), ps-files (postscript) and 
    eps-files (encapsulated postscript).
        

    
  ------------------------------------------------------------------------
   Installation
  ------------------------------------------------------------------------
 
    To run pdfview.wlx you need to have the latest version of Ghostscript
    installed.
    
    To obtain Ghostscript go to
      https://www.ghostscript.com/download/gsdnld.html

    To install pdfview.wlx simply add these line to your wincmd.ini.
    
    [ListerPlugins]
    0=C:\totalcmd\plugins\pdfview\pdfview.wlx

    Please note, that you have to adjust the path and the plugin number to
    the first unused value.

    

  ------------------------------------------------------------------------
   Configuration
  ------------------------------------------------------------------------
  
    pdfview.wlx supports the new common ini-file for lister plugins called
    lsplugin.ini. This file was introduced with Total Commander 5.51 and
    is stored in the same folder as your wincmd.ini.

    If you're running an older version of Total Commander (e.g. TC 5.50),
    pdfview.wlx stores a file called pdfview.ini in the plugins folder.
    
    
    There are some adjustable configuration settings in the ini-file:
   
      command=<command-string> 
        the parameters passed to ghostscript

      resolution=144
        useful for controlling the density of pixels

      exepath=<path to gswin32c.exe or gswin64c.exe>
        OPTIONAL key to support handmade ghostscript environments.
        You also have to supply the -I<lib-directory> switch to the
        command string.
        Please make sure, that you give all paths in DOS-notation.

    You can adjust the command string which is passed to the Ghostscript
    environment, but this is only recommended for advanced users.
    There are some placeholders in the command string:

      %1    full filename of the pdf-file
      %2    full filepath to the temporary bitmap file
      %3    output resolution
      %4    page number
      


  ------------------------------------------------------------------------
   Usage
  ------------------------------------------------------------------------
  
    Simply scroll through the pdf-, ps- or eps-file and switch pages via 
    the page-up and page-down keys.
    
    If you hold the shift key down while switching a page, a small dialog
    pops up which lets you enter the page number and the output resolution

    The same dialog is accessible via the key 'G' or via the right-click
    menu of the lister window.
    
    
    
  ------------------------------------------------------------------------
   License
  ------------------------------------------------------------------------
  
    pdfview.wlx - Copyright ©2003-2016 Florian Heidenreich

    pdfview.wlx is designed for private use and commercial use without sale
    ("Freeware"), if the following rules are respected:

    The Author, Florian Heidenreich, has no responsibility if errors
    occures in direct or indirect relation with the software.

    pdfview.wlx cannot be used in a military domain or in a similar domain 
    (weapon creation, armament, etc.).

    pdfview.wlx can be distributed through non-commercial channels.

    pdfview.wlx can be distributed through commercial channels if the 
    author, Florian Heidenreich, agrees this delivery.



  ------------------------------------------------------------------------
   Tips and Tricks
  ------------------------------------------------------------------------

    Tips related to output quality
    
    1. If you have Ghostscript 8.00 or above installed, you can supply the
       options 
       -dTextAlphaBits=4 -dGraphicsAlphaBits=4
       after -r%3 to the command string. This will turn antialiasing on.


    2. If you don't like the thumbnail preview option, simply add
       ' | *.pdf *.ps *.eps'
       at 'Configuration, Thumbnails, Get from Lister plugins for'


  ------------------------------------------------------------------------
   Credits
  ------------------------------------------------------------------------

    Sergey Chehuta - who helped me with the hotkey stuff
    http://www.whitetown.com/
    

    
  ------------------------------------------------------------------------
   Autor
  ------------------------------------------------------------------------
  
    Florian Heidenreich - tc at mp3tag dot de - http://www.mp3tag.de

    
    
  ------------------------------------------------------------------------
   Version History
  ------------------------------------------------------------------------

   ------------  ---------------------------------------------------------
   [2016-02-09]  REL: VERSION 1.09
   ------------  ---------------------------------------------------------
   [2016-02-09]  NEW: added support for 64-bit versions of Total Commander.
   
   ------------  ---------------------------------------------------------
   [2007-02-11]  REL: VERSION 1.08
   ------------  ---------------------------------------------------------
   [2007-02-11]  NEW: added support for GPL Ghostscript installations.

   ------------  ---------------------------------------------------------
   [2004-10-31]  REL: VERSION 1.07
   ------------  ---------------------------------------------------------
   [2004-10-31]  CHG: allowing TC to paint border of thumbnails in the
                      background color
   [2004-10-31]  FIX: fixed some memory leaks

   ------------  ---------------------------------------------------------
   [2004-10-30]  REL: VERSION 1.06
   ------------  ---------------------------------------------------------
   [2004-10-30]  NEW: supporting new thumbnail preview for TC >= 6.50
   [2004-10-30]  NEW: added auto-install feature

   ------------  ---------------------------------------------------------
   [2004-02-04]  REL: VERSION 1.05
   ------------  ---------------------------------------------------------
   [2004-02-04]  FIX: scrolling in quick-view mode was not working, after
                      activating the window via left mouse-click

   ------------  ---------------------------------------------------------
   [2003-10-02]  REL: VERSION 1.04
   ------------  ---------------------------------------------------------
   [2003-10-02]  FIX: failed to convert documents when having very long
                      filepaths and a long command string.

   ------------  ---------------------------------------------------------
   [2003-07-28]  REL: VERSION 1.03
   ------------  ---------------------------------------------------------
   [2003-07-24]  FIX: detection of pdf- and ps-files with uncommon
                      extensions sometimes not right.
   [2003-06-24]  FIX: better error handling at registering window class

   ------------  ---------------------------------------------------------
   [2003-06-20]  REL: VERSION 1.02
   ------------  ---------------------------------------------------------
   [2003-06-20]  NEW: detection of pdf- and ps-files with uncommon
                      extensions.

   ------------  ---------------------------------------------------------
   [2003-04-05]  REL: VERSION 1.01
   ------------  ---------------------------------------------------------
   [2003-04-05]  NEW: optional exepath configuration option to support
                      handmade ghostscript environments.

   ------------  ---------------------------------------------------------
   [2003-04-02]  REL: VERSION 1.00
   ------------  ---------------------------------------------------------
   [2003-04-02]  FIX: store default values in ini-file, if section is not
                      present

   ------------  ---------------------------------------------------------
   [2003-03-28]  REL: VERSION 0.99 (release candidate 2)
   ------------  ---------------------------------------------------------
   [2003-03-28]  NEW: 'Zoom In' menu item and hotkey (+)
   [2003-03-28]  NEW: 'Zoom Out' menu item and hotkey (-)
   [2003-03-28]  NEW: 'Actual Size' menu item and hotkey (Enter)
   [2003-03-28]  NEW: 'Fit Width' menu item and hotkey (Ctrl+Enter)

   ------------  ---------------------------------------------------------
   [2003-03-27]  REL: VERSION 0.99 (release candidate 1)
   ------------  ---------------------------------------------------------
   [2003-03-27]  CHG: changed default path of ini-file to lspugin.ini

   ------------  ---------------------------------------------------------
   [2003-03-27]  REL: VERSION 0.99
   ------------  ---------------------------------------------------------
   [2003-03-27]  NEW: added support for eps-files

   ------------  ---------------------------------------------------------
   [2003-03-24]  REL: VERSION 0.98
   ------------  ---------------------------------------------------------
   [2003-03-24]  NEW: added version info
   
   ------------  ---------------------------------------------------------
   [2003-03-24]  REL: VERSION 0.97 (non public release)
   ------------  ---------------------------------------------------------
   [2003-03-20]  NEW: go to page dialog via hotkey 'G'
   [2003-03-20]  NEW: go to page dialog via right-click menu
   [2003-03-20]  NEW: small about dialog via right-click menu
   [2003-03-19]  NEW: support for 'Fit image to window' option
   [2003-03-19]  CHG: changed default resolution to 144 dpi

   ------------  ---------------------------------------------------------
   [2003-03-14]  REL: VERSION 0.96 (non public release)
   ------------  ---------------------------------------------------------
   [2003-03-14]  FIX: switched left/right scrolling
   [2003-03-14]  FIX: did not show files with filenames containing blanks

   ------------  ---------------------------------------------------------
   [2003-03-14]  REL: VERSION 0.95 (non public release)
   ------------  ---------------------------------------------------------
   [2003-03-14]  NEW: 'command'-key in configuration file
   [2003-03-14]  CHG: completely rewrote the ghostscript wrapper

   ------------  ---------------------------------------------------------
   [2003-03-10]  REL: VERSION 0.94
   ------------  ---------------------------------------------------------
   [2003-03-10]  FIX: some problems on update window at page-up/page-down

   ------------  ---------------------------------------------------------
   [2003-03-09]  REL: VERSION 0.93
   ------------  ---------------------------------------------------------
   [2003-03-09]  FIX: unlimited scrolling range at line-down and line-left
   [2003-03-09]  FIX: quickview window lost focus after showing the page 
                      dialog when in quickview mode.

   ------------  ---------------------------------------------------------
   [2003-03-07]  REL: VERSION 0.92
   ------------  ---------------------------------------------------------
   [2003-03-07]  NEW: 'go to page' and resolution dialog while holding
                      the shift key down at a page switch
    
   ------------  ---------------------------------------------------------
   [2003-03-07]  REL: VERSION 0.91
   ------------  ---------------------------------------------------------
   [2003-03-07]  NEW: page-up/page-down jumps to previous/next page
   [2003-03-07]  CHG: removed page dialog

   ------------  ---------------------------------------------------------
   [2003-03-06]  REL: VERSION 0.90
   ------------  ---------------------------------------------------------