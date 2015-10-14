<?xml version="1.0" encoding="UTF-8"?>
<!--    
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Capabilities Viewer GDI-BY (XSLT WMS 1.3.0 -> HTML)
    
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
    xmlns:gmd="http://www.isotc211.org/2005/gmd"
    xmlns:inspire_vs="http://inspire.ec.europa.eu/schemas/inspire_vs/1.0"
    xmlns:inspire_common="http://inspire.ec.europa.eu/schemas/common/1.0"
    xmlns:java="de.bayern.lvg.capabilitiesviewer.servlet.CapabilitiesHelper"
    exclude-result-prefixes="java">


    <xsl:param name="development">true</xsl:param>
    
    <!-- ### Parameter ### -->
    <xsl:param name="optIP" />
    <xsl:param name="optLayer" />
    <xsl:param name="optHeader" />
    <xsl:param name="optLegend" />
    <xsl:param name="optLegend">true</xsl:param>
    

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

        <!-- Capabilities Online Resource -->
        <xsl:variable name="orGetC_org">
            <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetCapabilities/wms:DCPType/wms:HTTP/wms:Get/wms:OnlineResource/@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="orGetC">
            <xsl:value-of select="java:getCorrectedOnlineResource($orGetC_org)"/>
            <!-- <xsl:value-of select="$orGetC_org" /> -->
        </xsl:variable>

        <!-- Map Online Resource -->
        <xsl:variable name="orGetM_org">
            <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetMap/wms:DCPType/wms:HTTP/wms:Get/wms:OnlineResource/@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="orGetM">
            <xsl:value-of select="java:getCorrectedOnlineResource($orGetM_org)"/> 
            <!-- <xsl:value-of select="$orGetM_org" /> -->
        </xsl:variable>        
        
        <!-- Legend Online Resource -->
        <xsl:variable name="orGetL_org">
            <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetLegendGraphic/wms:DCPType/wms:HTTP/wms:Get/wms:OnlineResource/@xlink:href"/>
        </xsl:variable>

        <xsl:variable name="orGetL">
            <xsl:value-of select="java:getCorrectedOnlineResource($orGetL_org)"/>
            <!-- <xsl:value-of select="$orGetL_org"/> -->
        </xsl:variable>        
        
        
        <!-- ############### -->
        <!-- # Anfang HTML # -->
        <!-- ############### -->
        
        <html>
            <head>
            	<title>Capabilities - Viewer (Build <xsl:copy-of select="$build"/>) - <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Title"/></title>
                <meta><xsl:attribute name="name">description</xsl:attribute><xsl:attribute name="content"><xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Abstract"/></xsl:attribute></meta>
                <link rel="stylesheet" type="text/css" href="style.css" />
                <link rel="stylesheet" type="text/css" href="getcapabilities.css" />
            </head>
            <body>
                <center>

