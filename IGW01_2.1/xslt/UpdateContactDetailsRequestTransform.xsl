<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0"                 
       xmlns:ns1="http://www.vodafone.com/rig/internal/validateheader/v1.0" 		
       xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 		
       xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"		
       xmlns:xsd="http://www.w3.org/2001/XMLSchema"  		
       xmlns:m="http://www.vodafone.com/vf/customerPersonalInformationManagement/interface/v.2.1"		
       xmlns:m0="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMContactDetails"  		
       xmlns:m1="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMPerson"  		
       xmlns:m2="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMMarketingPreference"  		
       xmlns:m3="http://www.vodafone.com/vf/customerPersonalInformationManagement/messages/v.2.1"  		
       xmlns:m4="http://www.vodafone.com/vf/core_common/types/v.0.3/"
	   xmlns:asg_map="http://www.tibco.com/asg/mapping" xmlns:err="http://www.tibco.com/schemas/asg/error" xmlns:c="http://www.tibco.com/schemas/asg/context" xmlns:h="http://www.tibco.com/asg/protocols/http" xmlns:asg="http://www.tibco.com/asg/error"> 
	<xsl:variable name="context">
		<xsl:for-each select="/transformation/cnRequest">
			<xsl:copy-of select="document(@href)"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="cnRequestHref">
		<xsl:value-of select="/transformation/cnRequest/@href"/>
	</xsl:variable>
	<xsl:variable name="cnRequest">
		<xsl:copy-of select="document($cnRequestHref)"/>
	</xsl:variable>

	<xsl:variable name="contextHref">
		<xsl:value-of select="/transformation/context/@href"/>
	</xsl:variable>	
	<xsl:variable name="contextHrefFinal">
		<xsl:copy-of select="document($contextHref)"/>
	</xsl:variable>

	<xsl:template match="/"> 
		<ns0:UpdateContactDetailsRequest xmlns:ns0 = "http://xmlns.vodafone.co.uk/map/til/CustomerManagement/CustomerProfileManagement/CustomerPersonalInformationManagement/UpdateContactDetails"> 	
			<CRMContactDetails xmlns="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMContactDetails">
				<xsl:copy-of select="$cnRequest/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateContactDetails/m0:CRMContactDetails/*"/>
			</CRMContactDetails>
			<CRMMarketingPreference xmlns="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMMarketingPreference">
				<xsl:copy-of select="$cnRequest/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateContactDetails/m2:CRMMarketingPreference/*"/>
			</CRMMarketingPreference>
		</ns0:UpdateContactDetailsRequest> 
	</xsl:template>
</xsl:stylesheet>