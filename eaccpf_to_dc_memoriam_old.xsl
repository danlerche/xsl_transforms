<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:eac-cpf="urn:isbn:1-931666-33-4"
xmlns:oai-dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
exclude-result-prefixes="eac-cpf">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
<xsl:template match="eac-cpf:eac-cpf">
<oai-dc:dc>
<dc:identifier><xsl:value-of select="eac-cpf:control/eac-cpf:otherRecordId/text()"/></dc:identifier>
<xsl:for-each select="eac-cpf:control/eac-cpf:languageDeclaration/eac-cpf:language"><dc:language><xsl:text>ENG</xsl:text></dc:language></xsl:for-each>

<xsl:variable name="city" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:places/eac-cpf:place/eac-cpf:placeEntry[1]"/>
<xsl:variable name="community" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:places/eac-cpf:place/eac-cpf:placeEntry[2]"/>
<dc:coverage><xsl:text>North America--Canada--Simcoe--</xsl:text><xsl:value-of select="$city"/><xsl:text>--</xsl:text><xsl:value-of select="$community"/></dc:coverage> 


<xsl:for-each select="eac-cpf:control/eac-cpf:maintenanceHistory/eac-cpf:maintenanceEvent[1]">
<dc:source><xsl:value-of select="eac-cpf:maintenanceAgency" /></dc:source>
<dc:contributor><xsl:value-of select="eac-cpf:maintenanceAgent" /></dc:contributor>
</xsl:for-each>
 
<xsl:apply-templates select="eac-cpf:cpfDescription"/>
</oai-dc:dc>
</xsl:template>

<xsl:template match="eac-cpf:nameEntry">
<xsl:choose>
 <xsl:when test="@localType='aacr2'"><dc:title><xsl:call-template name="eac-cpf_name"/></dc:title></xsl:when>
</xsl:choose>
</xsl:template>

<xsl:template name="eac-cpf_name">
<xsl:variable name="aacr2_name" select="eac-cpf:part/text()"/>
<xsl:choose>
<xsl:when test="$aacr2_name">
<xsl:value-of select="eac-cpf:part"/>
</xsl:when>
</xsl:choose>
</xsl:template>
<xsl:template match="eac-cpf:chronItem">
	<xsl:choose>
	  <xsl:when test="@localType='death'">
	  	<dc:description><xsl:call-template name="eac-cpf_death_event"/></dc:description>
	  	<dc:date><xsl:call-template name="eac-cpf_dod"/></dc:date>
	  	<dc:subject><xsl:text>Death</xsl:text></dc:subject><dc:subject><xsl:text>Memoriam</xsl:text></dc:subject>  
 
      </xsl:when> 
   </xsl:choose> 
</xsl:template>
<xsl:template name="eac-cpf_death_event">
<xsl:variable name="death_event" select="eac-cpf:event/text()"/>
	<xsl:choose> 
		<xsl:when test="$death_event"><xsl:value-of select="eac-cpf:event"/></xsl:when> 
	</xsl:choose>
</xsl:template>
<xsl:template name="eac-cpf_dod">
<xsl:variable name="death_dod" select="eac-cpf:date/text()"/>
	<xsl:choose> 
		<xsl:when test="$death_dod"><xsl:value-of select="eac-cpf:date"/></xsl:when> 
	</xsl:choose>
</xsl:template>
<xsl:template match="*">
<xsl:apply-templates/>
</xsl:template>
</xsl:stylesheet>