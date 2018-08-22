<%@page import="com.dotmarketing.beans.Host"%>
<%@page import="com.dotmarketing.beans.Identifier"%>
<%@page import="com.dotmarketing.business.APILocator"%>
<%@page import="com.dotmarketing.util.UtilMethods"%>
<%@page import="com.dotmarketing.plugin.business.PluginAPI"%>
<%@page import="com.dotmarketing.business.web.WebAPILocator"%>

var tinyMCEProps = {
            
			selector: "textarea",
			theme : "modern",
            menubar: true,
            statusbar: true,
			resize : "both",
        	<%
        		// Set the PLUGINS theme
        		final PluginAPI pluginAPI = APILocator.getPluginAPI();
            	final String PLUGIN_NAME = "org.dotcms.tinymce_extended";
				final String plugins1 = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_PLUGINS1");
				final String plugins2 = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_PLUGINS2");
				if (UtilMethods.isSet(plugins1) && UtilMethods.isSet(plugins2)) { %>
		<%= "plugins : \"" + plugins1 + "," + plugins2 + "\"," %>
			<%  } else if (UtilMethods.isSet(plugins1)) { %>
		<%= "plugins : \"" + plugins1 + "\"," %>
			<%  }
				// Set the WYSIWYG advanced buttons
				int numberOfButtons = 0;
				try {
					numberOfButtons = Integer.parseInt(pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_NUMBER_THEME_BUTTONS"));
				} catch (final Exception e) {
					// An error occurred when parsing the numberOfButtons value. Set to zero
				}
				if (numberOfButtons > 0) {
					for (int i = 1; i <= numberOfButtons; i++) {
                       final String button = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_THEME_BUTTON" + i); %>
		<%= "toolbar" + i + " : \"" + button + "\"," %>
			<%      }
				} else { %>
		<%= "theme_advanced_buttons1 : \"bold,italic,underline,|,justifyleft,justifycenter,justifyfull,justifyright,|,formatselect\"," %>
			<%  } %>
            paste_auto_cleanup_on_paste : true,
            paste_strip_class_attributes : "all",
            convert_urls : true,
            cleanup : true,
            urlconverter_callback : cmsURLConverter,
            verify_css_classes : false,
			<%
				// Get the default CSS file. If doesn't exist load the /html/css/base.css
				final String cssPath = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_CSS");
				Host site = null;
				try {
					site = WebAPILocator.getHostWebAPI().getCurrentHost(request);
				} catch (final Exception e) {
					throw new Exception("The Site could not be retrieved from the HTTP request.", e);
				}
				final Identifier ident = APILocator.getIdentifierAPI().find(site, cssPath);
				if (UtilMethods.isSet(ident.getURI())) { %>
		<%= "content_css : \"" + ident.getURI() + "?" + new java.util.Date().getTime() + "\"," %>
			<%  } else { %>
		<%= "content_css : \"/global/css/base.css?" + new java.util.Date().getTime() + "\"," %>
			<%  } %>
            trim_span_elements : false,
            apply_source_formatting : true,
            valid_elements : "*[*]",
            relative_urls : true,
            document_base_url : "/",
			<%
				// Set the WYSIWYG date formats
				final String dateformat = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_DATEFORMAT");
				if (UtilMethods.isSet(dateformat)) { %>
		<%= "plugin_insertdate_dateFormat : \"" + dateformat + "\"," %>
			<%  } else { %>
		<%= "plugin_insertdate_dateFormat : \"%Y-%m-%d\"," %>
			<%  }
				// Set the WYSIWYG time formats
				final String timeformats = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_TIMEFORMAT");
				if (UtilMethods.isSet(timeformats)) { %>
		<%= "plugin_insertdate_timeFormat : \"" + timeformats + "\"," %>
			<%  } else { %>
		<%= "plugin_insertdate_timeFormat : \"%H:%M:%S\"," %>
			<%  }
            	// Set the Paste Use Dialog
				final String pasteusedialog = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_PASTEUSEDIALOG");
				if (UtilMethods.isSet(pasteusedialog)) { %>
		<%= "paste_use_dialog : " + pasteusedialog + "," %>
			<%  } else { %>
		<%= "paste_use_dialog : true," %>
			<%  }
            	// Set the WYSIWYG block formats
				final String blockformats = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_BLOCKFORMATS");
				if (UtilMethods.isSet(blockformats)) { %>
		<%= "block_formats : \"" + blockformats + "\"," %>
			<%  } else { %>
		<%= "block_formats : \"Paragraph=p;Header 1=h1;Header 2=h2;Header 3=h3\"," %>
			<%  } %>
            gecko_spellcheck : true,
            image_advtab: true,
            file_browser_callback: cmsFileBrowser,
            <%
            	// Set the WYSIWYG time formats
				final String width = pluginAPI.loadProperty(PLUGIN_NAME, "WYSIWYG_WIDTH");
				if (UtilMethods.isSet(width)) { %>
		<%= "width : " + width + "," %>
			<%  } else { %>
		<%= "width : 600" + "," %>
			<%  } %>
		file_picker_callback: function(callback, value, meta) {
			cmsFileBrowser(callback, value, meta);
		}

};
