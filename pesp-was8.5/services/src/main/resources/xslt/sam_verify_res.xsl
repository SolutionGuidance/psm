<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Dec 11 14:13:32 GMT+08:00 2012 -->

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:ext="http://impl.services.screening.medicaid.gov/"
    exclude-result-prefixes="xs xdt err fn">

    <xsl:output method="text" encoding="UTF-8"/>
    
    <xsl:template match="/">
                    <xsl:value-of select="//ext:verifyResponse/return"></xsl:value-of>
    </xsl:template>
</xsl:stylesheet>