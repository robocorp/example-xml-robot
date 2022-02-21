<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="@*|node()">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()" />
    </xsl:copy>
  </xsl:template>
  <xsl:template match="robots">
    <humans>
      <xsl:apply-templates select="@*|node()" />
    </humans>
  </xsl:template>
  <xsl:template match="robot">
    <human>
      <xsl:apply-templates select="@*|node()" />
    </human>
  </xsl:template>
</xsl:stylesheet>