<xsl:if test="$optLayer=''">

                <!-- Header ausblenden? -->
                <xsl:if test="not($optHeader='skip')">
                    <img src="gdi_header.jpg" /><br />
                    <!--<img src="cv.png" />-->
                    <div style="margin-left: 20px; margin-top: 25px; margin-bottom: 20px;">
                        <span style="font-family: sans-serif;color: #1e5e9b; font-size: 3.4em; font-weight: bold; text-shadow: 2px 4px 2px rgba(0, 0, 0, 0.5);">Capabilities - Viewer</span> 
                    </div>

                    <xsl:if test="$optLegend='true'">
                        <table style="border:0px;">
                            <tr>
                                <td style="border:0px;">
                                    <!--<b><font color="cc0000">Neu:</font> Unterstützung der INSPIRE Technical Guidance 3.0</b>-->
                                </td>
                                <td style="border:0px; float: right;" align="right">
                                    <b><a><xsl:attribute name="href"><xsl:copy-of select="$urlprefix"/>/getcapabilities/CapabilitiesViewer?wms_url=<xsl:value-of select="$orGetC_org"/>&amp;version=1.3&amp;format=html&amp;link=true</xsl:attribute>URL zu dieser Seite</a></b>
                                </td>
                            </tr>
                        </table>
                    </xsl:if>
                </xsl:if>

                <table>
                    <caption>
                        Angaben zum Dienst (WMS 1.3)
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Angaben zum Dienst</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>
                        
                        <!-- 2.1.1 -->
                        <tr>
                            <td>Name des Dienstes</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Name"/>
                            </td>
                        </tr>

                        <!-- 2.1.2 -->
                        <tr>
                            <td>Titel des Dienstes</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Title"/>
                            </td>
                        </tr>


                        <!-- 2.1.3 Schlüsselwörtern -->
                        <tr>
                            <td> Liste von Schlüsselwörtern,<br />die den Dienst beschreiben</td>
                            <td>
                                <ul>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Service/wms:KeywordList/wms:Keyword">
                                    <li><xsl:value-of select="."/></li>
                                </xsl:for-each>
                                </ul>
                            </td>
                        </tr>

                        <!-- 2.1.4 -->
                        <tr>
                            <td>Beschreibung des Dienstes</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Abstract"/>
                            </td>
                        </tr>



                        <!-- 2.1.5 -->
                        <tr>
                            <td>URL zum Aufruf des Dienstanbieters</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:OnlineResource/@xlink:href"/>
                            </td>
                        </tr>

                        

                        <!-- 2.1.6 -->
                        <tr>
                            <td>Kontaktinformationen<br />zum Dienstanbieter</td>
                            <td>
                                <p>Ansprechpartner: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactPersonPrimary/wms:ContactPerson"/></p>
                                <p>Dienstanbieter: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactPersonPrimary/wms:ContactOrganization"/></p>
                                <p>Art der Adresse: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:AddressType"/></p>
                                <p>Straße: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:Address"/></p>
                                <p>Stadt: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:City"/></p>
                                <p>Bundesland: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:StateOrProvince"/></p>
                                <p>Postleitzahl: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:PostCode"/></p>
                                <p>Land: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactAddress/wms:Country"/></p>
                                <p>Telefonnummer: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactVoiceTelephone"/></p>
                                <p>Fax-Nummer: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactFacsimileTelephone"/></p>
                                <p>E-Mail: <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:ContactInformation/wms:ContactElectronicMailAddress"/></p>
                            </td>
                        </tr>



                        <!-- 2.1.7 -->
                        <tr>
                            <td>Gebühren</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Fees"/>
                            </td>
                        </tr>

                        <!-- 2.1.8 -->
                        <tr>
                            <td>Nutzungsbeschränkungen</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:AccessConstraints"/>
                            </td>
                        </tr>

                        <!-- nur WMS 1.3 -->
                        <tr>
                            <td>Maximale Bildbreite</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:MaxWidth"/>
                            </td>
                        </tr>

                        <!-- nur WMS 1.3 -->
                        <tr>
                            <td>Maximale Bildhöhe</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:MaxHeight"/>
                            </td>
                        </tr>


                    </tbody>
                </table><br /><br />


<!-- INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE -->

               <table>
                    <caption>
                        Erweiterte Capabilities für INSPIRE-Darstellungsdienst<br />
                        (nach Technical Guidance Documents Version 3.0 - 21.03.11 - Szenario 1)
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
                                        <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:URL"/>
                                    </xsl:attribute>
                                    <xsl:attribute name="target">
                                        _blank
                                    </xsl:attribute>
                                    <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:URL"/>
                                </a>
                                
                            </td>
                        </tr>

                        <tr>
                            <td>Metadaten des Dienstes (MediaType)</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:MetadataUrl/inspire_common:MediaType"/>
                            </td>
                        </tr>


                        <tr>
                            <td>Standard Sprache</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:SupportedLanguages/inspire_common:DefaultLanguage/inspire_common:Language" />
                            </td>
                        </tr>


                        <tr>
                            <td>Weitere unterstützte Sprachen</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:SupportedLanguages/inspire_common:SupportedLanguage/inspire_common:Language">
                                    <xsl:value-of select="."/>
                                    <br/>
                                </xsl:for-each>
                            </td>
                        </tr>



                        <tr>
                            <td>Antwort-Sprache</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/inspire_vs:ExtendedCapabilities/inspire_common:ResponseLanguage/inspire_common:Language" />
                            </td>
                        </tr>

                    </tbody>
                </table><br /><br />

