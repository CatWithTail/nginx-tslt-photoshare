<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="/">
    <xsl:variable name="myfolder">
      <xsl:value-of select="$path"/>
    </xsl:variable>

    <html>
      <head>
        <title>
          Photos
        </title>
      </head>
    <body>
      <h3><xsl:value-of select="$myfolder"/></h3>
        <xsl:for-each select="list/*">
            <xsl:variable name="name">
                <xsl:value-of select="."/>
            </xsl:variable>
            <xsl:variable name="mainname"  select="substring-before($name, '.800x800.jpg')" />
            <xsl:variable name="rawname"  select="substring-before($name, '.jpg.800x800.jpg')" />

            <xsl:if test="contains($name, '.jpg')">
                <p><img src="{$name}" alt="{$name}" /></p>
                <p><a href="/getjpg{$myfolder}{$mainname}"><xsl:value-of select="substring-before($name, '.800x800.jpg')"/></a> ------ 
                <a href="/getraw{$myfolder}{$rawname}"><xsl:value-of select="substring-before($name, '.jpg.800x800.jpg')"/></a></p>

            </xsl:if>
            <xsl:if test="not(contains($name, '.jpg'))">
                <p><a href="{$name}"><xsl:value-of select="."/></a></p>
            </xsl:if>
        </xsl:for-each>
    </body>
    </html>
    </xsl:template>
</xsl:stylesheet>
