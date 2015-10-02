<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:xtoks="http://acdh.oeaw.ac.at/xtoks" exclude-result-prefixes="#all" version="2.0">

    <xsl:include href="params.xsl"/>

    <xsl:template match="node()" mode="is-copy-node is-ignore-node is-inline-node is-floating-node">
        <xsl:sequence select="false()"/>
    </xsl:template>

    <xsl:function name="xtoks:is-copy-node" as="xs:boolean">
        <xsl:param name="node" as="node()"/>
        <xsl:apply-templates select="$node" mode="is-copy-node"/>
    </xsl:function>

    <xsl:function name="xtoks:is-ignore-node" as="xs:boolean">
        <xsl:param name="node" as="node()"/>
        <xsl:apply-templates select="$node" mode="is-ignore-node"/>
    </xsl:function>

    <xsl:function name="xtoks:is-inline-node" as="xs:boolean">
        <xsl:param name="node" as="node()"/>
        <xsl:apply-templates select="$node" mode="is-inline-node"/>
    </xsl:function>

    <xsl:function name="xtoks:is-floating-node" as="xs:boolean">
        <xsl:param name="node" as="node()"/>
        <xsl:apply-templates select="$node" mode="is-floating-node"/>
    </xsl:function>

    <xsl:template name="tokenize-text">
        <xsl:analyze-string select="." regex="{$ws-regex}">
            <xsl:matching-substring>
                <xsl:if test="$preserve-ws">
                    <seg type="ws" xmlns="http://www.tei-c.org/ns/1.0">
                        <xsl:value-of select="."/>
                    </seg>
                </xsl:if>
            </xsl:matching-substring>
            <xsl:non-matching-substring>
                <xsl:analyze-string select="." regex="{$pc-regex}">
                    <xsl:matching-substring>
                        <pc xmlns="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="."/>
                        </pc>
                    </xsl:matching-substring>
                    <xsl:non-matching-substring>
                        <w xmlns="http://www.tei-c.org/ns/1.0">
                            <xsl:value-of select="."/>
                        </w>
                    </xsl:non-matching-substring>
                </xsl:analyze-string>
            </xsl:non-matching-substring>
        </xsl:analyze-string>
    </xsl:template>

</xsl:stylesheet>
