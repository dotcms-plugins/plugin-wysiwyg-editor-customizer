plugin-wysiwyg-editor-customizer
=================================

This plugin allows yout to get what you want to see on your WYSIWYG editor and give it your own look and feel. 
This plugin allows you to customize some of the default properties of the WYSIWYG editor and define your own css 
file for it.

Configuration:
==============

The file conf/plugin.properties allows you to override the default values for these parameters:

reload.force: indicates whether the configuration properties are loaded just once
WYSIWYG_CSS: path of the css file
WYSIWYG_THEME: choose between advance or simple
WYSIWYG_PLUGINS: list of the plugins enabled for the editor
WYSIWYG_BLOCKFORMATS: list of block formats available from the editor
WYSIWYG_PASTEUSEDIALOG: enables or disables the dialog box that pops up when pasting content to the editor
WYSIWYG_DATEFORMAT: date format used by the editor
WYSIWYG__TIMEFORMAT: time format used by the editor
WYSIWYG_WIDTH: width of the editor area
WYSIWYG_NUMBER_THEME_BUTTON: number of rows where buttons can be arranged
WYSIWYG_THEME_BUTTON1: buttons to appear on row #1
WYSIWYG_THEME_BUTTON2: buttons to appear on row #2
WYSIWYG_THEME_BUTTON3: buttons to appear on row #3

Usage: 
=======

Once you have the plugin installed on your server, modify the values of the parameters you need to customize. 
Deploy the plugin and start dotCMS; your WYSIWYG editor will be showing the options you just set for it
