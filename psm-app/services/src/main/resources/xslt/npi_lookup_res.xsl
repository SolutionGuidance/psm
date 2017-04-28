<?xml version="1.0" encoding="UTF-8" ?>

<xsl:stylesheet version="2.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:xdt="http://www.w3.org/2005/xpath-datatypes"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:ext="http://impl.services.screening.medicaid.gov/"
    exclude-result-prefixes="xs xdt err fn">

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    
    <xsl:template match="/">
                <ns2:NPIVerificationResponse xmlns:ns2="http://gov.medicaid.services.enrollment/ValidationService" xmlns="http://gov.medicaid.shared/Entities" xmlns:ns3="http://gov.medicaid.process/EnrollmentProcess">
                    <ns2:Output>
                        <Status>
                            <StatusCode>SUCCESS</StatusCode>
                        </Status>
                        <SearchResults>
                            <xsl:for-each select="//ext:getNPINumberResponse/return">
                            <SearchResultItem>
                                <ColumnData>
                                	<NameValuePair>
                                        <Name>Prefix</Name>
                                        <Value><xsl:value-of select="prefix/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>First Names</Name>
                                        <Value><xsl:value-of select="firstNames/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Last Name</Name>
                                        <Value><xsl:value-of select="lastName/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>NPI</Name>
                                        <Value><xsl:value-of select="npi/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>State</Name>
                                        <Value><xsl:value-of select="state/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Zip</Name>
                                        <Value><xsl:value-of select="zip/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                </ColumnData>
                            </SearchResultItem>
                            </xsl:for-each>
                        </SearchResults>
                    </ns2:Output>
                </ns2:NPIVerificationResponse>
    </xsl:template>
</xsl:stylesheet>