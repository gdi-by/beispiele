<?xml version="1.0" encoding="UTF-8"?>
<!--    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Capabilities Viewer GDI-BY (XSLT WFS 1.0.0 -> HTML)
    
    Stand: 07.09.2015
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
 
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~    
-->
<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xlink="http://www.w3.org/1999/xlink"
                xmlns:wms="http://www.opengis.net/wms"
                xmlns:sld="http://www.opengis.net/sld"
                xmlns:fes="http://www.opengis.net/fes/2.0"
                xmlns:gmd="http://www.isotc211.org/2005/gmd"
                xmlns:wfs="http://www.opengis.net/wfs" 
                xmlns:ogc="http://www.opengis.net/ogc"
                xmlns:ows="http://www.opengis.net/ows"
                xmlns:inspire_vs="http://inspire.ec.europa.eu/schemas/inspire_vs/1.0"
                xmlns:inspire_dls="http://inspire.ec.europa.eu/schemas/inspire_dls/1.0"
                xmlns:inspire_common="http://inspire.ec.europa.eu/schemas/common/1.0"
                xmlns:java="de.bayern.lvg.capabilitiesviewer.servlet.CapabilitiesHelper"
                exclude-result-prefixes="java">

    <!-- ### Parameter ### -->
    <xsl:param name="optIP" />
    <xsl:param name="optLayer" />
    <xsl:param name="optHeader" />
    <xsl:param name="optLegend" />
    <!-- <xsl:param name="optLegend">true</xsl:param> -->

    <!-- ### Variablen ### -->
    <xsl:variable name="build">
        <xsl:value-of select="java:getBuild()"/>
        <!-- !Manuelle Transformation! -->
    </xsl:variable>
    <xsl:variable name="urlprefix">
        <xsl:value-of select="java:getUrlprefix($optIP)"/>
        <!-- http://wwww.geoportal.bayern.de -->
    </xsl:variable>


    <xsl:template match="/">
        
        <!-- ### Variablen ### -->
        
        <!-- Feature Online Resource -->
        <xsl:variable name="orGetC_org">
            <xsl:value-of select="wfs:WFS_Capabilities/wfs:Capability/wfs:Request/wfs:GetCapabilities/wfs:DCPType/wfs:HTTP/wfs:Get/@onlineResource"/>
        </xsl:variable>
        <xsl:variable name="orGetC">
            <xsl:value-of select="java:getCorrectedOnlineResource($orGetC_org)"/>
            <!-- <xsl:value-of select="$orGetC_org"/> -->
        </xsl:variable>       
        
        
        <!-- ############### -->
        <!-- # Anfang HTML # -->
        <!-- ############### -->        
                        
        <html>
            <head>
                <title>Capabilities - Viewer (Build 
                    <xsl:copy-of select="$build"/>) - 
                    <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceIdentification/ows:Title"/>
                </title>
                <meta>
                    <xsl:attribute name="name">description</xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceIdentification/ows:Abstract"/>
                    </xsl:attribute>
                </meta>
                <link rel="stylesheet" type="text/css" href="style.css" />
                <link rel="stylesheet" type="text/css" href="getcapabilities.css" />
            </head>
            <body>
                <center>
                    <!--   Header ausblenden? -->
                    <xsl:if test="not($optHeader='skip')">
                        <img src="gdi_header.jpg" />
                        <br />
                        <!--<img src="cv.png" />-->
                        <div style="margin-left: 20px; margin-top: 25px; margin-bottom: 20px;">
                            <span style="font-family: sans-serif;color: #1e5e9b; font-size: 3.4em; font-weight: bold; text-shadow: 2px 4px 2px rgba(0, 0, 0, 0.5);">Capabilities - Viewer</span> 
                        </div>

                        <xsl:if test="$optLegend='true'">
                            <table style="border:0px;">
                                <tr>
                                    <td style="border:0px; float: right;" align="right">
                                        <b>
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:copy-of select="$urlprefix"/>/getcapabilities/CapabilitiesViewer?ows_url=<xsl:value-of select="$orGetC"/>&amp;service=wfs&amp;version=1.0.0&amp;format=html
                                                </xsl:attribute>URL zu dieser Seite
                                            </a>
                                        </b>
                                    </td>
                                </tr>
                            </table>
                        </xsl:if>
                    </xsl:if>
	
				
                    <!--WFS ab hier-->
                    <table>
                        <caption>
                            Angaben zum Dienst (WFS 1.0.0)
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">Angaben zum Dienst</th>
                                <th scope="col">Beschreibung</th>
                            </tr>
                        </thead>
                        <tbody>
                        
						
                            <!-- 2.1.1 -->
                            <tr>
                                <td>
                                    Titel des Dienstes
                                </td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:Title"/>
                                </td>
                            </tr>	

                            <!-- 2.1.2 -->
                            <tr>
                                <td>
                                    Beschreibung des Dienstes
                                </td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:Abstract"/>
                                </td>
                            </tr>	

                            <!-- 2.1.3 Schlüsselwörter -->
                            <tr>
                                <td> Liste von Schlüsselwörtern,
                                    <br />die den Dienst beschreiben
                                </td>
                                <td>                          
                                   <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:Keywords"/> 
                               </td>
                            </tr>						
						
                            <!-- 2.1.x -->
                            <tr>
                                <td>
                                    URL zum Aufruf des Dienstanbieters
                                </td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:OnlineResource"/>
                                </td>
                            </tr>

                            <!-- 2.1.6 -->
                            <tr>
                                <td>
                                    Gebühren
                                </td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:Fees"/>
                                </td>
                            </tr>

                            <!-- 2.1.7 -->
                            <tr>
                                <td>
                                    Nutzungsbeschränkungen
                                </td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Service/wfs:AccessConstraints"/>
                                </td>
                            </tr>                      

                            <!-- 2.2 -->
                            <!-- <tr>
                                <td>Kontaktinformationen<br />zum Dienstanbieter</td>
                                <td>
                                    <p><b>Ansprechpartner</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:IndividualName"/></p>
                                    <p><b>Position</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:PositionName"/></p>
                                    <p><b>Dienstanbieter</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ProviderName"/></p>
                                    <p><b>Website des Dienstanbieters</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ProviderSite/@xlink:href"/></p>
                                    <p>Straße: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:DeliveryPoint"/></p>
                                    <p><b>Stadt</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:City"/></p>
                                    <p><b>Bundesland</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:AdministrativeArea"/></p>
                                    <p><b>Postleitzahl</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:PostalCode"/></p>
                                    <p><b>Land</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:Country"/></p>
                                    <p><b>Telefonnummer</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Voice"/></p>
                                    <p>Fax-Nummer: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Facsimile"/></p>
                                    <p><b>E-Mail</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:ElectronicMailAddress"/></p>
                                    <p><b>URL des Kontakts</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:OnlineResource/@xlink:href"/></p>
                                    <p><b>Erreichbarkeit</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:HoursOfService"/></p>
                                    <p><b>Hinweise</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:ContactInstructions"/></p>
                                    <p><b>Rolle</b>: <xsl:value-of select="wfs:WFS_Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:Role"/></p>
                                </td>
                            </tr>-->
                        </tbody>
                    </table>
                    <br />
                    <br />

                    <!-- 2.5 -->
                    <table>
                        <caption>
                            Im Dienst verfügbare FeatureTypes
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">FeatureType (Title)</th>
                                <th scope="col">FeatureType (Name)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="wfs:WFS_Capabilities/wfs:FeatureTypeList/wfs:FeatureType">
                                <tr>
                                    <td>
                                        <xsl:value-of select="./wfs:Title"/>
                                    </td>
                                    <td>
                                        <xsl:value-of select="./wfs:Name"/>
                                    </td>
                                </tr>
                            </xsl:for-each>	
                        </tbody>
                    </table>
                    <br />
                    <br />

                    <xsl:for-each select="wfs:WFS_Capabilities/wfs:FeatureTypeList/wfs:FeatureType">
                        <table>
                            <caption>
                                Details zum FeatureType: 
                                <i>
                                    <xsl:value-of select="wfs:Title" />
                                </i>
                            </caption>
                            <thead>
                                <tr>
                                    <th scope="col" width="30%">Angaben zum FeatureType</th>
                                    <th scope="col">Beschreibung</th>
                                </tr>
                            </thead>
                            <tbody>

                                <tr>
                                    <td>
                                        Name des FeatureTypes
                                    </td>
                                    <td>
                                        <xsl:value-of select="wfs:Name" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        Titel des FeatureTypes
                                    </td>
                                    <td>
                                        <xsl:value-of select="wfs:Title" />
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        Beschreibung des FeatureTypes
                                    </td>
                                    <td>
                                        <xsl:value-of select="wfs:Abstract" />
                                    </td>
                                </tr>

                                <tr>
                                    <td> Liste von Schlüsselwörtern,
                                        <br />die den FeatureType beschreiben
                                    </td>
                                    <td>
                                                                               
                                        <xsl:value-of select="wfs:Keywords"/>
                                            
                                    </td>
                                </tr>

                                <tr>
                                    <td>
                                        Koordinatenreferenzsysteme (EPSG - Code)
                                    </td>
                                    <td>
                                        <ul>
                                            <xsl:for-each select="wfs:SRS">
                                                <li>
                                                    <xsl:value-of select="."/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        Räumliche Verfügbarkeit
                                            <br/>des FeatureTypes
                                    </td>
                                    <td>
                                        Geographische Begrenzung:
                                        <br />
                                        West: 
                                        <xsl:value-of select="wfs:LatLongBoundingBox/@minx"/>
                                        <br />
                                        Ost:  
                                        <xsl:value-of select="wfs:LatLongBoundingBox/@maxx"/>
                                        <br />
                                        Süd:  
                                        <xsl:value-of select="wfs:LatLongBoundingBox/@miny"/>
                                        <br />
                                        Nord: 
                                        <xsl:value-of select="wfs:LatLongBoundingBox/@maxy"/>
                                        <br />
                                    </td>
                                </tr>


                            </tbody>
                        </table>
                    </xsl:for-each>
                
               <!-- <table>
                    <caption>
                        Unterstützte Operationen
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">Operation</th>
                            <th scope="col">URL für die Anfrage</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="wfs:WFS_Capabilities/wfs:Request">
                                <tr>
                                    <td><xsl:value-of select="./@name"/></td>
                                    <td>
                                        <xsl:variable name="orGetURL_org">
                                            <xsl:value-of select="ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
                                        </xsl:variable>
                                        <xsl:variable name="orGetURL">
                                            <xsl:value-of select="java:getCorrectedOnlineResource($orGetURL_org)"/>
                                        </xsl:variable>
                                        <xsl:value-of select="$orGetURL_org"/>
                                    </td>
                                </tr>
                        </xsl:for-each>	
                    </tbody>
                </table><br /><br />	-->


                    <!-- 2.3.1 -->
                    <table>
                        <caption>
                            Eigenschaften der Operation GetCapabilities
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">Eigenschaft</th>
                                <th scope="col">Beschreibung</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    URL für die Anfrage
                                </td>
                                <td>
                                    <xsl:value-of select="$orGetC"/>
                                </td>
                            </tr>
                        <!--<tr>
                            <td><b>Unterstütze Versionen</b></td>
                            <td>
				<xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:Parameter[@name='AcceptVersions']/ows:Value">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>  
                        <tr>
                            <td><b>Unterstützte Formate</b></td>
                            <td>
				<xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:Parameter[@name='AcceptFormats']/ows:Value">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>	
                        <tr>
                            <td>Enthaltene Abschnitte</td>
                            <td>
				<xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:Parameter[@name='Sections']/ows:Value">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>	-->					
                        </tbody>
                    </table>
                    <br />
                    <br />


                <!-- 2.3.2 -->
                    <table>
                        <caption>
                            Eigenschaften der Operation DescribeFeatureType
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">Eigenschaft</th>
                                <th scope="col">Beschreibung</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>URL für die Anfrage</td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Capability/wfs:Request/wfs:DescribeFeatureType/wfs:DCPType/wfs:HTTP/wfs:Get/@onlineResource"/>
                                </td>
                            </tr>
                       <!-- <tr>
                            <td><b>Ausgabeformate</b></td>
                            <td>
				<xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:Operation[@name='DescribeFeatureType']/ows:Parameter[@name='outputFormat']/ows:Value">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>-->
                        </tbody>
                    </table>
                    <br />
                    <br />

                <!-- 2.3.3 -->
                    <table>
                        <caption>
                            Eigenschaften der Operation GetFeature
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">Eigenschaft</th>
                                <th scope="col">Beschreibung</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>URL für die Anfrage</td>
                                <td>
                                    <xsl:value-of select="wfs:WFS_Capabilities/wfs:Capability/wfs:Request/wfs:GetFeature/wfs:DCPType/wfs:HTTP/wfs:Get/@onlineResource"/>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    Ausgabeformate
                                </td>
                                <td>
                                    <xsl:for-each select="wfs:WFS_Capabilities/wfs:Capability/wfs:Request/wfs:GetFeature/wfs:ResultFormat/*">
                                        <xsl:value-of select="name()"/><br/>
                                    </xsl:for-each>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                    <br />
                    <br />

                <!-- 2.3.4 -->
          <!--      <table>
                    <caption>
                        Eigenschaften der Operation GetPropertyValue
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaft</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>
			<tr>
                            <td>URL für die Anfrage</td>
                            <td>
                                <xsl:value-of select="$orGetM"/>
                            </td>
                        </tr>
                    </tbody>
                </table><br /><br />-->
                
                
