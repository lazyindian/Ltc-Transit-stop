<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl">
  
  <xsl:output method="html" indent="yes"/>
  
  <!--default variables-->
  <xsl:param name="route_num" select="'106'"/>
  <xsl:param name="street_name" select="'Oxford'"/>

  <xsl:param name="total_stops" select="count(//stop[contains(routes, $route_num)]) + count(//stop[contains(@name, $street_name)])"/>
  <xsl:template match="/">
    
    <div class="container-fluid">
      <h2>
        <font face="Verdana">

          <xsl:if test="count(//stop[contains(routes, $route_num)]) or count(//stop[contains(@name, $street_name)])">
            <xsl:choose>
              <xsl:when test="//stop[contains(routes, $route_num)]">
                <!-- Executes the THEN part of the pattern here-->
                <xsl:value-of select="count(//stop[contains(routes, $route_num)])"/> stops returned.<br />
              </xsl:when>
              <xsl:when test="//stop[contains(@name, $street_name)]">
                <xsl:value-of select="count(//stop[contains(@name, $street_name)])"/> stops returned.<br />
              </xsl:when>
              <xsl:otherwise>
                <!-- Executes the ELSE part of the pattern here-->
                <xsl:value-of select="$total_stops"/> stops returned.<br />
              </xsl:otherwise>
            </xsl:choose>
          </xsl:if>

        </font>
      </h2>
      <br/>
      <table class="table table-bordered" style="b: 10;">
        <thead class="table-dark">
          <tr>
            <th scope="col">
              <font face="Verdana" size="4">Stop #</font>
            </th>
            <th scope="col">
              <font face="Verdana" size="4">Stop Name</font>
            </th>
            <th scope="col">
              <font face="Verdana" size="4">Latitude</font>
            </th>
            <th scope="col">
              <font face="Verdana" size="4">Longitude</font>
            </th>
            <th scope="col">
              <font face="Verdana" size="4">Routes</font>
            </th>
          </tr>
        </thead>
        <tbody>
          <xsl:apply-templates>
            <xsl:sort select="@id" data-type="number"/>
          </xsl:apply-templates>
        </tbody>
      </table>
    </div>
    </xsl:template>
  
  <!--Template 00
  Name:       List Total Stops, Empty stops, Routes or Street names only
  Accepts:    nothing, route number or street name
  Returns:    Lists every stop with specified parameters -->
   
  <xsl:template match="stop">
    <xsl:if test="contains(@name, $street_name) and contains(routes, $route_num)">
      <tr>
        <th scope="row"><xsl:value-of select="@id"/></th>
        <td ><xsl:value-of select="@name"/></td>
        <td ><xsl:value-of select="location/@lattitude"/></td>
        <td ><xsl:value-of select="location/@longitude"/></td>
        <td ><xsl:value-of select="routes"/></td>
      </tr>
  </xsl:if>
  </xsl:template>

</xsl:stylesheet>
