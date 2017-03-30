<%-- 
Use this file to configure TinyMCE plugins.
The plugins must be placed in the tinymce directory on your plugin.

You need to 

Please be aware that only one dotCMS plugin can provide the TinyMCE plugins config file (this file).
The first plugin  according to the normal plugin loading order rules will be the one whose config file is used.

Place a section like this on your web-ext.xml to have dotCMS use your config (remove hello.world with your plugin name):

<servlet>
	<servlet-name>hello.world.tiny_mce_config</servlet-name>
	<servlet-class>org.apache.jsp.plugins.hello.world.tiny_005fmce_005fconfig_jsp</servlet-class>
</servlet>

<servlet-mapping>
	<servlet-name>hello.world.tiny_mce_config</servlet-name>
	<url-pattern>/html/portlet/ext/contentlet/field/tiny_mce_config.jsp</url-pattern>
</servlet-mapping>
  
Once plugins are deployed to the server, they will will be prefixed with plugin_XXXX_ (where XXXX is your plugin name).
Therefore your config must use this name.  Also, you need to make sure the TinyMCE plugin is registering itself with the correct name.
This normally happens in editor_plugin.js in this line:

tinymce.PluginManager.add('myplugin', tinymce.plugins.TinyMCECssExtras);

Which shuold be changed to read:

tinymce.PluginManager.add('plugin_hello.world_myplugin', tinymce.plugins.TinyMCECssExtras);

Make sure your plugin has no - character in its name. Use _ instead.

--%>

<%@page import="com.dotmarketing.portlets.contentlet.model.Contentlet"%>
<%@page import="com.dotmarketing.portlets.fileassets.business.FileAsset"%>
<%@page import="com.dotmarketing.beans.Host"%>
<%@page import="com.dotmarketing.beans.Identifier"%>

<%@page import="com.dotmarketing.util.Config"%>
<%@page import="com.dotmarketing.business.APILocator"%>
<%@page import="com.dotmarketing.util.UtilMethods"%>
<%@page import="com.dotmarketing.business.web.WebAPILocator"%>
<%@page import="com.dotmarketing.util.InodeUtils"%>
<%@page import="com.dotmarketing.business.web.UserWebAPI"%>
<%@page import="com.dotmarketing.business.RoleAPI"%>
<%@page import="com.dotmarketing.business.Role"%>
<%@page import="com.liferay.portal.model.User"%>
<%@page import="java.util.List"%>


