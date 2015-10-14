<?xml version="1.0" encoding="UTF-8"?>
<!--
"""
/***************************************************************************

    
    Capabilities Viewer GDI-BY (XSLT WMTS 1.0.0 -> HTML)
    
    Stand: 14.10.2015
    
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
 
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.   
    
***************************************************************************/
"""
-->
<xsl:stylesheet version="1.0"

                xmlns:wmts="http://www.opengis.net/wmts/1.0" 
                xmlns:ows="http://www.opengis.net/ows/1.1" 
                xmlns:xlink="http://www.w3.org/1999/xlink" 
                xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
                xsi:schemaLocation="http://www.opengis.net/wmts/1.0 http://schemas.cubewerx.com/schemas/wmts/1.0/wmtsGetCapabilities_response.xsd"
  
                xmlns:gml="http://www.opengis.net/gml" 
                xmlns:sld="http://www.opengis.net/sld"
                xmlns:wms="http://www.opengis.net/wms"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:inspire_vs="http://inspire.ec.europa.eu/schemas/inspire_vs/1.0"
                xmlns:inspire_common="http://inspire.ec.europa.eu/schemas/common/1.0"
                xmlns:java="de.bayern.lvg.capabilitiesviewer.servlet.CapabilitiesHelper"
                exclude-result-prefixes="java">


    <xsl:param name="development">true</xsl:param>
    
    <!-- ### Parameter ### -->
    <xsl:param name="optIP" />
    <xsl:param name="optLayer" />
    <xsl:param name="optHeader" />
    <!-- <xsl:param name="optLegend" /> -->
    <xsl:param name="optLegend">true</xsl:param>
    

    <!-- ### Variablen ### -->
    <xsl:variable name="build">
        <!-- <xsl:value-of select="java:getBuild()"/> -->
        !Manuelle Transformation!
        
    </xsl:variable>        
    <xsl:variable name="urlprefix">
        <!-- <xsl:value-of select="java:getUrlprefix($optIP)"/> -->
        http://wwww.geoportal.bayern.de
    </xsl:variable>


    <xsl:template match="/">
        
        <!-- ### Variablen ### -->

        <!-- Capabilities Online Resource -->
        <xsl:variable name="orGetC_org">
            <xsl:value-of select="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="orGetC">
            <!-- <xsl:value-of select="java:getCorrectedOnlineResource($orGetC_org)"/> -->
            <xsl:value-of select="$orGetC_org" />
        </xsl:variable>
        
        <!-- Tile Resource -->
        <xsl:variable name="orGetT_org">
            <xsl:value-of select="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetTile']/ows:DCP/ows:HTTP/ows:Get/@xlink:href"/>
        </xsl:variable>
        <xsl:variable name="orGetT">
            <!-- <xsl:value-of select="java:getCorrectedOnlineResource($orGetT_org)"/> -->
            <xsl:value-of select="$orGetT_org" />
        </xsl:variable>      
        
 
        <!-- ############### -->
        <!-- # Anfang HTML # -->
        <!-- ############### -->
        
        <html>
            <head>
                <title>Capabilities - Viewer (Build <xsl:copy-of select="$build"/>) - <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersionCapabilities/ows:ServiceIdentification/ows:TitleCapabilities/ows:ServiceIdentification/ows:Title/@xml:lang"/></title>
                <meta>
                    <xsl:attribute name="name">description</xsl:attribute>
                    <xsl:attribute name="content">
                        <xsl:value-of select="Capabilities/ows:ServiceIdentificationCapabilities/ows:ServiceIdentification/ows:AbstractCapabilities/ows:ServiceIdentification/ows:Abstract/@xml:lang"/>
                    </xsl:attribute>
                </meta>
                <link rel="stylesheet" type="text/css" href="style.css" />
                <link rel="stylesheet" type="text/css" href="getcapabilities.css" />
            </head>
            <body>
                <center>

                    <xsl:if test="$optLayer=''">

                       
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
                                        <td style="border:0px;">
                                        </td>
                                        <td style="border:0px; float: right;" align="right">
                                            <b>
                                                <a>
                                                    <xsl:attribute name="href">
                                                        <xsl:copy-of select="$urlprefix"/>/getcapabilities/CapabilitiesViewer?wmts_url=<xsl:value-of select="$orGetC_org"/>
                                                    </xsl:attribute>URL zu dieser Seite</a>
                                            </b>
                                        </td>
                                    </tr>
                                </table>
                            </xsl:if>
                        </xsl:if>

                        <table>
                            <caption>
                                Angaben zum Service (WMTS 1.0.0)
                            </caption>
                            <thead>
                                <tr>
                                    <th scope="col">Angaben zum Service</th>
                                    <th scope="col">Beschreibung</th>
                                </tr>
                            </thead>
                            <tbody>
                        
                                <!-- 1.1.1 -->
                                <tr>
                                    <td>
                                        <b>Name des Service</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:Title"/>
                                    </td>
                                </tr>

                                <!-- 1.1.2 -->
                                <tr>
                                    <td>
                                        <b>Beschreibung des Dienstes</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:Abstract"/>
                                    </td>
                                </tr>


                                <!-- 1.1.3 Schlüsselwörtern -->
                                <tr>
                                    <td>
                                        <b>Liste von Schlüsselwörtern,
                                            <br />die den Dienst beschreiben</b>
                                    </td>
                                    <td>
                                        <ul>
                                            <xsl:for-each select="wmts:Capabilities/ows:ServiceIdentification/ows:Keywords/ows:Keyword">
                                                <li>
                                                    <xsl:value-of select="."/>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </td>
                                </tr>		
                        
                        
                                <!-- 1.1.4 -->
                                <tr>
                                    <td>
                                        <b>Diensttyp</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:ServiceType"/>
                                    </td>
                                </tr>

                                <!-- 1.1.5 -->
                                <tr>
                                    <td>
                                        <b>Version</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:ServiceTypeVersion"/>
                                    </td>
                                </tr>
                      

                                <!-- 1.1.6 -->
                                <tr>
                                    <td>
                                        <b>Kontaktinformationen<br />zum Dienstanbieter</b>
                                    </td>
                                    <td>
                                        <p>
                                            <b>Ansprechpartner</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:IndividualName"/>
                                        </p>
                                        <p>
                                            <b>Organisation</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ProviderName"/>
                                        </p>
                                        <p>
                                            <b>Zustellung/Adresse</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:DeliveryPoint"/>
                                        </p>
                                        <p>
                                            <b>Stadt</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:City"/>
                                        </p>
                                        <p>
                                            <b>Bundesland</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:AdministrativeArea"/>
                                        </p>
                                        <p>
                                            <b>Postleitzahl</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:PostalCode"/>
                                        </p>
                                        <p>
                                            <b>Land</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:Country"/>
                                        </p>
                                        <p>
                                            <b>Telefonnummer</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Voice"/>
                                        </p>
                                        <p>
                                            <b>Fax-Nummer </b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Phone/ows:Facsimile"/>
                                        </p>
                                        <p>
                                            <b>E-Mail</b>: <xsl:value-of select="wmts:Capabilities/ows:ServiceProvider/ows:ServiceContact/ows:ContactInfo/ows:Address/ows:ElectronicMailAddress"/>
                                        </p>
                                    </td>
                                </tr>



                                <!-- 1.1.7 -->
                                <tr>
                                    <td>
                                        <b>Gebühren</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:Fees"/>
                                    </td>
                                </tr>

                                <!-- 1.1.8 -->
                                <tr>
                                    <td>
                                        <b>Nutzungsbeschränkungen</b>
                                    </td>
                                    <td>
                                        <xsl:value-of select="wmts:Capabilities/ows:ServiceIdentification/ows:AccessConstraints"/>
                                    </td>
                                </tr>

                            </tbody>
                        </table>
                        <br />
                        <br />


                        <!-- 2.2.0 -->
                        <xsl:if test="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']">       
                            <table>
                                <caption>
                                    Angaben zum KVP Capabilities-Aufruf (GetCapabilities)
                                </caption>
                                <thead>
                                    <tr>
                                        <th scope="col">Eigenschaften des<br />Capabilities-Dokumentes</th>
                                        <th scope="col">Beschreibung</th>
                                    </tr>
                                </thead>
                                <tbody>

                                  
                                    <tr>
                                        <td>
                                            <td> Encoding der Tiles</td>
                                        </td>
                                        <td>
                                            <xsl:value-of select="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities']/ows:DCP/ows:HTTP/ows:Get/ows:Constraint/ows:AllowedValues/ows:Value"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>OnlineResource</td>
                                        <td>
                                            <xsl:value-of select="$orGetC"/>
                                        </td>
                                    </tr>     
                                                               
                                </tbody>
                            </table>
                            <br />
                            <br />
                        </xsl:if>

                        <!-- 2.2.1 -->
                        <xsl:if test="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetTile']">                       

                            <table>
                                <caption>
                                    Angaben zum Kachelaufruf (GetTile)
                                </caption>
                                <thead>
                                    <tr>
                                        <th scope="col">Eigenschaften der<br />Tiles</th>
                                        <th scope="col">Beschreibung</th>
                                    </tr>
                                </thead>
                                <tbody>

                                 
                                    <tr>
                                        <td> Encoding der Tiles</td>
                                        <td>
                                            <xsl:value-of select="wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetTile']/ows:DCP/ows:HTTP/ows:Get/ows:Constraint/ows:AllowedValues/ows:Value"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>OnlineResource</td>
                                        <td>
                                            <xsl:value-of select="$orGetT"/>
                                        </td>
                                    </tr>    
                                            
                                </tbody>
                            </table>
                            <br />
                            <br />
                        
                        </xsl:if>
                        
                        <!-- 2.2.2 -->
                        <xsl:if test="not(wmts:Capabilities/ows:OperationsMetadata/ows:Operation[@name='GetCapabilities'])"> 
                            <table>
                                <caption>
                                    REST-Capabilities URL
                                </caption>
                                <thead>
                                    <tr>
                                        <th scope="col">REST-Capabilities URL</th>
                                        <th scope="col">Angabe</th>
                                    </tr>
                                </thead>
                                <tbody>

                                 
                                    <tr>
                                        <td>
                                            <b>REST-Capabilities URL</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="wmts:Capabilities/wmts:ServiceMetadataURL/@xlink:href"/>
                                        </td>
                                    </tr>
                               
                                            
                                </tbody>
                            </table>
                            <br />
                            <br />
                        
                        </xsl:if>
                        
                
                        <!-- 2.3 Beschreibung der Layer --> 

                        <xsl:for-each select="wmts:Capabilities/wmts:Contents/wmts:Layer">
                                  
                            <table>
                                <caption>
                                    Details zum Layer <i>
                                        <xsl:value-of select="ows:Title" />
                                    </i>
                                </caption>
                                <thead>
                                    <tr>
                                        <th scope="col" width="30%">Angaben zum Layer</th>
                                        <th scope="col">Beschreibung</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <!-- 2.3.1 -->
                                    <tr>
                                        <td>
                                            <b>Name des Layers</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="ows:Title" />
                                        </td>
                                    </tr>


                                    <!-- 2.3.2 -->
                                    
                                    <xsl:if test="ows:Abstract">
                                        <tr>
                                            <td>
                                            
                                                <b>Beschreibung des Layers</b>
                                            </td>
                                            <td>
                                                <xsl:value-of select="ows:Abstract" />
                                            </td>
                                        
                                        </tr>
                                    
                                    </xsl:if>
                                
                                
                                    <!-- 2.3.3 Schlüsselwörtern -->
                                    
                                    <xsl:if test="ows:Keywords/ows:Keyword">
                                        <tr>
                                            <td>
                                                <b>Liste von Schlüsselwörtern,
                                                    <br />die den Layer beschreiben</b>
                                            </td>
                                            <td>
                                                <ul>
                                                    <xsl:for-each select="ows:Keywords/ows:Keyword">
                                                        <li>
                                                            <xsl:value-of select="."/>
                                                        </li>
                                                    </xsl:for-each>
                                                </ul>
                                            </td>
                                        </tr>		
                                
                                    </xsl:if>

                                    <!-- 2.3.4 BBOX -->
                                    <tr>
                                        <td> 
                                            <b> Bounding Box (in WGS84) </b> 
                                        </td>
                                        <td>
                                        
                                            <b>Begrenzung</b>:<br />
                                            Unteres Eck: <xsl:value-of select="ows:WGS84BoundingBox/ows:LowerCorner"/>
                                            <br />
                                            Oberes Eck: <xsl:value-of select="ows:WGS84BoundingBox/ows:UpperCorner"/>
                                            <br />
                                          
                                        </td>
                                    </tr>

                                    <!-- 2.3.5 -->
                                    <tr>
                                        <td>
                                            <b>Identifikator</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="ows:Identifier" />
                                        </td>
                                    </tr>


                                    <!-- 2.3.6 Legenden -->
                                    <xsl:for-each select="wmts:Style/wmts:LegendURL">
                               
                                        <tr>
                                            <td>
                                                <b>Legenden-URL</b>
                                                <br />
                                                <xsl:if test="@minScaleDenominator">
                                                    MinScaleDenominator <xsl:value-of select="@minScaleDenominator" />
                                                    <br />
                                                    MaxScaleDenominator <xsl:value-of select="@maxScaleDenominator" />
                                                </xsl:if>
                                            </td>
                                    
                                        
                                            <td>
                                        
                                                <img style="max-height: 200px; max-width: 200px;" > 
                                                    <xsl:attribute name="src">
                                                        <xsl:value-of select="@xlink:href" />
                                                    </xsl:attribute>
                                                </img>                                        
                                        
                                            </td> 
                                        
                                        </tr>                                        
                                        
                                    </xsl:for-each>


                                    <!-- 2.3.7 -->
                                    <tr>
                                        <td>
                                            <b>Format</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="wmts:Format" />
                                        </td>
                                    </tr>

                                    <!-- 2.3.8 -->
                                    <tr>
                                        <td>
                                            <b>Tile Matrix Set</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="wmts:TileMatrixSetLink/wmts:TileMatrixSet" />
                                        </td>
                                    </tr>

                                    <!-- 2.3.9 -->
                                    <tr>
                                        <td>
                                            <b>Ressourcen-URL</b>
                                        </td>
                                    
                                        <td>
                                            <xsl:value-of select="wmts:ResourceURL/@template"/>
                                                
                                        </td> 
                                        
                              
                                    </tr>

                       
                                </tbody>
                            </table>
                           
                            <br />
                        </xsl:for-each>
                        <br />
       
                        <!-- 2.4 -->
                        
                        <xsl:for-each select="wmts:Capabilities/wmts:Contents/wmts:TileMatrixSet">
                            
                            <table>
                                <caption>
                                    Tile Matrix Set - Angaben zu  <i> 
                                        <xsl:value-of select="ows:Title"/> 
                                    </i>
                                </caption>
                                <thead>
                                    <tr>
                                        <th scope="col">Angaben zum Tile Matrix Set</th>
                                        <th scope="col">Beschreibung</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <!-- 2.2.1 -->
                                    <tr>
                                        <td>
                                            <b>Titel des Tile Matrix Sets</b>
                                        </td>
                                        <td>
                                            <xsl:value-of select="ows:Title"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Beschreibung</td>
                                        <td>
                                            <xsl:value-of select="ows:Abstract"/>
                                        </td>
                                    </tr>     
                                
                                    <tr>
                                        <td>Identifikator</td>
                                        <td>
                                            <xsl:value-of select="ows:Identifier"/>
                                        </td>
                                    </tr>    
                                
                                    <tr>
                                        <td>Unterstütztes Koordinatenreferenzsystem</td>
                                        <td>
                                            <xsl:value-of select="ows:SupportedCRS"/>
                                        </td>
                                    </tr> 
                                
                                    <xsl:for-each select="wmts:TileMatrix">
                                                                    
                                        <tr>
                                            <td> Angaben zur Tile Matrix</td>
                         
                                            <td>
                            
                                                <b>Beschreibung der Tile Matrix</b>
                                                <br />
                                                <br />
                                                <b> Titel </b> : <xsl:value-of select="ows:Title"/> 
                                                <br />
                                                <b> Identifikator </b> : <xsl:value-of select="ows:Identifier"/>
                                                <br />
                                                <b> Maßstabsangabe</b>: <xsl:value-of select="wmts:ScaleDenominator"/>
                                                <br />
                                                <b> Linker oberer Begrenzungspunkt </b>: <xsl:value-of select="wmts:TopLeftCorner"/>
                                                <br />
                                                <b> Kachelbreite</b> : <xsl:value-of select="wmts:TileWidth"/>
                                                <br />
                                                <b> Kachelhöhe </b> : <xsl:value-of select="wmts:TileHeight"/>
                                                <br />
                                                <b> Matrixweite </b> : <xsl:value-of select="wmts:MatrixWidth"/>
                                                <br />
                                                <b> Matrixhöhe </b> : <xsl:value-of select="wmts:MatrixHeight"/>
                                                <br />
                                            </td>
                                  
                                        </tr>
                                   
                                    </xsl:for-each>  
                                                               
                                </tbody>
                            </table>
                            <br />
                        </xsl:for-each>
                        
                        <br />
                        <br />

                    </xsl:if>

                    <a href="http://www.gdi.bayern.de/impressum.html">Impressum</a> | <a href="http://www.gdi.bayern.de/kontakt.html">Kontakt</a> | © <a href="http://www.vermessung.bayern.de/" title="Landesamt für Vermessung und Geoinformation Bayern">LVG</a> - <a href="http://www.gdi.bayern.de">Geschäftsstelle GDI-BY</a>

                    <br /> 
                    <br />
                </center>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
