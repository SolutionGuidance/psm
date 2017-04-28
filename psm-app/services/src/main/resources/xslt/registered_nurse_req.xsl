<?xml version="1.0" encoding="UTF-8" ?>

<!-- New document created with EditiX at Tue Dec 11 14:13:32 GMT+08:00 2012 -->

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:ext="http://gov.medicaid.services.enrollment/ValidationService"
    xmlns:ext2="http://gov.medicaid.shared/Entities"
    exclude-result-prefixes="xs xdt err fn">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
    
    <xsl:template match="/">
        <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:impl="http://impl.services.screening.medicaid.gov/">
           <soapenv:Header/>
           <soapenv:Body>
              <impl:searchByLicenseNumber>
                 <arg0>
                    <xsl:variable name="fullNo" select="//ext:LicenseVerificationRequest/ext:LicenseType/ext2:LicenseNumber/text()"></xsl:variable>
                    <identifier><xsl:value-of select="substring($fullNo, 1, string-length($fullNo) - 2)"></xsl:value-of></identifier>
                    <checkDigit><xsl:value-of select="substring($fullNo, string-length($fullNo))"></xsl:value-of></checkDigit>
                    <licenseType>
                       <name>RN</name>
                    </licenseType>
                 </arg0>
              </impl:searchByLicenseNumber>
           </soapenv:Body>
        </soapenv:Envelope>
    </xsl:template>

</xsl:stylesheet>
