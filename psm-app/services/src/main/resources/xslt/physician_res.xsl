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

    <xsl:output method="xml" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    
    <xsl:template match="/">
                <ns2:LicenseVerificationResponse xmlns:ns2="http://gov.medicaid.services.enrollment/ValidationService" xmlns="http://gov.medicaid.shared/Entities" xmlns:ns3="http://gov.medicaid.process/EnrollmentProcess">
                    <ns2:Output>
                        <Status>
                            <StatusCode>SUCCESS</StatusCode>
                        </Status>
                        <SearchResults>
                            <xsl:for-each select="//ext:searchByNameResponse/return/items">
                            <SearchResultItem>
                                <ColumnData>
                                    <NameValuePair>
                                        <Name>Provider Name</Name>
                                        <Value><xsl:value-of select="profile/user/firstName/text()"></xsl:value-of><xsl:if test="string(profile/user/middleName)"><xsl:text> </xsl:text><xsl:value-of select="profile/user/middleName/text()"></xsl:value-of></xsl:if><xsl:text> </xsl:text><xsl:value-of select="profile/user/lastName/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>License Number</Name>
                                        <Value><xsl:value-of select="licenseNumber/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Issue Date</Name>
                                        <Value><xsl:value-of select="originalIssueDate/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Expire Date</Name>
                                        <Value><xsl:value-of select="expireDate/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>License Status</Name>
                                        <Value><xsl:value-of select="status/name/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                </ColumnData>
                            </SearchResultItem>
                            </xsl:for-each>
                        </SearchResults>
                    </ns2:Output>
                </ns2:LicenseVerificationResponse>
    </xsl:template>
</xsl:stylesheet>