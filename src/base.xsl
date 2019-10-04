<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="bs:roster/bs:forces">
		<html>
			<head>
				<style>
                    <!-- inject:../build/style.css -->
					<!-- contents of html partials will be injected here -->
					<!-- endinject -->
				</style>
			</head>
			<body>
				<xsl:call-template name="roster"/>
				<xsl:apply-templates select="bs:force" mode="cards"/>
			</body>
		</html>
	</xsl:template>

	<!-- inject:roster.xsl -->
	<!-- contents of html partials will be injected here -->
	<!-- endinject -->
	
	<xsl:template match="bs:force" mode="roster">
		<tr>
			<td></td>
			<td><xsl:value-of select="@name"/></td>
			<td></td>
			<td></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="bs:force" mode="cards">
		<!-- Render cards template -->
		<xsl:apply-templates select="bs:selections/bs:selection[@type='model' or @type='unit']"/>
	</xsl:template>
	
	<!-- inject:card.xsl -->
    <!-- contents of html partials will be injected here -->
    <!-- endinject -->
	
    <xsl:template match="bs:characteristics/bs:characteristic" mode="header">
        <th>
            <xsl:value-of select="@name"/>
        </th>
    </xsl:template>
    <xsl:template match="bs:characteristics/bs:characteristic" mode="body">
        <td>
            <xsl:value-of select="."/>    
        </td>
    </xsl:template>
	
</xsl:stylesheet>