<cfcomponent displayname="userDefinedAJAXFunctions" hint="(c). Copyright 1990-2006 Hierarchical Applications Limited, All Rights Reserved. The functions and data contained herein may only be used within the context of the ezAJAX&##8482 Framework Product, any other use is strictly forbidden." output="No" extends="geonosisSupport">

	<cfscript>
		cf_trademarkSymbol = '&##8482';
	</cfscript>

	<cfparam name="Request.cfcPrefix" type="string" default="*** Unknown ***">

	<cftry>
		<cfinclude template="../../app/cfinclude_userDefinedAJAXFunctions.cfm">

		<cfcatch type="Any">
		</cfcatch>
	</cftry>
	
	<cffunction name="serverCommandCFCTemplate" output="No" access="private" returntype="string">
		<cfargument name="_cfcName" type="string" required="yes">
		<cfargument name="_namedArgs" type="struct" required="yes">
		
		<cfset var i = -1>
		<cfset var bool_IsNamedArgsValid = (NOT StructIsEmpty(_namedArgs))>
		<cfset var arNamedArgKeys = StructKeyArray(_namedArgs)>
		<cfset var n = ArrayLen(arNamedArgKeys)>
		<cfset var _content = "">
		<cfif (Len(_cfcName) gt 0)>
			<cfscript>
				_content = _content & '<cfcomponent displayname="#_cfcName#" output="No" extends="userDefinedAJAXFunctions">' & Chr(13);
				_content = _content & RepeatString(Chr(9), 1) & '<cfscript>' & Chr(13);
				_content = _content & RepeatString(Chr(9), 2) & 'function _userDefinedAJAXFunctions(qryStruct) {' & Chr(13);
				_content = _content & RepeatString(Chr(9), 3) & "var errMsg = '';" & Chr(13);
				_content = _content & RepeatString(Chr(9), 3) & "var scopesContent = '';" & Chr(13);
				_content = _content & RepeatString(Chr(9), 3) & 'try {' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & 'switch (qryStruct.ezCFM) {' & Chr(13);
				_content = _content & RepeatString(Chr(9), 5) & "case '#_cfcName#':" & Chr(13);

				if (bool_IsNamedArgsValid) {
					_content = _content & RepeatString(Chr(9), 6) & 'if (';
					for (i = 1; i lte n; i = i + 1) {
						_content = _content & ' (IsDefined("qryStruct.namedArgs.#arNamedArgKeys[i]#")) AND (Len(qryStruct.namedArgs.#arNamedArgKeys[i]#) gt 0)';
						if (i neq n) {
							_content = _content & ' AND';
						}
					}
					_content = _content & ' ) {' & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "qObj = QueryNew('ID'); // You may add Query Elements to this Query as needed..." & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "QueryAddRow(qObj, 1);" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "QuerySetCell(qObj, 'ID', qObj.recordCount, qObj.recordCount);" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects..." & Chr(13);
					_content = _content & RepeatString(Chr(9), 6) & "} else {" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "qObj = QueryNew('id, errorMsg');" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "QueryAddRow(qObj, 1);" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "errorDetails = '';" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "errorReasons = '';" & Chr(13);
					for (i = 1; i lte n; i = i + 1) {
						_content = _content & RepeatString(Chr(9), 7) & 'if (';
						_content = _content & 'NOT IsDefined("qryStruct.namedArgs.#arNamedArgKeys[i]#")';
						_content = _content & ') {' & Chr(13);
						_content = _content & RepeatString(Chr(9), 8) & "errorDetails = errorDetails & '#arNamedArgKeys[i]#';" & Chr(13);
						_content = _content & RepeatString(Chr(9), 7) & "}" & Chr(13);
					}
					_content = _content & RepeatString(Chr(9), 7) & "extraErrorMsg = '';" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "if ( (isDebugMode()) OR (isServerLocal()) ) {" & Chr(13);
					_content = _content & RepeatString(Chr(9), 8) & "extraErrorMsg = ' for ##qryStruct.ezCFM## in ##CGI.SCRIPT_NAME##';" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "}" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "QuerySetCell(qObj, 'errorMsg', 'Missing or Invalid ezAJAX(tm) parm(s) (##errorDetails## / ##errorReasons##)##extraErrorMsg##.', qObj.recordCount);" & Chr(13);
					_content = _content & RepeatString(Chr(9), 7) & "ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects..." & Chr(13);
					_content = _content & RepeatString(Chr(9), 6) & "}" & Chr(13);
				}
					
				_content = _content & RepeatString(Chr(9), 5) & 'break;' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & '}' & Chr(13);
				_content = _content & RepeatString(Chr(9), 3) & '} catch (Any e) {' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & 'errMsg = ezExplainError(e, false);' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & 'QueryAddRow(qObj, 1);' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "if (CGI.REMOTE_HOST is '127.0.0.1') {" & Chr(13);
				_content = _content & RepeatString(Chr(9), 5) & "scopesContent = scopesContent & '<br><table width=#Chr(Asc('"'))#100%#Chr(Asc('"'))#><tr><td>' & ezExplainError(e, true) & '</td></tr></table>';" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & '}' & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'errorMsg', '<font color=#Chr(Asc('"'))#red#Chr(Asc('"'))#><b>Something just went wrong in #Chr(Asc('"'))##Chr(Asc('##'))#CGI.SCRIPT_NAME#Chr(Asc('##'))##Chr(Asc('"'))#... :: Reason: #Chr(Asc('"'))##Chr(Asc('##'))#errMsg#Chr(Asc('##'))##Chr(Asc('"'))#.</b></font>' & scopesContent, qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'explainError', '', qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & "QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);" & Chr(13);
				_content = _content & RepeatString(Chr(9), 4) & 'ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects...' & Chr(13);
				_content = _content & RepeatString(Chr(9), 3) & '}' & Chr(13);
				_content = _content & RepeatString(Chr(9), 2) & '}' & Chr(13);
				_content = _content & RepeatString(Chr(9), 1) & '<' & '/' & 'cfscript>' & Chr(13);
				_content = _content & '<' & '/' & 'cfcomponent>' & Chr(13);
			</cfscript>
		</cfif>
		
		<cfreturn _content>
	</cffunction>
	
	<cfscript>
		function userDefinedAJAXFunctions(qryStruct) {
			var errMsg = '';
			var ar = -1;
			var n = -1;
			var _ar = -1;
			var _n = -1;
			var i = -1;
			var cfcContent = '';
			var cfcName = '';
			var _namedArgs = StructNew();
			var errStruct = StructNew();
			
			if ( (IsDefined("qryStruct.ezSessid")) AND (IsDefined("Request.primitiveCode")) ) {
				Request.primitiveCode.readSessionFromDb(qryStruct.ezSessid);
			}

			bool_isServerCommandCFCError = false;
			try {
				ezWebRootPrefix = Request.qryStruct['ezWebRootPrefix'];
			} catch (Any e) {
				bool_isServerCommandCFCError = true;
			}
			
			if (NOT bool_isServerCommandCFCError) {
				try {
					cfcObj = CreateObject("component", qryStruct.ezCFM);
	//				writeOutput('Request.commonCode.productName = [#Request.commonCode.productName#], Request.qryStruct.ezTime = [#Request.qryStruct.ezTime#], ParseDateTime(Request.qryStruct.ezTime) = [#ParseDateTime(Request.qryStruct.ezTime)#], Request.qryStruct.aRuntimeLicenseStruct_RUNTIMELICENSEEXPIRATIONDATE = [#Request.qryStruct.aRuntimeLicenseStruct_RUNTIMELICENSEEXPIRATIONDATE#]<br>');
					if ( (IsDefined("Request.commonCode.productName")) AND (IsDefined("Request.qryStruct.aRuntimeLicenseStruct_RUNTIMELICENSEEXPIRATIONDATE")) AND (IsDefined("Request.qryStruct.ezTime")) AND (DateCompare(ParseDateTime(Request.qryStruct.ezTime), Request.qryStruct.aRuntimeLicenseStruct_RUNTIMELICENSEEXPIRATIONDATE) lte 0) ) {
						cfcObj.init(Request.commonCode.productName, Request.qryStruct.aRuntimeLicenseStruct_RUNTIMELICENSEEXPIRATIONDATE);
					} else {
	//					writeOutput('(IsDefined("Request.qryStruct.aRuntimeLicenseStruct")) = [#(IsDefined("Request.qryStruct.aRuntimeLicenseStruct"))#] OR (IsDefined("Request.qryStruct.aRuntimeLicenseStruct.PRODUCTNAME")) = [#(IsDefined("Request.qryStruct.aRuntimeLicenseStruct.PRODUCTNAME"))#] OR (IsDefined("Request.qryStruct.aRuntimeLicenseStruct.RUNTIMELICENSEEXPIRATIONDATE")) = [#(IsDefined("Request.qryStruct.aRuntimeLicenseStruct.RUNTIMELICENSEEXPIRATIONDATE"))#]<br>');
					}
					cfcObj._userDefinedAJAXFunctions(qryStruct);
					bool_isServerCommandCFCError = true;
				} catch (Any e) {
					errMsg = ezExplainError(e, false);
					ar = ListToArray(errMsg, ',');
					n = ArrayLen(ar);
					for (i = 1; i lte n; i = i + 1) {
						_ar = ListToArray(ar[i], '=');
						_n = ArrayLen(_ar);
						if (_n eq 2) {
							errStruct[_ar[1]] = _ar[2];
						}
					}
					if ( (FindNoCase('Could not find the ColdFusion Component ', errStruct['Message']) gt 0) AND (Len(errStruct['missingFileName']) gt 0) ) {
						try {
							_namedArgs = qryStruct.namedArgs;
						} catch (Any e) { };
						cfcContent = serverCommandCFCTemplate(errStruct['missingFileName'], _namedArgs);
						cfcName = ExpandPath('cfc/' & errStruct['missingFileName'] & '.cfc');
						ezCfFileWrite(cfcName, cfcContent);
						if (Request.fileError) {
							qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
							QueryAddRow(qObj, 1);
							QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
							QuerySetCell(qObj, 'errorMsg', '<font color="red"><b>Attempted to make a CFC (#errStruct['missingFileName']#) for an unknown Server Command but something went horribly wrong... :: Reason: "#Request.errorMsg#"</b></font>', qObj.recordCount);
							QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
							QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
							QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
							QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
							ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects...
						} else {
							qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
							QueryAddRow(qObj, 1);
							QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
							QuerySetCell(qObj, 'errorMsg', '<font color="blue"><b>Successfully made a CFC (#errStruct['missingFileName']#.cfc) for an unknown Server Command... :: Feel free to edit the contents of the file named "#cfcName#".</b></font>', qObj.recordCount);
							QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
							QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
							QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
							QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
							ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects...
						}
					} else {
						qObj = QueryNew('id, errorMsg, moreErrorMsg, explainError, isPKviolation, isHTML');
						QueryAddRow(qObj, 1);
						QuerySetCell(qObj, 'id', qObj.recordCount, qObj.recordCount);
						QuerySetCell(qObj, 'errorMsg', '<font color="red"><b>Something dreadful just happened... :: Reason: "#errMsg#" [#Request.cfcPrefix#]</b></font>', qObj.recordCount);
						QuerySetCell(qObj, 'moreErrorMsg', '', qObj.recordCount);
						QuerySetCell(qObj, 'explainError', '', qObj.recordCount);
						QuerySetCell(qObj, 'isPKviolation', '', qObj.recordCount);
						QuerySetCell(qObj, 'isHTML', 1, qObj.recordCount);
						ezRegisterQueryFromAJAX(qObj); // this function is used to tell the ezAJAX(tm) system what Query(s) you wish to communicate back to JavaScript - you can register as many Query Objects as you wish... the CF Var named Request.qryData is used to hold an array of Query Objects...
					}
				}
			}
		}
	</cfscript>
</cfcomponent>