<!-- INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE -->

               <!--<table>
                    <caption>
                        Erweiterte Capabilities für INSPIRE-Downloaddienst<br />
                        (nach Technical Guidance Documents Version 3.0)
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">Eigenschaften<br />INSPIRE</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>


                        <tr>
                            <td>Metadaten des Dienstes</td>
                            <td>
                                <a>
                                    <xsl:attribute name="href">
                                        <xsl:value-of select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:URL"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="target">
                                        _blank
                                    </xsl:attribute>
                                    <xsl:value-of select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:URL"/>
                                </a>
                                
                            </td>
                        </tr>

                        <tr>
                            <td>Metadaten des Dienstes (MediaType)</td>
                            <td>
                                <xsl:value-of select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:MediaType"/>
                            </td>
                        </tr>

                        <tr>
                            <td>Standard-Sprache</td>
                            <td>
                                <xsl:value-of select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:SupportedLanguages/inspire_common:DefaultLanguage/inspire_common:Language" />
                            </td>
                        </tr>

                        <tr>
                            <td>Verfügbare Sprachen</td>
                            <td>
                                <xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:SupportedLanguages/inspire_common:SupportedLanguage/inspire_common:Language">
                                    <xsl:value-of select="."/>
                                    <br/>
                                </xsl:for-each>
                            </td>
                        </tr>

                        <tr>
                            <td>Antwort-Sprache</td>
                            <td>
                                <xsl:value-of select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:ExtendedCapabilities/inspire_dls:ExtendedCapabilities/inspire_common:ResponseLanguage/inspire_common:Language" />
                            </td>
                        </tr>

                        </tbody>
                    </table><br /><br />-->

                    <!-- INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE -->

                    <!-- 2.3 -->
                    <!--<table>
                        <caption>
                            Constraints
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col">Constraint</th>
                                <th scope="col">Wird unterstützt?</th>
                            </tr>
                        </thead>
                        <tbody>
                                <xsl:for-each select="wfs:WFS_Capabilities/ows:OperationsMetadata/ows:Constraint">
                                    <tr>
                                        <td>
                                            <xsl:value-of select="./@name"/>
                                        </td>
                                        <td>
                                            <xsl:value-of select="ows:DefaultValue"/>
                                        </td>
                                    </tr>
                                </xsl:for-each>	
                        </tbody>
                    </table><br /><br />-->


                    <!--<table>
                        <caption>
                            Filter
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col">Constraint</th>
                                <th scope="col">Wird unterstützt?</th>
                            </tr>
                        </thead>
                        <tbody>
                            <xsl:for-each select="wfs:WFS_Capabilities/fes:Filter_Capabilities/fes:Conformance/fes:Constraint">
                                    <tr>
                                            <td><xsl:value-of select="./@name"/></td>
                                            <td>
                                                    <xsl:value-of select="ows:DefaultValue"/>
                                            </td>
                                    </tr>
                            </xsl:for-each>	
                        </tbody>
                    </table><br /><br />	-->

                    <table>
                        <caption>
                            Operatoren
                        </caption>
                        <thead>
                            <tr>
                                <th scope="col" width="30%">Operatoren</th>
                                <th scope="col">Bezeichnung</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Logische Operatoren</td>
                                <td>
                                    <xsl:for-each select="wfs:WFS_Capabilities/ogc:Filter_Capabilities/ogc:Scalar_Capabilities/ogc:Logical_Operators/*">
                                        <xsl:value-of select="substring((name(.)),5)"/>
                                        <br />
                                    </xsl:for-each>	
                                </td>
                            </tr>
                            <tr>
                                <td>Vergleichsoperatoren</td>
                                <td>
                                    <xsl:for-each select="wfs:WFS_Capabilities/ogc:Filter_Capabilities/ogc:Scalar_Capabilities/ogc:Comparison_Operators/*">
                                        <xsl:value-of select="substring((name(.)),5)"/>
                                        <br />
                                    </xsl:for-each>	
                                </td>
                            </tr>
                           
                            <tr>
                                <td>Räumliche Operatoren</td>
                                <td>
                                    <xsl:for-each select="wfs:WFS_Capabilities/ogc:Filter_Capabilities/ogc:Spatial_Capabilities/ogc:Spatial_Operators/*">
                                        <xsl:value-of select="substring((name(.)),5)"/>
                                        <br />
                                    </xsl:for-each>	
                                </td>
                            </tr>
                                <tr>
                                <td>Operationen</td>
                                <td>
                                    <xsl:for-each select="wfs:WFS_Capabilities/ogc:Filter_Capabilities/ogc:Scalar_Capabilities/ogc:Arithmetic_Operators/ogc:Functions/ogc:Function_Names/ogc:Function_Name">
                                        <xsl:value-of select="."/>
                                        <br />
                                    </xsl:for-each>            
                                </td>
                            </tr>  
                            <!--<tr>
                                    <td>Zeitliche Operatoren</td>
                                    <td>
                                            <xsl:for-each select="wfs:WFS_Capabilities/fes:Filter_Capabilities/fes:Temporal_Capabilities/fes:TemporalOperators/fes:TemporalOperator">
                                                    <xsl:value-of select="./@name"/><br />
                                            </xsl:for-each>	
                                    </td>
                            </tr>	-->					
                        </tbody>
                    </table>
                    <br />
                    <br />				
			
            

				
                    <a href="http://www.gdi.bayern.de/impressum.html">Impressum</a> | 
                    <a href="http://www.gdi.bayern.de/kontakt.html">Kontakt</a> | © 
                    <a href="http://www.vermessung.bayern.de/" title="Landesamt für Digitalisierung, Breitband und Vermessung">LDBV</a> - 
                    <a href="http://www.gdi.bayern.de">Geschäftsstelle GDI-BY</a>

                    <br /> 
                    <br />
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
