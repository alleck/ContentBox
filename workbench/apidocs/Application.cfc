/**********************************************************************************
* Copyright 2005-2007 ColdBox Framework by Luis Majano and Ortus Solutions, Corp
* www.coldboxframework.com | www.luismajano.com | www.ortussolutions.com
********************************************************************************
*/
component{
	this.name = "ContentBox-APIDocs" & hash(getCurrentTemplatePath());
	this.sessionManagement 	= true;
	this.sessionTimeout 	= createTimeSpan(0,0,1,0);
	this.setClientCookies 	= true;

	// API Root
	API_ROOT = getDirectoryFromPath( getCurrentTemplatePath() );
	// Core Mappings
	this.mappings[ "/colddoc" ]  = API_ROOT;
	// Standlone mappings
	this.mappings[ "/coldbox" ]  	= expandPath( "../../coldbox" );
	this.mappings[ "/contentbox" ]  = expandPath( "../../modules/contentbox" );

}