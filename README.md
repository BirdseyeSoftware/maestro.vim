# maestro.vim

Maestro allows you to push the contents of a CSS buffer to the Browser,
allowing to have a "live editing" CSS workflow from your Vim editor.

## Installation

Choose the one you like

* Install via [neobundle](https://github.com/shougo/neobundle.vim)
* Install via [pathogen](https://github.com/tpope/vim-pathogen)

## Commands

:MaestroCssPush

Pushes the contents your CSS file to the Browser through Maestro.

:MaestroCssAutoPush

Enables automatic content pushes of your CSS file to the Browser through
Maestro. This pushes the CSS contents on 2 different events, CursorHoldI and
InsertLeave

:MaestroDisableCssAutoPush

Disables automatic content pushes of your CSS file to the Browser.

## Note

If you have been directed to this page, is because you know
about the [maestro](http://beta.maestro.io) project.

## Note for power Vim users

* maestro.vim changes `updatetime` to 800 ms when auto-push is enabled, 
  this is to give instant feedback on CSS changes. When auto-push is disabled
  the original value is restored.
