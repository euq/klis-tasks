<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="xml" encoding="UTF-8" indent="yes" />
  <xsl:param name="param_count"/>

  <xsl:template match="//books">
    <xml>
      <tags>
        <xsl:apply-templates select="item/keywords/keyword[not(.=preceding::keyword)]" />
      </tags>
    </xml>
  </xsl:template>

  <xsl:template match="keyword">
    <xsl:call-template name="count_tag">
      <xsl:with-param name="tag" select="."></xsl:with-param>
    </xsl:call-template>
  </xsl:template>

  <!-- 2回以上使われているタグを抽出する -->
  <xsl:template name="count_tag">
    <xsl:param name="tag" />
    <xsl:if test="count(//books/item/keywords/keyword[.=$tag]) &gt; $param_count">
      <tag>
        <name><xsl:value-of select="$tag" /></name>
        <count><xsl:value-of select="count(//books/item/keywords/keyword[.=$tag])"/></count>
      </tag>
    </xsl:if>
  </xsl:template>

</xsl:stylesheet>
