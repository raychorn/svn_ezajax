<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>AJAX onError Handler</title>
</head>

<body>
<cfif 0>
	<cfdump var="error" label="error" expand="No">
<cfelse>
	<cfset cAR = -1>
	<cfset n = -1>
	<cfset errorMsg = "">
	<cfset err_ajaxCode = false>
	<cfset err_ajaxCodeMsg = "">
	
	<cftry>
		<cfset Request.commonCode = CreateObject("component", "cfc.ezAjaxCode")>
		<cfcatch type="Any">
			<cfset Request.commonCode = -1>
			<cfset err_ajaxCode = true>
			<cfoutput><font color="red"><b>(1) The ezAjaxCode component has NOT been created.</b></font></cfoutput>
			<cfdump var="cfcatch" label="Error - The ezAjaxCode.cfc cannot be creted." expand="No">
		</cfcatch>
	</cftry>
	
	<cfset arList = "error.template,error.dateTime,error.mailTo,error.browser,error.remoteAddress,error.HTTPReferer,error.message,error.queryString,error.rootCause,error.diagnostics,error.validationHeader,error.invalidFields,error.validationFooter">
	<cfset errorMsg = errorMsg & "An unexpected error occurred." & Chr(13)>
	<cfset ar = ListToArray(arList, ",")>
	<cfset arN = ArrayLen(ar)>
	
	<cfloop index="i" from="1" to="#arN#">
		<cftry>
			<cfset errorMsg = errorMsg & ar[i] & ": " & Request.commonCode.ezCompressErrorMsgs(Evaluate(ar[i])) & Chr(13)>
			<cfcatch type="Any">
			</cfcatch>
		</cftry>
	</cfloop>
	
	<cfset errorMsg = errorMsg & "Error details:" & Chr(13)>
	<cfset errorMsg = errorMsg & Request.commonCode.ezCompressErrorMsgs(Request.commonCode.ezExplainErrorWithStack(Exception, false))>
	
	<cfset qObj = QueryNew("id, errorMsg")>
	<cfset QueryAddRow(qObj, 1)>
	<cfset QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount)>
	<cfset QuerySetCell(qObj, 'errorMsg', errorMsg, qObj.recordCount)>
	<cfset Request.commonCode.ezRegisterQueryFromAJAX(qObj)>
	
	<cfparam name="_AUTH_USER" type="string" default="">
	
	<cfset bool_using_xmlHttpRequest_viaGET = (isDefined("CGI.QUERY_STRING") AND (FindNoCase("&cfajax=1", URLDecode(CGI.QUERY_STRING)) gt 0))>
	<cfset bool_using_xmlHttpRequest_viaPOST = (isDefined("form.QUERY_STRING") AND (FindNoCase("&cfajax=1", URLDecode(form.QUERY_STRING)) gt 0))>
	<cfset bool_using_xmlHttpRequest = (bool_using_xmlHttpRequest_viaGET) OR (bool_using_xmlHttpRequest_viaPOST)>

	<cfinclude template="ezAJAX_Init.cfm">
	<cfinclude template="ezAJAX_End.cfm">
</cfif>

</body>
</html>
