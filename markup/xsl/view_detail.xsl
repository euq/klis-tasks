<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html" encoding="UTF-8" indent="yes" />
  <xsl:param name="param_count"/>

  <xsl:template match="//books">
    <html>
      <head>
        <title>最終課題 - 詳細</title>
      </head>
      <body>
        <div id="main">
          <h3>このタグを使っている資料</h3>
          <h5><xsl:value-of select="$param_tag"/>のタグが使われている資料一覧</h5>
          <ul>
            <xsl:apply-templates select="item/title[../keywords/keyword=$param_tag]" />
          </ul>
        </div>
      </body>
    </html>
    <xml>
      <tags>
      </tags>
    </xml>
  </xsl:template>

  <xsl:template match="title">
    <li><xsl:value-of select="." /></li>
  </xsl:template>

</xsl:stylesheet>