<!-- INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE INSPIRE -->


                <!-- 2.2 -->
                <table>
                    <caption>
                        Angaben zu den Capabilities
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaften des<br />Capabilities-Dokumentes</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>

                        <!-- 2.2 -->
                        <tr>
                            <td>Format des Capabilities-Dokumentes</td>
                            <td>
                                <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetCapabilities/wms:Format"/>
                            </td>
                        </tr>
                        <tr>
                            <td>URL zum Aufruf des Capabilities-Dokumentes</td>
                            <td>
                                <xsl:value-of select="$orGetC"/>
                            </td>
                        </tr>                        
                    </tbody>
                </table><br /><br />


                <!-- 2.3 -->
                <table>
                    <caption>
                        Angaben zu den verfügbaren Karten (GetMap)
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaften Kartenaufruf</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                        </thead>
                    <tbody>
                        
                         <!-- 2.1.1 -->
                        <tr>
                            <td>Datenformate der verfügbaren Karten</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetMap/wms:Format">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>
                        <tr>
                            <td>URL zum Aufruf der Kartenlayer</td>
                            <td>
                                <xsl:value-of select="$orGetM"/>
                            </td>
                        </tr>                    
                    </tbody>
                </table><br /><br />


                <!-- 2.4 -->
                <table>
                    <caption>
                        Angaben zu den Fehlermeldungen
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaften für die<br />Fehlerausgabe</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>

                        <!-- 2.1.1 -->
                        <tr>
                            <td>Ausgabeformate der<br />Fehlermeldungen</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Exception/wms:Format">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>

                    </tbody>
                </table><br /><br />



                <!-- ??? -->
                <table>
                    <caption>
                        Angaben zu den im Service verfügbaren Layern
                    </caption>
                    <thead>
                        <tr>
                            <th scope="col">WMS (Title)</th>
                            <th scope="col">Layer (Title)</th>
                            <th scope="col">Layer (Name)</th>
                        </tr>
                    </thead>
                    <tbody>

                        <!-- -->
                        <tr>
                            <td><xsl:value-of select="wms:WMS_Capabilities/wms:Service/wms:Title"/></td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">
                                    
                                       <xsl:value-of select="substring('- - - - - - - - - - - - - - - - - - - - - - - - ',1,count(ancestor::*)*5-15)"/><xsl:value-of select="wms:Title"/><br/>
                                    
                                </xsl:for-each>
                            </td>

                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">

                                       <xsl:value-of select="substring('- - - - - - - - - - - - - - - - - - - - - - - - ',1,count(ancestor::*)*5-15)"/>[<xsl:value-of select="wms:Name"/>]<br/>

                                </xsl:for-each>
                            </td>
                        </tr>

                    </tbody>
                </table><br /><br />



                <!-- 2.6.2.5 -->              
                <table>
                    <caption>
                       Maßstabsabhängige Darstellung
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Layer (Title)</th>
                             <th scope="col">ScaleDenominator [min]</th>
                             <th scope="col">ScaleDenominator [max]</th>
                        </tr>
                    </thead>
                    <tbody>


                        
                        
                        <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">

                        <xsl:if test="not(wms:Layer)">
                        <tr>
                            <td>
                                <xsl:value-of select="wms:Title" />
                            </td>
                            <td>
                                <xsl:value-of select="wms:MinScaleDenominator" />
                            </td>
                            <td>
                                <xsl:value-of select="wms:MaxScaleDenominator" />
                            </td>
                        </tr>
                        </xsl:if>
                        </xsl:for-each>


                    </tbody>
                </table><br /><br />




                <!-- ??? -->
                <table>
                    <caption>
                        Angaben zu den verfügbaren Legenden (GetLegendGraphic)
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaften<br />Legenden</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>

                        <!-- -->
                        <tr>
                            <td>Datenformate</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Request/sld:GetLegendGraphic/wms:Format">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>
                        <tr>
                            <td>URL zum Aufruf der Legende</td>
                            <td>
                                <xsl:value-of select="$orGetC"/>
                            </td>
                        </tr>   

                    </tbody>
                </table><br /><br />




 <!-- #################################################################### -->
                <!-- 2.6.2.6 -->

                <!-- Legende anzeigen ? -->
                <xsl:if test="$optLegend='true'">

                    <xsl:variable name="isGetLegendGraphic">
                        <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetLegendGraphic/wms:Format" />
                    </xsl:variable>


                    <xsl:if test="not($isGetLegendGraphic = '')">
                        <table>
                            <caption>
                           Legende (via GetLegendGraphic)
                            </caption>
                            <thead>
                                <tr>
                                    <th scope="col">Layer (Title)</th>
                                    <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetLegendGraphic/wms:Format">
                                        <xsl:if test="not(.='image/wbmp') and not(.='image/vnd.wap.wbmp')">
                                            <th scope="col">Legende
                                                <br />
                                                <i>
                                                    <xsl:value-of select="."/>
                                                </i>
                                            </th>
                                        </xsl:if>
                                    </xsl:for-each>


                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">
                                    <xsl:if test="not(wms:Layer)">
                                        <xsl:variable name="curLay">
                                            <xsl:value-of select="wms:Name"/>
                                        </xsl:variable>
                                        <tr>
                                            <td>
                                                <xsl:value-of select="wms:Title" />
                                            </td>
                                            <xsl:for-each select="/wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetLegendGraphic/wms:Format">
                                                <xsl:if test="not(.='image/wbmp') and not(.='image/vnd.wap.wbmp')">
                                                    <td>
                                                        <img>
                                                            <xsl:attribute name="src">
                                                                <xsl:copy-of select="$orGetL"/>LAYER=<xsl:value-of select="$curLay"/>&amp;SERVICE=WMS&amp;VERSION=1.3&amp;REQUEST=GetLegendGraphic&amp;FORMAT=<xsl:value-of select="." />
                                                            </xsl:attribute>
                                                        </img>
                                                    </td>
                                                </xsl:if>
                                            </xsl:for-each>
                                        </tr>
                                    </xsl:if>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        <br />
                        <br />
                    </xsl:if>


                    <!-- Wenn keine GetLegendGraphic -->
                    <xsl:if test="$isGetLegendGraphic = ''">

                        <table>
                            <caption>
                           Angaben zur Legende (via LegendURL)
                            </caption>
                            <thead>
                                <tr>
                                    <th scope="col">Layer (Title)</th>
                                    <th scope="col">Legende</th>
                                </tr>
                            </thead>
                            <tbody>
                                <xsl:for-each select="/wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">
                                    <xsl:if test="not(wms:Layer)">
                                        <tr>
                                            <td>
                                                <xsl:value-of select="wms:Title" />
                                                </td>
                                                <td>
                                                    <xsl:variable name="imgsrc">
                                                        <xsl:value-of select="wms:Style/wms:LegendURL/wms:OnlineResource/@xlink:href" />
                                                    </xsl:variable>


                                                    <xsl:if test="not($imgsrc='')">
                                                        <img>
                                                            <xsl:attribute name="src">
                                                                <xsl:value-of select="$imgsrc" />
                                                            </xsl:attribute>
                                                        </img>
                                                    </xsl:if>
                                                </td>
                                        </tr>
                                    </xsl:if>
                                </xsl:for-each>
                            </tbody>
                        </table>
                        <br />
                        <br />
                    </xsl:if>

                </xsl:if>
 <!-- #################################################################### -->






                <table>
                    <caption>
                       Angaben zu den Sachinformationen (GetFeatureInfo)
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Eigenschaften<br />der Sachinformationen</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>

                        <!-- -->
                        <tr>
                            <td>Ausgabeformate der<br />Sachinformationen</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Request/wms:GetFeatureInfo/wms:Format">
                                    <xsl:value-of select="."/><br/>
                                </xsl:for-each>
                            </td>
                        </tr>
                         <tr>
                            <td>URL zum Aufruf der Sachinformationen</td>
                            <td>
                                <xsl:value-of select="$orGetM"/>
                            </td>
                        </tr>
                    </tbody>
                </table><br /><br />


                
                <!-- 2.6.5 -->
                <table>
                    <caption>
                        Allgemeine Angaben zu den Layern
                    </caption>
                    <thead>
                        <tr>
                             <th scope="col">Angaben zu den<br />Elternlayern</th>
                            <th scope="col">Beschreibung</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Angaben zum<br/>Koordinatenreferenzsystem (EPSG - Code)</td>
                            <td>
                                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:CRS">
                                    <xsl:value-of select="."/><br />
                                </xsl:for-each>
                            </td>
                        </tr>
                        <tr>
                            <td>Räumliche Verfügbarkeit<br/>der Layer</td>
                            <td>
                                Geographische Begrenzung:<br />
                                Nord: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:EX_GeographicBoundingBox/wms:northBoundLatitude"/><br />
                                Ost: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:EX_GeographicBoundingBox/wms:eastBoundLongitude"/><br />
                                Süd: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:EX_GeographicBoundingBox/wms:southBoundLatitude"/><br />
                                West: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:EX_GeographicBoundingBox/wms:westBoundLongitude"/><br />
                                <br />


                                Begrenzung bezogen auf: <xsl:value-of select="/wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:BoundingBox/@CRS"/> - Achtung WMS 1.3 Achsenregelung!<br />
                                maxX: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:BoundingBox/@maxx"/><br />
                                maxY: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:BoundingBox/@maxy"/><br />
                                minX: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:BoundingBox/@minx"/><br />
                                minY: <xsl:value-of select="wms:WMS_Capabilities/wms:Capability/wms:Layer/wms:BoundingBox/@miny"/><br />
                            </td>
                        </tr>
                    </tbody>
                </table><br /><br />
