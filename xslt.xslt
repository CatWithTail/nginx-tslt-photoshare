<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">

<!--    <xsl:param name="path"/>
    <xsl:variable name="path">
       <xsl:with-param name="path" select="$path" />
    </xsl:variable>

    <xsl:variable name="path">
      <xsl:value-of select="."/>
    </xsl:variable>
-->

    <html>
      <head>
        <title>
          Photos
        </title>
      </head>
    <body>
      <h3>TST</h3>
        <xsl:for-each select="list/*">
            <xsl:variable name="name">
                <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:variable name="mainname"  select="substring-before($name, '.800x800.jpg')" />
            <xsl:if test="contains($name, '.jpg')">
                <p><img src="{$name}" alt="{$name}" /></p>
                <p><a href="/getjpg/{$mainname}"><xsl:value-of select="substring-before($name, '.800x800.jpg')"/></a></p>
            </xsl:if>
            <xsl:if test="not(contains($name, '.jpg'))">
                <p><a href="{$name}"><xsl:value-of select="."/></a></p>
            </xsl:if>
        </xsl:for-each>
    </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
