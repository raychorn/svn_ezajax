<cfsetting requesttimeout="120">

<cfparam name="debugJavaScriptPackager" type="boolean" default="false">

<cfparam name="Request.importModules" type="string" default="">

<cfoutput>
	<cfif (IsDefined("Request.DOCTYPE")) AND (Len(Request.DOCTYPE) gt 0)>
		#Request.DOCTYPE#
	<cfelse>
		<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
	</cfif>
	
	<html>
	<head>
		<title>#ezAJAX_title##_copyrightNotice#</title>
		<link rel="STYLESHEET" type="text/css" href="#ezAJAX_webRoot#/StyleSheet<cfif (Request.commonCOde.ezIsBrowserFF()) OR (Request.commonCOde.ezIsBrowserNS())>FF</cfif>.css"> 
		<link rel="STYLESHEET" type="text/css" href="#ezAJAX_webRoot#/commonStyles.css"> 
		#htmlHeader#
		
		<cfset Request.debugCompiler = "">
		<cfif (FileExists(ExpandPath("ezCompiler.cfm")))>
			<cfinclude template="ezCompiler.cfm">
		</cfif>

		<cfset _JavaScriptSignature = URLEncodedFormat(Trim(_asBlowfishEncryptedHex(DateFormat(Now(), "mm/dd/yyyy") & "_" & TimeFormat(Now(), "hh:mm:ss tt"))))>
		<script language="JavaScript1.2" type="text/javascript" src="#ezAJAX_webRoot#/#cfJavaScriptSourceCodeFName1#"></script>
		<cfif 0>
			<script language="JavaScript1.2" type="text/javascript" src="#ezAJAX_webRoot#/#cfJavaScriptSourceCodeFName2#"></script>
		<cfelseif 1> <!--- +++ --->
			<script language="JavaScript1.2" type="text/javascript" src="#ezAJAX_webRoot#/ezAjax/loader.cfm?out=0&modules=#URLEncodedFormat(Request.importModules)#&sig=#Trim(_JavaScriptSignature)#"></script>
		<cfelseif 0>
			<script language="JavaScript1.2" type="text/javascript"><cfinclude template="ezAjax/loader.cfm"></script>
		</cfif>
		<cfset cfinclude_GeonosisConstants = "ezAjax/cfc/cfinclude_GeonosisConstants.cfm">
		<cfif (FileExists(ExpandPath(cfinclude_GeonosisConstants)))>
			<cfinclude template="#cfinclude_GeonosisConstants#">
		</cfif>
		
		<cfscript>
			Request.commonCode.registerCFtoJS_variable('cf_const_Objects_symbol', cf_const_Objects_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_getCLASSES_symbol', cf_const_getCLASSES_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_chgAttrsForObject_symbol', cf_const_chgAttrsForObject_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_chgDataForObject_symbol', cf_const_chgDataForObject_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_getOBJECTS_symbol', cf_const_getOBJECTS_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_addClassDef_symbol', cf_const_addClassDef_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_dropClassDef_symbol', cf_const_dropClassDef_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_addObject_symbol', cf_const_addObject_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_dropObject_symbol', cf_const_dropObject_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_addAttribute_symbol', cf_const_addAttribute_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_dropAttribute_symbol', cf_const_dropAttribute_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_getAttributesForOBJECT_symbol', cf_const_getAttributesForOBJECT_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_getLinkedObjects_symbol', cf_const_getLinkedObjects_symbol);
			Request.commonCode.registerCFtoJS_variable('cf_const_checkLinkedObjects_symbol', cf_const_checkLinkedObjects_symbol);
			Request.commonCode.emitCFtoJS_variables(false);
		</cfscript>

		<cfif 0>
			<script language="JavaScript1.2" type="text/javascript">
				window.onscriptload = function() {
					alert('window.onscriptload !');
				}
			</script>
		</cfif>
	</head>

	<body>
		<cfif (IsDefined("Request.debugCompiler")) AND (Len(Request.debugCompiler) gt 0) AND (Request.commonCode.ezIsBrowserIE())><textarea readonly rows="50" cols="100" class="textClass" style="position: absolute; top: 0px; left: 0px;">#Request.debugCompiler#</textarea></cfif>
