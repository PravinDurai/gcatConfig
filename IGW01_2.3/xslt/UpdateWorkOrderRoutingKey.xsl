<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
   xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
   xmlns:ns="http://xmlns.vodafone.co.uk/map/til/wsdl/Common/Header"
   xmlns:v1="http://group.vodafone.com/contract/vho/header/v1" 
   exclude-result-prefixes="xs v1 ns xsi SOAP-ENV">
	<xsl:strip-space elements="*"/>
	<xsl:output omit-xml-declaration="yes" indent="yes"/>
	<xsl:variable name="nbRequest">
		<xsl:for-each select="/transformation/nbRequest">
			<xsl:copy-of select="document(@href)"/>
		</xsl:for-each>
	</xsl:variable>
	<xsl:variable name="Country">
		<xsl:choose>
			<xsl:when test="exists($nbRequest/SOAP-ENV:Envelope/SOAP-ENV:Header/ns:Header/ns:Property[ns:name='Country']/ns:value)">
				<xsl:value-of select="$nbRequest/SOAP-ENV:Envelope/SOAP-ENV:Header/ns:Header/ns:Property[ns:name='Country']/ns:value"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="Target">
		<xsl:choose>
			<xsl:when test="$Country='UK'">
				<xsl:value-of select="&quot;TIL&quot;"/>
			</xsl:when>
			<xsl:otherwise/>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="RoutingKey">
		<xsl:choose>
			<xsl:when test="$Target='TIL'">
				<RoutingKey>TIL</RoutingKey>
			</xsl:when>
			<xsl:otherwise>Undefined</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:template match="/">
		<output>
			<routingKey>
				<xsl:value-of select="$RoutingKey"/>
			</routingKey>
		</output>
	</xsl:template>
</xsl:stylesheet>
