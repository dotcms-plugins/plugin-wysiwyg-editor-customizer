# This plugin deprecated - please use field variables to control the WYSIWYG 

Wysiwyg Editor Customizer
=================================

Get what you want to see on your WYSIWYG editor and give it your own look and feel. This plugin allows you to customize some of the default properties of the WYSIWYG editor and define your own CSS file for it.

Configuration:
==============

**IMPORTANT:** Only the Modern theme is available for TinyMCE 4. Basic and Advanced themes are no longer supported.

The file `conf/plugin.properties` allows you to override the default values for these parameters:

1) **reload.force**: indicates whether the configuration properties are loaded just once.

2) **WYSIWYG_CSS**: path of the css file.

3) **WYSIWYG_PLUGINS**: list of the plugins enabled for the editor.

4) **WYSIWYG_BLOCKFORMATS**: list of block formats available from the editor.

5) **WYSIWYG_PASTEUSEDIALOG**: enables or disables the dialog box that pops up when pasting content to the editor.

6) **WYSIWYG_DATEFORMAT**: date format used by the editor.

7) **WYSIWYG__TIMEFORMAT**: time format used by the editor.

8) **WYSIWYG_WIDTH**: width of the editor area.

9) **WYSIWYG_NUMBER_THEME_BUTTON**: number of rows where buttons can be arranged.

10) **WYSIWYG_THEME_BUTTON1**: buttons to appear on row #1.

11) **WYSIWYG_THEME_BUTTON2**: buttons to appear on row #2.

12) **WYSIWYG_THEME_BUTTON3**: buttons to appear on row #3.

13) **WYSIWYG_THEME_BUTTON4**: buttons to appear on row #4.


Usage: 
=======

**IMPORTANT:** Because of internal references in the source code, the name of this plugin must always be `org.dotcms.tinymce_extended`

Once you have the plugin installed on your server, modify the values of the parameters you need to customize. Deploy the plugin and start dotCMS; your WYSIWYG editor will be showing the options you just set for it.
