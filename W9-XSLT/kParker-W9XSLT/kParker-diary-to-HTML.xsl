<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xmlns:d="http://UW-LIS-diaries/ns/1.0" exclude-result-prefixes="xs xd" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p> Stylesheet to convert the a diary marked up according to the diaries.rng schema
                to HTML.</xd:p>
            <xd:p><xd:b>Created on:</xd:b> May 10, 2022</xd:p>
            <xd:p><xd:b>Author:</xd:b> elli</xd:p>

        </xd:desc>
    </xd:doc>

    <!-- line break in output file; improves human readability of xml output -->
    <!-- <xsl:strip-space elements="*"/> -->
    <xsl:variable name="newline">
        <xsl:text> 
</xsl:text>
    </xsl:variable>

    <xsl:output method="xml" encoding="UTF-8" indent="no"/>

    <xsl:template match="/">

        <!-- The following matchest the root element, and sets up the overall HTML structure. -->
        <html>
            <head>
                <title>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </title>
                <link rel="stylesheet" type="text/css" href="kParker-diaries.css"/>
            </head>

            <body>
                <h1>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:title"/>
                </h1>
                <h1>
                    <xsl:value-of select="/d:journal/d:metadata/d:sourceInfo/d:author"/>
                </h1>
                <xsl:apply-templates/>


                <div>
                    <h1>List of Names</h1>
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:name">
                                <li>
                                    <xsl:value-of select="."/>  <!-- the . here means to use the content of the selected element; in this case, <name> -->
                                </li>
                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
                <div>
                    <h2><i>List of Roles</i></h2> <!-- # 5 ROLES -->
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:name//@role">
                                <li>
                                   <i><xsl:value-of select="."/></i>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
                <div>
                    <h1>List of Places</h1> <!-- # 4 PLACES -->
                    <p>
                        <ol>
                            <xsl:for-each select="//d:entries//d:place">
                                <li>
                                    <xsl:value-of select="."/>
                                </li>
                            </xsl:for-each>
                        </ol>
                    </p>
                </div>
        </body>
        </html>

    </xsl:template>


    <!-- **********************************************************************  Metadata elements ********************************************************************** -->
    <xsl:template match="d:journal">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:metadata">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:sourceInfo"/>

    <xsl:template match="d:revisions"/>



    <!--   ******************************************************************** Diary Entries Strcture ******************************************************************** -->


    <xsl:template match="d:entries"> 
       
        <xsl:apply-templates/>
       
    </xsl:template>

    <xsl:template match="d:entry"> 
        <div>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="d:p"> 
        <p>
            [<xsl:value-of select="@n"/>] <!-- # 1 DISPLAY PARAGRAPH #s -->
            <xsl:apply-templates/>
        </p>
    </xsl:template>
   

    <!--   ******************************************************* Phrase level elements and Milestone Elements *************************************************** -->

    <xsl:template match="d:entry/d:date">
        <h2>
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="d:date">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:name"> 
        <span class="name"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="d:place"> 
        <span class="place"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="d:alternates"> 
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="d:original | d:abbr"> 
        <span class="original"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="d:corr | d:expan"> 
        <span class="modern"><xsl:apply-templates/></span>
    </xsl:template>
    
    <xsl:template match="d:del">
        <span class="del"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="d:pb"> [<xsl:value-of select="@n"/>] </xsl:template>
    
    <xsl:template match="d:q"> "<xsl:apply-templates/>" </xsl:template> <!-- # 2 QUOTE ELEMENT -->
    
    <xsl:template match="d:cite"><a href="{@ref}"><xsl:apply-templates></xsl:apply-templates></a></xsl:template> <!-- # 3 CITATION LINKS -->
   
    

</xsl:stylesheet>