<cfif (NOT debugJavaScriptPackager)>
		<cfscript>
			cf_REMOTE_ADDR = CGI.REMOTE_ADDR;
			cf_SERVER_NAME = 'http:' & '/' & '/' & CGI.SERVER_NAME & '/' & CGI.SCRIPT_NAME;
			
			_urlCommunityEditionLicenseAgreement = Request.commonCode.ezClusterizeURL("#ezAJAX_webRoot#/ezAJAX(tm) Community Edition License Agreement.htm");
			_urlCommunityEditionProgrammersGuide = Request.commonCode.ezClusterizeURL("#ezAJAX_webRoot#/ezAJAX_tm_ Community Edition Programmers Guide v0.93.pdf");
	
			cf_isColdFusionMX7 = application.isColdFusionMX7;

			cf_Session_ID = CreateUUID();
		</cfscript>
		<cfsavecontent variable="jsCodeStoreB">
			<cfoutput>
			//var _javaScriptLoaderParms = '?out=0&modules=#URLEncodedFormat(Request.importModules)#&sig=#Trim(_JavaScriptSignature)#';

			//var myPathname = ((window.location.pathname == '') ? '/' : window.location.pathname);
			//var myURL = window.location.protocol + '//' + ((window.location.hostname == null) ? window.location.host : window.location.hostname) + myPathname + (((myPathname.charAt(myPathname.length - 1)) == '/') ? '' : '/') + 'ezAjax/loader.cfm' + _javaScriptLoaderParms;
			//alert('myURL = [' + myURL + ']');
			//ezJSON.get$(myURL);

			var js_AUTH_USER = '#Request.AUTH_USER#';
			var js_ezAJAX_webRoot = '#ezAJAX_webRoot#';
			var js_ezAJAX_webRoot_prefix = '#Request._prefix#';
			var cf_Session_ID = '#cf_Session_ID#';
			var js_isDebugMode = (('#Request.ezAJAX_isDebugMode#'.toUpperCase() == 'YES') ? true : false);
			var js_trademarkSymbol = '#cf_trademarkSymbol#';
			var cf_cgiReferer = '';
			<cfif (IsDefined("CGI.SERVER_NAME"))>cf_cgiReferer = '#CGI.SERVER_NAME#';</cfif>
			var const_div_floating_debug_menu = '#Request.cf_div_floating_debug_menu#';
			var const_div_floating_debug_menu_content = 'div_debugOuterContainer';
			var browser_is_op = false;
			var browser_is_ns = false;
			var browser_is_ff = false;
			var browser_is_ie = false;
			var js_REMOTE_ADDR = '#cf_REMOTE_ADDR#';
			var js_SERVER_NAME = '#cf_SERVER_NAME#';
			var jsBool_isColdFusionMX7 = (('#cf_isColdFusionMX7#'.toUpperCase() == 'YES') ? true : false);
			var jsBool_isDebugMode = (('#Request.ezAJAX_isDebugMode#'.toUpperCase() == 'YES') ? true : false);
			var jsBool_isServerLocal = (('#Request.commonCode.isServerLocal()#'.toUpperCase() == 'YES') ? true : false);
			var bool_isServerProduction = (('#bool_isServerProduction#' == 'true') ? true : false);
			
			var oAJAXEngine = -1;
			</cfoutput>
		</cfsavecontent>
		<script language="JavaScript1.2" type="text/javascript">#Request.commonCode._readAndObfuscateJSCode_(jsCodeStoreB)#</script>

		<cfset bool_useGeonosis = false>
		<cfif (bool_useGeonosis)>
			<script language="JavaScript1.2" src="_js/20_GeonosisGUI.js" type="text/javascript"></script>
		</cfif>
		
		<noscript>You must enable JavaScript to use this site.<br>Please enable JavaScript for your browser or use a browser that support JavaScript.<br>
		<a href="http://www.ez-ajax.com">ezAJAX&##8482 - AJAX made Easy - Easily Develop your next AJAX Application using this amazing Product !</a>
		</noscript>
		
		<cfif (NOT bool_isServerProduction)>
			<div id="#Request.cf_div_floating_debug_menu#" style="display: inline; height: 25px; background-color: ##80FFFF; border: thin solid Black; z-index: 65535;">
				<cfif 0>
					<button id="btn_fetchDebugMenu" class="buttonMenuClass<cfif (Request.commonCode.ezIsBrowserFF() OR Request.commonCode.ezIsBrowserNS())>FF</cfif>" onClick="this.disabled = true; function handle_DynamicCodeInitiator_fetchDebugMenu() { if (cache_processDynamicCodeTracker[handle_DynamicCodeInitiator_fetchDebugMenu] != null) { clearInterval(cache_processDynamicCodeTracker[handle_DynamicCodeInitiator_fetchDebugMenu]); cache_processDynamicCodeTracker[handle_DynamicCodeInitiator_fetchDebugMenu] = null; stack_processDynamicCodeTracker.pop(); }; try { oAJAXEngine.doAJAX('ezAJAX_PopulateDebugPanel', 'handle_ezAJAXPopulateDebugPanel'); } catch (e) { ezAlertError(ezErrorExplainer(e)); }; }; function boolIsModuleLoaded_ezDebugPanel() { return true; }; if (global_previouslyLoadedObjects.indexOf('modules=ezDebugPanel') != -1) { try { alert(999.1); oAJAXEngine.doAJAX('ezAJAX_PopulateDebugPanel', 'handle_ezAJAXPopulateDebugPanel'); } catch (e) { ezAlertError(ezErrorExplainer(e)); }; } else { ezDynamicObjectLoader('#ezAJAX_webRoot#/ezAjax/loader.cfm?out=1&dsr=1&modules=ezDebugPanel'); processDynamicCodeTracker(handle_DynamicCodeInitiator_fetchDebugMenu, boolIsModuleLoaded_ezDebugPanel); } return false;" title="Click this button to begin using the Debug menu.">[Open ezAJAX Debug Menu]</button>
					<cfelse>
						<cfscript>
							if (IsObject(Request.cfc_ezAJAX_PopulateDebugPanel)) {
								Request.cfc_ezAJAX_PopulateDebugPanel.init(Request.commonCode.productName, CreateDateTime(1990, 1, 1, 0, 0, 0));
								writeOutput(URLDecode(Request.cfc_ezAJAX_PopulateDebugPanel.contentDebugPanel(ezAJAX_webRoot)));
							} else {
								writeOutput('CFC Error in (Request.cfc_ezAJAX_PopulateDebugPanel).');
							}
						</cfscript>
				</cfif>
			</div>
		</cfif>

		<cfloop index="_item" list="#Request.cfincludeCFM#" delimiters=",">
			<cfif (FileExists(ExpandPath(_item)))>
				<cfinclude template="#_item#">
			</cfif>
		</cfloop>
		
		<div id="ShoppingCartContainer"></div>
		<div id="ThoughtBubbleContainer"></div>

		<cfsavecontent variable="finaleJavaScriptCode">
			<cfoutput>
				ezAJAXEngine.RuntimeLicenseStatus = '#Request.RuntimeLicenseStatus#'; try { if (ezAJAXEngine.RuntimeLicenseStatus.length > 0) { ezAlertHTMLError(ezAJAXEngine.RuntimeLicenseStatus); ezAJAXEngine.RuntimeLicenseStatus = ''; } } catch(e) { ezAlertError('System Error: Cannot determine Runtime License Status.'); };
			</cfoutput>
		</cfsavecontent>		

		<script language="JavaScript1.2" type="text/javascript">#Request.commonCode._readAndObfuscateJSCode_(finaleJavaScriptCode)#</script>
		<cfif 0>
			#RepeatString('<br>', 35)#
			<cfdump var="#Request.cfc_ezAJAX_PopulateDebugPanel#" label="1.1 Request.cfc_ezAJAX_PopulateDebugPanel" expand="no">
		</cfif>
</cfif>
	</body>

	</html>
</cfoutput>
