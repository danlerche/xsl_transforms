<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:eac-cpf="urn:isbn:1-931666-33-4"
xmlns:oai-dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
xmlns:dc="http://purl.org/dc/elements/1.1/"
exclude-result-prefixes="eac-cpf">
<xsl:output method="xml" indent="yes" encoding="UTF-8"/>
<xsl:template match="eac-cpf:eac-cpf">
<oai-dc:dc>
<dc:identifier><xsl:value-of select="eac-cpf:control/eac-cpf:recordId/text()"/></dc:identifier>
<dc:title><xsl:value-of select="eac-cpf:cpfDescription/eac-cpf:identity/eac-cpf:nameEntry[2]/eac-cpf:part/text()"/></dc:title>
<xsl:for-each select="eac-cpf:control/eac-cpf:languageDeclaration/eac-cpf:language"><dc:language><xsl:text>ENG</xsl:text></dc:language></xsl:for-each>
<xsl:variable name="city" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:places/eac-cpf:place/eac-cpf:placeEntry[1]"/>
<xsl:variable name="community" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:places/eac-cpf:place/eac-cpf:placeEntry[2]"/>
<xsl:variable name="description" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:biogHist/eac-cpf:chronItem/eac-cpf:event"/>
<xsl:variable name="dod" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:biogHist/eac-cpf:chronItem/eac-cpf:date"/>
<xsl:variable name="subjects" select="eac-cpf:cpfDescription/eac-cpf:description/eac-cpf:biogHist/eac-cpf:chronItem/@localType"/>
<xsl:for-each select="eac-cpf:control/eac-cpf:maintenanceHistory/eac-cpf:maintenanceEvent[1]">
<dc:source><xsl:value-of select="eac-cpf:maintenanceAgency" /></dc:source>
<dc:contributor><xsl:value-of select="eac-cpf:maintenanceAgent" /></dc:contributor>
</xsl:for-each>
<xsl:choose>
  <xsl:when test="$subjects ='death'">
 <dc:date><xsl:value-of select="$dod"/></dc:date>
 <dc:description><xsl:value-of select="$description"/></dc:description>
 <xsl:choose>
    <xsl:when test="$community !=''">
        <dc:coverage><xsl:text>North America--Canada--Simcoe--</xsl:text><xsl:value-of select="$city"/><xsl:text>--</xsl:text><xsl:value-of select="$community"/></dc:coverage>
    </xsl:when>
    <xsl:otherwise>
       <dc:coverage><xsl:text>North America--Canada--Simcoe--</xsl:text><xsl:value-of select="$city"/></dc:coverage>
    </xsl:otherwise>
</xsl:choose>
 <dc:subject><xsl:text>Death</xsl:text></dc:subject><dc:subject><xsl:text>Memoriam</xsl:text></dc:subject> 
</xsl:when>
</xsl:choose>
 <xsl:apply-templates select="eac-cpf:eac-cpf"/>
</oai-dc:dc>
</xsl:template>
</xsl:stylesheet>