var tinyMCEProps = {
            
            selector: "textarea",
            <% /*Set the WYSIWYG THEME*/
               String theme =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_THEME");
               if(UtilMethods.isSet(theme)){
               
                UserWebAPI userWebApi = WebAPILocator.getUserWebAPI();
                RoleAPI roleApi = APILocator.getRoleAPI();
            if(userWebApi.isLoggedToBackend(request)) {
         User currentUser = userWebApi.getLoggedInUser(request);
         
         String[] roleKeyList  = APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "ROLE_KEY_SIMPLE").split(",");
         
            String roleString = APILocator.getRoleAPI().getUserRole(currentUser).getName();
            for(String roleKey : roleKeyList) {
                if(roleApi.doesUserHaveRole(currentUser, roleApi.loadRoleByKey(roleKey))) {
                    theme = "simple";
                        }
			        }
			    }
               
               %>
               <%="theme : \""+theme+"\","%>
               <%
               }else{
               %>
               <%="theme : \"advanced\","%>
               <%
               }
            %>
            menubar: true,
            statusbar: true,
            resize : "both",
                        <% /*Set the PLUGINS THEME*/
               String plugins1 =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_PLUGINS1");
               String plugins2 =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_PLUGINS2");
               if (UtilMethods.isSet(plugins1) && UtilMethods.isSet(plugins2)) { %>
               <%="plugins : \""+plugins1 + "," + plugins2 + "\","%>
               <% } else { %>
               <%="plugins : \""+plugins1 + "\","%>
               <% } %>
             <%/*Set the WYSIWYG ADVANCED BUTTONS*/
               int numberOfButtons = 0;
               try {
                   numberOfButtons = Integer.parseInt(APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_NUMBER_THEME_BUTTONS"));
               }catch(Exception e){                
               }
               if(numberOfButtons > 0){
                   boolean isButtonSet =false;
                   for(int i =1;i <= numberOfButtons;i++){
                       String button =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_THEME_BUTTON"+i);
                       %>
                       <%="toolbar"+i+" : \""+button+"\","%>
                       <%
                   }
               } else {
                   %>
                 <%="theme_advanced_buttons1 : \"bold,italic,underline,|,justifyleft,justifycenter,justifyfull,justifyright,|,formatselect\","%>
                 <%
               }          
            %>

            paste_auto_cleanup_on_paste : true,
            paste_strip_class_attributes : "all",
            convert_urls : true,
            cleanup : true,
            
            urlconverter_callback : cmsURLConverter,
            verify_css_classes : false,
           <%
            //Get the default CSS file if doesn't exist load the /html/css/base.css
            String cssPath =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_CSS");
//          Host host = HostFactory.getCurrentHost(request);
            Host host = null;
           try {
               host = WebAPILocator.getHostWebAPI().getCurrentHost(request);
           }catch(Exception e){                
           }
            //cssPath = cssPath.replaceAll(Config.getStringProperty("VIRTUAL_FILE_PREFIX"), "");
            FileAsset file = null;

                    
            if(UtilMethods.isSet(file)){%>
            <%="content_css : \"" + cssPath+"?"+new java.util.Date().getTime() + "\","%>    
            <%}else{%>
            <%="content_css : \"/global/css/base.css?"+new java.util.Date().getTime() + "\","%>
            <%}%>                                                
            trim_span_elements : false,
            apply_source_formatting : true,
            valid_elements : "*[*]",
            relative_urls : true,
            document_base_url : "/",
               <% /*Set the WYSIWYG DATE FORMATS*/
               String dateformat =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_DATEFORMAT");
               if(UtilMethods.isSet(dateformat)){
               %>
               <%="plugin_insertdate_dateFormat : \""+dateformat+"\","%>
               <%
               }else{
               %>
               <%="plugin_insertdate_dateFormat : \"%Y-%m-%d\","%>
               <%
               }
              %>
              <% /*Set the WYSIWYG TIME FORMATS*/
               String timeformats =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_TIMEFORMAT");
               if(UtilMethods.isSet(timeformats)){
               %>
               <%="plugin_insertdate_timeFormat : \""+timeformats+"\","%>
               <%
               }else{
               %>
               <%="plugin_insertdate_timeFormat : \"%H:%M:%S\","%>
               <%
               }
            %>
            <% /*Set the Paste Use Dialog*/
               String pasteusedialog =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_PASTEUSEDIALOG");
               if(UtilMethods.isSet(pasteusedialog)){
               %>
               <%="paste_use_dialog : "+pasteusedialog+","%>
               <%
               }else{
               %>
               <%="paste_use_dialog : true,"%>
               <%
               }
            %>
            <% /*Set the WYSIWYG BLOCK FORMATS*/
              String blockformats =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_BLOCKFORMATS");
              if(UtilMethods.isSet(blockformats)){
              %>
                <%="block_formats : \""+blockformats+"\","%>
              <%
              }else{
              %>
                <%="block_formats : \"Paragraph=p;Header 1=h1;Header 2=h2;Header 3=h3\","%>
              <%
              }
              %>
            gecko_spellcheck : true,
            image_advtab: true,
            file_browser_callback: cmsFileBrowser,
            <% /*Set the WYSIWYG TIME FORMATS*/
               String width =APILocator.getPluginAPI().loadProperty("org.dotcms.tinymce_extended", "WYSIWYG_WIDTH");
               if(UtilMethods.isSet(width)){
               %>
               <%="width : "+width+","%>
               <%
               }else{
               %>
               <%="width : 600"+","%>
               <%
               }
	       %>
		file_picker_callback: function(callback, value, meta) {
			cmsFileBrowser(callback, value, meta);
		}
        };
