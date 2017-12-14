<?xml version="1.0" encoding="UTF-8" ?>
<!-- 


    The contents of this file are subject to the license and copyright
    detailed in the LICENSE and NOTICE files at the root of the source
    tree and available online at

    http://www.dspace.org/license/
	Developed by DSpace @ Lyncode <dspace@lyncode.com>
	
	> http://www.loc.gov/marc/bibliographic/ecbdlist.html

 -->
<xsl:stylesheet 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:doc="http://www.lyncode.com/xoai"
	version="1.0">
	<xsl:output omit-xml-declaration="yes" method="xml" indent="yes" />
	
	<xsl:template match="/">
		<record xmlns="http://www.loc.gov/MARC21/slim" 
			xmlns:dcterms="http://purl.org/dc/terms/"
			xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
			xsi:schemaLocation="http://www.loc.gov/MARC21/slim http://www.loc.gov/standards/marcxml/schema/MARC21slim.xsd">
			<leader>00925nam a22002775a 4500</leader>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:element/doc:field[@name='value']">
			<datafield ind1="8" ind2=" " tag="024">
				<subfield code="a"><xsl:value-of select="." /></subfield>
			</datafield>
			</xsl:for-each>
			<datafield ind2=" " ind1=" " tag="042">
				<subfield code="a">dc</subfield>
			</datafield>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='contributor']/doc:element[@name='author']/doc:element/doc:field[@name='value']">
			<datafield ind2=" " ind1="1" tag="100">
				<subfield code="a"><xsl:value-of select="." /></subfield>
				<subfield code="4">http://id.loc.gov/vocabulary/relators/aut</subfield>
			</datafield>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='title']/doc:element/doc:field[@name='value']">
			<datafield ind2="0" ind1="1" tag="245">
				<subfield code="a"><xsl:value-of select="." /></subfield>
			</datafield>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='date']/doc:element[@name='issued']/doc:element/doc:field[@name='value']">
			<datafield ind2="1" ind1=" " tag="264">
                <subfield code="a"><xsl:text>Sudbury, Ont. :</xsl:text></subfield>
                <subfield code="b"><xsl:text>Laurentian University, Faculty of Graduate Studies,</xsl:text></subfield>
				<subfield code="c"><xsl:value-of select="." /></subfield>
			</datafield>
			</xsl:for-each>
			<datafield ind2="0" ind1=" " tag="490">
                <subfield code="a"><xsl:text>Canadian theses = Théses canadiennes</xsl:text></subfield>
			</datafield>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='degree']/doc:element/doc:field[@name='value']">
                <datafield ind2=" " ind1=" " tag="502">
                    <subfield code="a"><xsl:value-of select="." /></subfield>
                </datafield>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='description']/doc:element[@name='abstract']/doc:element/doc:field[@name='value']">
			<datafield ind2=" " ind1=" " tag="520">
				<subfield code="a"><xsl:value-of select="." /></subfield>
			</datafield>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='subject']/doc:element/doc:field[@name='value']">
			<datafield tag="653" ind2=" " ind1=" " >
				<subfield code="a"><xsl:value-of select="." /></subfield>
			</datafield>
			</xsl:for-each>
			<xsl:for-each select="doc:metadata/doc:element[@name='dc']/doc:element[@name='identifier']/doc:element/doc:element/doc:field[@name='value']">
                <datafield tag="856" ind1="4" ind2="0" >
                    <subfield code="u"><xsl:value-of select="." /></subfield>
                    <subfield code="y"><xsl:text>Available online / disponible en ligne</xsl:text></subfield>
                    <subfield code="9"><xsl:text>LUSYS</xsl:text></subfield>
                </datafield>
			</xsl:for-each>
		</record>
	</xsl:template>
</xsl:stylesheet>
