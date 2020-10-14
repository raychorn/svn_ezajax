<cfsetting showdebugoutput="No">

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<cfparam name="URL.image" type="string" default="">
<cfset URL.image = URLDecode(URL.image)>

<cfscript>
	_urlPrefix = 'http://#CGI.SERVER_NAME#/' & ListDeleteAt(CGI.SCRIPT_NAME, ListLen(CGI.SCRIPT_NAME, '/'), '/') & '/';
	if (Right(_urlPrefix, 1) eq '/') {
		_urlPrefix = Left(_urlPrefix, Len(_urlPrefix) - 1);
	}
	_urlParentPrefix = 'http://#CGI.SERVER_NAME#/' & ListFirst(CGI.SCRIPT_NAME, '/') & '/';
	if (Right(_urlParentPrefix, 1) eq '/') {
		_urlParentPrefix = Left(_urlParentPrefix, Len(_urlParentPrefix) - 1);
	}
</cfscript>

<cfoutput>
	<html>
	<head>
		<title>ezAJAX(tm) &copy; 1990-#Year(Now())# Hierarchical Applications Limited, All Rights Reserved.</title>
		<script src="#_urlParentPrefix#/AC_RunActiveContent.js" language="JavaScript1.2" type="text/javascript"></script>
	</head>
	
	<body style="background-color: ##027FFF; margin: 0px 0px 0px 0px;">
	
	<cfif (Len(URL.image) eq 0)>
		<script type="text/javascript">
		AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,19,0','width','400','height','200','src','#_urlParentPrefix#/images/ezajax_logo','quality','high','pluginspage','http://www.macromedia.com/go/getflashplayer','movie','#_urlParentPrefix#/images/ezajax_logo' ); //end AC code
		</script><noscript><object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab##version=7,0,19,0" width="400" height="200">
		  <param name="movie" value="#_urlParentPrefix#/images/ezajax_logo.swf" />
		  <param name="quality" value="high" />
		  <embed src="#_urlParentPrefix#/images/ezajax_logo.swf" quality="high" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" width="400" height="200"></embed>
		</object></noscript>
	<cfelse>
		<table width="100%" cellpadding="-1" cellspacing="-1">
			<tr>
				<td>
					<img src="#URL.image#" border="0">
				</td>
				<td>
					<b>YES !  ezAJAX&##8482 is the right product for YOU !</b>
				</td>
			</tr>
		</table>
	</cfif>

</cfoutput>

</body>
</html>
