<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
    <html>
      <head>
        <title>
          filedir
        </title>
      </head>
    <body>
      <h3>Photos</h3>
        <xsl:for-each select="list/*">
            <xsl:variable name="name">
                <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:if test="contains($name, '.jpg')">
                <p><a href="{$name}"><xsl:value-of select="."/></a></p>
            </xsl:if>
        </xsl:for-each>
    </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