</xsl:if>



                <xsl:for-each select="wms:WMS_Capabilities/wms:Capability/wms:Layer//wms:Layer">
                    <xsl:if test="not(wms:Layer)">
                        <xsl:if test="$optLayer = '' or wms:Name=$optLayer">
                        <table>
                            <caption>
                               Details zum Layer: <i><xsl:value-of select="wms:Title" /></i>
                            </caption>
                            <thead>
                                <tr>
                                     <th scope="col" width="30%">Angaben zu den Elternlayern</th>
                                    <th scope="col">Beschreibung</th>
                                </tr>
                            </thead>
                            <tbody>

                                <!-- 2.6.5.1 -->
                                <tr>
                                    <td>Name des Layers</td>
                                    <td>
                                        <xsl:value-of select="wms:Name" />
                                    </td>
                                </tr>

                                <!-- 2.6.5.2 -->
                                <tr>
                                    <td>Titel des Layers</td>
                                    <td>
                                        <xsl:value-of select="wms:Title" />
                                    </td>
                                </tr>

                                <!-- 2.6.5.3 -->
                                <tr>
                                    <td>Beschreibung des Layers</td>
                                    <td>
                                        <xsl:value-of select="wms:Abstract" />
                                    </td>
                                </tr>


                                <!-- 2.6.5.4 Schlüsselwörtern -->
                                <tr>
                                    <td> Liste von Schlüsselwörtern,<br />die den Layer beschreiben</td>
                                    <td>
                                        <ul>
                                        <xsl:for-each select="wms:KeywordList/wms:Keyword">
                                            <li><xsl:value-of select="."/></li>
                                        </xsl:for-each>
                                        </ul>
                                    </td>
                                </tr>


                                <!-- ??? -->
                                <tr>
                                    <td>Angaben zum<br/>Koordinatenreferenzsystem (EPSG - Code)</td>
                                    <td>
                                        <xsl:for-each select="wms:CRS">
                                            <xsl:value-of select="."/><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Räumliche Verfügbarkeit<br/>der Layer</td>
                                    <td>
                                        Geographische Begrenzung:<br />
                                        Nord: <xsl:value-of select="wms:EX_GeographicBoundingBox/wms:northBoundLatitude"/><br />
                                        Ost: <xsl:value-of select="wms:EX_GeographicBoundingBox/wms:eastBoundLongitude"/><br />
                                        Süd: <xsl:value-of select="wms:EX_GeographicBoundingBox/wms:southBoundLatitude"/><br />
                                        West: <xsl:value-of select="wms:EX_GeographicBoundingBox/wms:westBoundLongitude"/><br />
                                        <br />

                                        <u>Achtung WMS 1.3 Achsenregelung</u>!<br /><br />
                                        <xsl:for-each select="wms:BoundingBox">
                                            Begrenzung bezogen auf: <xsl:value-of select="@CRS"/><br />

                                            maxX: <xsl:value-of select="@maxx"/><br />
                                            maxY: <xsl:value-of select="@maxy"/><br />
                                            minX: <xsl:value-of select="@minx"/><br />
                                            minY: <xsl:value-of select="@miny"/><br /><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>

                                <!-- -->

                                <tr>
                                    <td>Metadaten URL<br/> (Geodaten des Layer)</td>
                                    <td>
                                        <xsl:for-each select="wms:MetadataURL">
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="wms:OnlineResource/@xlink:href" />
                                                </xsl:attribute>
                                                <xsl:attribute name="target">
                                                    _blank
                                                </xsl:attribute>
                                                <xsl:value-of select="wms:OnlineResource/@xlink:href" />
                                            </a>
                                            <br />
                                            Typ = <i><xsl:value-of select="@type" /></i> | Format = <i><xsl:value-of select="wms:Format" /></i><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Identifikator des Layers</td>
                                    <td>
                                        <xsl:for-each select="wms:Identifier">
                                            <xsl:value-of select="." /><br />
                                            Authority= <xsl:value-of select="@authority" /><br /><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Authority URL</td>
                                    <td>
                                        <xsl:for-each select="wms:AuthorityURL">
                                            Name= <xsl:value-of select="@name" /><br />
                                            Link = <xsl:value-of select="wms:OnlineResource/@xlink:href" /><br /><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>

                                <tr>
                                    <td>Daten URL</td>
                                    <td>
                                        <xsl:for-each select="wms:DataURL">
                                            <a>
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="wms:OnlineResource/@xlink:href" />
                                                </xsl:attribute>
                                                <xsl:attribute name="target">
                                                    _blank
                                                </xsl:attribute>
                                                <xsl:value-of select="wms:OnlineResource/@xlink:href" />
                                            </a>
                                            <br />
                                            Typ = <i><xsl:value-of select="wms:OnlineResource/@xlink:type" /></i> | Format = <i><xsl:value-of select="wms:Format" /></i><br />
                                        </xsl:for-each>
                                    </td>
                                </tr>

                                <!-- -->

                            </tbody>
                        </table>
                        </xsl:if>
                    </xsl:if>
                </xsl:for-each>

                <a href="http://www.gdi.bayern.de/impressum.html">Impressum</a> | <a href="http://www.gdi.bayern.de/kontakt.html">Kontakt</a> | © <a href="http://www.vermessung.bayern.de/" title="Landesamt für Digitalisierung, Breitband und Vermessung">LDBV</a> - <a href="http://www.gdi.bayern.de">Geschäftsstelle GDI-BY</a>

                <br /> <br />
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
