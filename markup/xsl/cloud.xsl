<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  <xsl:param name="param_count"/>
  <xsl:template match="/">
    <html>
      <head>
        <title>最終課題</title>
        <link href="./css/import.css" rel="stylesheet" type="text/css" media="all" />
      </head>
      <body>
        <div id="main">
          <h3>タグクラウドを作りましょう</h3>
          <h5><xsl:value-of select="$param_count"/>回以上用いられたタグを使うよ</h5>
          <h4>タグ数: <xsl:value-of select="count(xml/tags/tag)" /></h4>
          <ul class="tagSearch01">
            <xsl:apply-templates match="xml/tags" />
          </ul>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="tags">
    <xsl:for-each select="tag">
      <!-- <xsl:sort select="count" data-type="number" order="descending"/> -->
      <xsl:choose>
        <!-- &gt; = < -->
        <!-- &lt; = > -->
        <xsl:when test="(count &gt; 10) and (count &lt;= 15)">
          <li class="tagRank10">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 15) and (count &lt;= 20)">
          <li class="tagRank9">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 20) and (count &lt;= 25)">
          <li class="tagRank8">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 25) and (count &lt;= 30)">
          <li class="tagRank7">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 30) and (count &lt; 40)">
          <li class="tagRank6">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 40) and (count &lt; 50)">
          <li class="tagRank5">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 50) and (count &lt; 70)">
          <li class="tagRank4">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 70) and (count &lt; 100)">
          <li class="tagRank3">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 100) and (count &lt; 130)">
          <li class="tagRank2">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
        <xsl:when test="(count &gt; 130)">
          <li class="tagRank1">
            <xsl:element name="a">
              <xsl:attribute name="href">
                detail.cgi?tag=<xsl:value-of select="name"/>
              </xsl:attribute>
              <xsl:value-of select="name"/>
            </xsl:element>
          </li>
        </xsl:when>
      </xsl:choose>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
