<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <dspace@lyncode.com>

 -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />
	
	<xsl:template match="/">
		<thesis xmlns="http://www.ndltd.org/standards/metadata/etdms/1.0/" 
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
			xsi:schemaLocation="http://www.ndltd.org/standards/metadata/etdms/1.0/ http://www.ndltd.org/standards/metadata/etdms/1.0/etdms.xsd">
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
				<title><xsl:value-of select="." /></title>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field[@name='value']">
				<creator><xsl:value-of select="." /></creator>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name!='author']/doc:element/doc:field[@name='value']">
				<contributor><xsl:value-of select="." /></contributor>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
				<subject><xsl:value-of select="." /></subject>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element/doc:field[@name='value']">
				<description><xsl:value-of select="." /></description>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
				<description><xsl:value-of select="." /></description>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element/doc:element/doc:field[@name='value']">
				<date><xsl:value-of select="substring(.,0,11)" /></date>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='type']/doc:element/doc:field[@name='value']">
				<type><xsl:value-of select="." /></type>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:element/doc:field[@name='value']">
				<identifier><xsl:value-of select="." /></identifier>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='language']/doc:element/doc:element/doc:field[@name='value']">
				<language><xsl:value-of select="." /></language>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element/doc:element/doc:field[@name='value']">
				<relation><xsl:value-of select="." /></relation>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='relation']/doc:element/doc:field[@name='value']">
				<relation><xsl:value-of select="." /></relation>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:element/doc:field[@name='value']">
				<rights><xsl:value-of select="." /></rights>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='rights']/doc:element/doc:field[@name='value']">
				<rights><xsl:value-of select="." /></rights>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='bitstreams']/doc:element[@name='bitstream']/doc:field[@name='format']">
				<format><xsl:value-of select="." /></format>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']/doc:element/doc:field[@name='value']">
				<coverage><xsl:value-of select="." /></coverage>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='coverage']/doc:element/doc:element/doc:field[@name='value']">
				<coverage><xsl:value-of select="." /></coverage>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='publisher']/doc:element/doc:element/doc:field[@name='value']">
				<publisher><xsl:value-of select="." /></publisher>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element/doc:field[@name='value']">
				<source><xsl:value-of select="." /></source>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='source']/doc:element/doc:element/doc:field[@name='value']">
				<source><xsl:value-of select="." /></source>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='bundles']/doc:element/doc:field[text()='ORIGINAL']">
				<xsl:for-each select="../doc:element[@name='bitstreams']/doc:element">
					<identifier>
						<xsl:call-template name="replace-jspui">
							<xsl:with-param name="text" select="doc:field[@name='url']/text()" />
						</xsl:call-template>
					</identifier>
					<format>
						<xsl:value-of select="doc:field[@name='format']/text()" />
					</format>
				</xsl:for-each>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='degree']/doc:element/doc:field[@name='value']">
				<degree>
					<name><xsl:value-of select="."/></name>
					<xsl:choose>
						<xsl:when test="contains(., 'Master')">
							<level>master's</level>
						</xsl:when>
						<xsl:when test="contains(., 'Maitrise')">
							<level>master's</level>
						</xsl:when>
						<xsl:when test="contains(., 'Doctor')">
							<level>doctoral</level>
						</xsl:when>
						<xsl:otherwise>
							<level>undergraduate</level>
						</xsl:otherwise>
					</xsl:choose>
					<grantor>Laurentian University of Sudbury</grantor>
				</degree>
			</xsl:for-each>
			<xsl:if test="doc:metadata/doc:element[@name='thesis']">
			<degree>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='name']/doc:element/doc:field[@name='value']">
				<name><xsl:value-of select="." /></name>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='name']/doc:element/doc:element/doc:field[@name='value']">
				<name><xsl:value-of select="." /></name>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='level']/doc:element/doc:field[@name='value']">
				<level><xsl:value-of select="." /></level>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='level']/doc:element/doc:element/doc:field[@name='value']">
				<level><xsl:value-of select="." /></level>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='discipline']/doc:element/doc:field[@name='value']">
				<discipline><xsl:value-of select="." /></discipline>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='discipline']/doc:element/doc:element/doc:field[@name='value']">
				<discipline><xsl:value-of select="." /></discipline>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='grantor']/doc:element/doc:field[@name='value']">
				<grantor><xsl:value-of select="." /></grantor>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='thesis']/doc:element[@name='grantor']/doc:element/doc:element/doc:field[@name='value']">
				<grantor><xsl:value-of select="." /></grantor>
			</xsl:for-each>
			</degree>
			</xsl:if>
		</thesis>
	</xsl:template>
  <!-- XSLT 1.0 does not have a replace() function for strings -->
  <!-- workaround from https://stackoverflow.com/questions/3067113/xslt-string-replace -->
	<xsl:template name="string-replace-all">
		<xsl:param name="text" />
		<xsl:param name="replace" />
		<xsl:param name="by" />
		<xsl:choose>
			<xsl:when test="$text = '' or $replace = ''or not($replace)" >
				<!-- Prevent this routine from hanging -->
				<xsl:value-of select="$text" />
			</xsl:when>
			<xsl:when test="contains($text, $replace)">
				<xsl:value-of select="substring-before($text,$replace)" />
				<xsl:value-of select="$by" />
				<xsl:call-template name="string-replace-all">
					<xsl:with-param name="text" select="substring-after($text,$replace)" />
					<xsl:with-param name="replace" select="$replace" />
					<xsl:with-param name="by" select="$by" />
				</xsl:call-template>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$text" />
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<xsl:template name="replace-jspui">
		<xsl:param name="text" />
		<xsl:call-template name="string-replace-all">
			<xsl:with-param name="text" select="$text" />
			<xsl:with-param name="replace" select="'/jspui/'" />
			<xsl:with-param name="by" select="'/dspace/'" />
		</xsl:call-template>
	</xsl:template>
</xsl:stylesheet>
