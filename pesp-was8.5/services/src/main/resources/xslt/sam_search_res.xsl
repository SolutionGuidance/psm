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
                <ns2:SAMVerificationResponse xmlns:ns2="http://gov.medicaid.services.enrollment/ValidationService" xmlns="http://gov.medicaid.shared/Entities" xmlns:ns3="http://gov.medicaid.process/EnrollmentProcess">
                    <ns2:Output>
                        <Status>
                            <StatusCode>SUCCESS</StatusCode>
                        </Status>
                        <SearchResults>
                            <xsl:for-each select="//ext:doSearchResponse/return">
                            <SearchResultItem>
                                <ColumnData>
                                    <NameValuePair>
                                        <Name>Provider Name</Name>
                                        <Value><xsl:value-of select="name/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Exclusion Type</Name>
                                        <Value><xsl:value-of select="exclusionType/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <NameValuePair>
                                        <Name>Classification</Name>
                                        <Value><xsl:value-of select="classification/text()"></xsl:value-of></Value>
                                    </NameValuePair>
                                    <xsl:for-each select="actions">
                                    	<NameValuePair>
	                                        <Name>Action Date</Name>
	                                        <Value><xsl:value-of select="actionDate/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>Agency Component</Name>
	                                        <Value><xsl:value-of select="agencyComponent/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>CT Code</Name>
	                                        <Value><xsl:value-of select="ctCode/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>Term Type</Name>
	                                        <Value><xsl:value-of select="termType/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    </xsl:for-each>
                                    <xsl:for-each select="addresses">
                                    	<NameValuePair>
	                                        <Name>Street</Name>
	                                        <Value><xsl:value-of select="street1/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>City</Name>
	                                        <Value><xsl:value-of select="city/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>State</Name>
	                                        <Value><xsl:value-of select="state/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>Zip</Name>
	                                        <Value><xsl:value-of select="zip/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>Duns</Name>
	                                        <Value><xsl:value-of select="duns/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    </xsl:for-each>
                                     <xsl:for-each select="references">
                                    	<NameValuePair>
	                                        <Name>Reference Name</Name>
	                                        <Value><xsl:value-of select="name/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    	<NameValuePair>
	                                        <Name>Reference Type</Name>
	                                        <Value><xsl:value-of select="type/text()"></xsl:value-of></Value>
                                    	</NameValuePair>
                                    </xsl:for-each>
                                </ColumnData>
                            </SearchResultItem>
                            </xsl:for-each>
                        </SearchResults>
                    </ns2:Output>
                </ns2:SAMVerificationResponse>
    </xsl:template>
</xsl:stylesheet>