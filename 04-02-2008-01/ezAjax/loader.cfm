<cfsetting enablecfoutputonly="Yes" showdebugoutput="No">
<cfparam name="Request.importModules" type="string" default="">
<cfparam name="modules" type="string" default="">
<cfparam name="dsr" type="string" default="0">
<cfparam name="callback" type="string" default="try { callBack_DynamicCodeTracker(); } catch (e) { };">
<cfparam name="debugMode" type="string" default="0">
<cfscript>
	if ( (Len(Request.importModules) gt 0) AND (Len(modules) eq 0) ) {
		modules = Request.importModules;
	}
	err_loaderCode = false;
	err_loaderCodeMsg = '';
	try {
		if (dsr eq 0) {
			Request.loaderCode = CreateObject("component", "cfc.je$").init().use(modules);
		} else if (dsr eq 1) {
			Request.loaderCode = CreateObject("component", "cfc.je$")._init().use(modules);
		}
	} catch(Any e) {
		err_loaderCode = true;
		if (debugMode) writeOutput(Request.commonCode.ezCFDump(e, '1.1 CFError in #CGI.SCRIPT_NAME#', false));
	}
	if ( (IsDefined("Request.loaderCode")) AND (debugMode) ) {
		writeOutput(Request.commonCode.ezCFDump(Request.loaderCode, 'Request.loaderCode in #CGI.SCRIPT_NAME#, modules = [#modules#]', false));
	}
</cfscript>
<cfparam name="out" type="string" default="1">
<cfsavecontent variable="callBackCode"><cfif (dsr eq 1)><cfoutput>#callback#</cfoutput></cfif></cfsavecontent>
<cftry>
	<cfif (out eq 1)>
		<cfif (dsr eq 0)>
			<cfoutput>#Request.loaderCode.getCode(debugMode)#</cfoutput>
		<cfelse>
			<cfoutput>#Request.loaderCode._getCode(debugMode)#</cfoutput>
		</cfif>
		<cfoutput>#callBackCode#</cfoutput>
	<cfelse>
		<cfoutput>
			<CFHEADER NAME="Expires" VALUE="Mon, 06 Jan 1990 00:00:01 GMT">
			<CFHEADER NAME="Pragma" VALUE="no-cache">
			<CFHEADER NAME="cache-control" VALUE="no-cache">
			<cfcontent type="text/javascript" variable="#ToBinary(ToBase64(Request.loaderCode.getCode(debugMode) & callBackCode))#">
		</cfoutput>
	</cfif>

	<cfcatch type="Any">
		<cfoutput>
			<cfdump var="#cfcatch#" label="2.1 CFError in #CGI.SCRIPT_NAME#" expand="No">
		</cfoutput>
	</cfcatch>
</cftry>

