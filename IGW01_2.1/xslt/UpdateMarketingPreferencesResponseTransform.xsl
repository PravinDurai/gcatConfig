<?xml version="1.0" encoding="ISO-8859-1"?> 
<xsl:stylesheet version="1.0"                 
      xmlns:ns1="http://www.vodafone.com/rig/internal/validateheader/v1.0" 		
      xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 		
      xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" 
      xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
      xmlns:xsd="http://www.w3.org/2001/XMLSchema"
      xmlns:m="http://www.vodafone.com/vf/customerPersonalInformationManagement/interface/v.2.1"
      xmlns:m0="http://www.vodafone.com/vf/customerPersonalInformationManagement/messages/v.2.1" 
      xmlns:m1="http://xmlns.vodafone.co.uk/map/til/Common/CommonObjects/CRMMarketingPreference" 
      xmlns:m2="http://www.vodafone.com/vf/core_common/types/v.0.3/"
      xmlns:ns0="http://xmlns.vodafone.co.uk/map/til/CustomerManagement/CustomerProfileManagement/CustomerPersonalInformationManagement/UpdateMarketingPreferences" 
      xmlns:vod="http://xmlns.vodafone.co.uk/map/til/Common/SimpleTypes" 
      xmlns:rs="http://xmlns.vodafone.co.uk/map/til/Common/ResultStatus"
	  xmlns:asg_map="http://www.tibco.com/asg/mapping" xmlns:err="http://www.tibco.com/schemas/asg/error" xmlns:c="http://www.tibco.com/schemas/asg/context" xmlns:h="http://www.tibco.com/asg/protocols/http" xmlns:asg="http://www.tibco.com/asg/error"
	  xmlns:v12="http://www.vodafone.com/vf/customerPersonalInformationManagement/messages/v.2.1"
	  xmlns:v2="http://www.vodafone.com/vf/core_common/types/v.0.3/"
	  xmlns:v="http://www.vodafone.com/vf/subscriptionLifecycleManagement/interface/v.2.1" xmlns:ns="http://xmlns.vodafone.co.uk/map/til/Common/ResultStatus"> 

	<xsl:variable name="sbResponse">
		<xsl:for-each select="/transformation/sbResponse">
			<xsl:copy-of select="document(@href)"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="context">
		<xsl:for-each select="/transformation/cnRequest">
			<xsl:copy-of select="document(@href)"/>
		</xsl:for-each>
	</xsl:variable>

	<xsl:variable name="Severity">
		<xsl:value-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:severity"/>
	</xsl:variable>
	<xsl:variable name="ErrorCode">
		<xsl:value-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:code"/>
	</xsl:variable>
	<xsl:variable name="Message">
		<xsl:value-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:message"/>
	</xsl:variable>
	<xsl:variable name="Component">
		<xsl:choose>
			<xsl:when test="string-length($sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:component) &gt; '0'">
				<xsl:value-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:component"/>
			</xsl:when>
			<xsl:otherwise>BW</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="Operation">
		<xsl:value-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:operation"/>
	</xsl:variable>
	<xsl:variable name="ExtractErrorCode">
		<xsl:value-of select="substring-after(substring-after($ErrorCode, '-'), '-')"/>
	</xsl:variable>
	<xsl:variable name="ConcatErrorCode">
		<xsl:value-of select="concat('SVC9',$ExtractErrorCode)"/>
	</xsl:variable>

	<xsl:template match="/">
		<xsl:choose>
			<xsl:when test="$sbResponse/ns0:UpdateMarketingPreferencesResponse/ns:ResultStatus/ns:severity='S'">
				<SOAP-ENV:Envelope>
					<SOAP-ENV:Body>
						<v:UpdateMarketingPreferencesResponse>
							<xsl:copy-of select="$sbResponse/ns0:UpdateMarketingPreferencesResponse/rs:ResultStatus"/>
							<v12:traceIdentifier>
								<v2:applicationID>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:applicationID"/>
								</v2:applicationID>
								<v2:serviceID>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:serviceID"/>
								</v2:serviceID>
								<v2:serviceInterfaceVersion>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:serviceInterfaceVersion"/>
								</v2:serviceInterfaceVersion>
								<v2:timestamp>
									<xsl:value-of select="current-dateTime()"/>
								</v2:timestamp>
								<v2:referenceID>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:referenceID"/>
								</v2:referenceID>
								<v2:correlationID>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:correlationID"/>
								</v2:correlationID>
								<v2:identityID>
									<xsl:value-of select="$context/SOAP-ENV:Envelope/SOAP-ENV:Body/m:UpdateMarketingPreferences/v12:traceIdentifier/v2:identityID"/>
								</v2:identityID>
							</v12:traceIdentifier>
						</v:UpdateMarketingPreferencesResponse>
					</SOAP-ENV:Body>
				</SOAP-ENV:Envelope>
			</xsl:when>
			<xsl:otherwise>
				<SOAP-ENV:Envelope xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/">
					<SOAP-ENV:Body>
						<SOAP-ENV:Fault>
							<faultcode>Client</faultcode>
							<faultstring>
								<xsl:value-of select="$ConcatErrorCode"/>
							</faultstring>
							<faultactor>null</faultactor>
							<detail>
								<v:UpdateMarketingPreferencesserviceException xmlns:v="http://www.vodafone.com/vf/customerInterfaceManagement/interface/v.1.1">
									<ns1:messageId xmlns:ns1="http://www.csapi.org/schema/parlayx/common/v3_1">
										<xsl:value-of select="$ConcatErrorCode"/>
									</ns1:messageId>
									<ns1:text xmlns:ns1="http://www.csapi.org/schema/parlayx/common/v3_1">A service error occurred. Error code is %1</ns1:text>
									<ns1:variables xmlns:ns1="http://www.csapi.org/schema/parlayx/common/v3_1">
										<xsl:value-of select="$ErrorCode"/>|severity - E|message - <xsl:value-of select="$Message"/>|operation - <xsl:value-of select="$Operation"/>|component - <xsl:value-of select="$Component"/>|||</ns1:variables>
								</v:UpdateMarketingPreferencesserviceException>
							</detail>
						</SOAP-ENV:Fault>
					</SOAP-ENV:Body>
				</SOAP-ENV:Envelope>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>