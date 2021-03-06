<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:m="http://www.tibco.com/asg/mapping"
  xmlns:soap12="http://www.w3.org/2003/05/soap-envelope"
  xmlns:soap11="http://schemas.xmlsoap.org/soap/envelope/"
  xmlns:form="http://www.tibco.com/asg/functions/form"
  xmlns:c="http://www.tibco.com/schemas/asg/context"
  xmlns:h="http://www.tibco.com/asg/protocols/http"
  xmlns:k="http://www.tibco.com/asg/protocols/jms"
  xmlns:codecs="http://www.tibco.com/asg/functions/codecs"
  xmlns:fn="http://www.w3.org/2005/xpath-functions">
	<xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes" omit-xml-declaration="no"/>
	<xsl:variable name="context">
		<c:context>
			<xsl:for-each select="/transformation/context">
				<xsl:copy-of select="document(@href)/c:context/*"/>
			</xsl:for-each>
		</c:context>
	</xsl:variable>  
	<xsl:variable name="body">
		<xsl:copy-of select="codecs:base64ToText($context/c:context/c:entry[@key='asg:jmsRequest']/k:request/k:body)"/>
	</xsl:variable>
	<!-- Handling Request -->
	<xsl:variable name="CorrelationID">
		<xsl:copy-of select="$context/c:context/c:entry[@key='asg:jmsRequest']/k:request/k:JMSCorrelationID"/>
	</xsl:variable>
	<xsl:variable name="TraceID">
		<xsl:copy-of select="$context/c:context/c:entry[@key='asg:jmsRequest']/k:request/k:JMSMessageID"/>
	</xsl:variable> 
		<!-- 6Aug -->
	<xsl:variable name="Token">
		<xsl:copy-of select="concat('Bearer ', fn:normalize-space(fn:substring-before($body,'{')))"/>
	</xsl:variable> 
	<xsl:variable name="JSONRequest">
			<xsl:copy-of select="codecs:textToBase64(concat('{' , fn:substring-after($body,'{')))"/>
	</xsl:variable> 

	<xsl:template match="/">
<m:repeat> 
	<m:payload-xml>
		<m:mapping-result>
			<m:context>
				<c:context>
					<c:entry key="asg:httpRequest">
						<h:override-header name="Authorization"><xsl:value-of select="$Token"/></h:override-header>
						<h:override-header name="X-Correlation-ID"><xsl:value-of select="$CorrelationID"/></h:override-header>
						<h:override-header name="Content-Type">application/json</h:override-header>
						<h:override-header name="vf-trace-transaction-id"><xsl:value-of select="$TraceID"/></h:override-header>		
					</c:entry>
				</c:context>
			</m:context>
				<!--	WORKS -->
			<m:payload isBinary="true">
				 <xsl:value-of select="$JSONRequest"/>
			</m:payload>
	
		</m:mapping-result>
	</m:payload-xml>
</m:repeat>
	</xsl:template>
</xsl:stylesheet>