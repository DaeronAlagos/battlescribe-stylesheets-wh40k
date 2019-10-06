<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
                xmlns:bs="http://www.battlescribe.net/schema/rosterSchema" 
                xmlns:exslt="http://exslt.org/common" 
                extension-element-prefixes="exslt">
    <xsl:output method="html" indent="yes"/>

	<xsl:template match="bs:roster/bs:forces">
		<html>
			<head>
				<style>
                    <!-- inject:../build/style.css -->
					section {
  margin-bottom: 0.5cm; }
  section.roster-footer {
    display: flex; }
  section > div {
    flex-basis: 50%; }
    section > div.warlord {
      margin-right: 0.5cm; }
    section > div.points-total {
      margin-left: 0.5cm; }

table.roster {
  width: 100%;
  border: 1px solid black; }
  table.roster th {
    background-color: black;
    color: white;
    text-transform: uppercase; }
    table.roster th.left-align {
      text-align: left; }
  table.roster th, table.roster td {
    border: 1px solid black;
    padding: 0 0.1cm; }

.card {
  width: 15cm;
  min-height: 7cm;
  background-color: #cccccc; }

table.unit, table.weapon {
  width: 100%;
  font-size: 0.8em; }

					<!-- endinject -->
				</style>
			</head>
			<body>
				<xsl:call-template name="roster"/>
				<xsl:apply-templates select="bs:force" mode="cards"/>
			</body>
		</html>
	</xsl:template>

	<!-- inject:roster.xsl -->
	<xsl:template name="roster">
    <section class="roster-header">
        <table class="roster" cellspacing="0">
            <tr>
                <th colspan="2">Army Roster</th>
            </tr>
            <tr>
                <td>Player Name:</td>
                <td>Army Faction: <xsl:value-of select="bs:force/@catalogueName"/></td>
            </tr>
            <tr>
                <td>Army Name</td>
                <td>Warlord</td>
            </tr>
        </table>
    </section>
    <section class="roster-body">
        <table class="roster" cellspacing="0">
            <tr>
                <th class="left-align">Detachment Name</th>
                <th class="left-align">Type</th>
                <th>CPS</th>
                <th>Points</th>
            </tr>
            <xsl:apply-templates select="bs:force" mode="roster"/>
        </table>
    </section>
    <section class="roster-footer">
        <div class="warlord">
            <table class="roster" cellspacing="0">
                <tr>
                    <th>Warlord Trait</th>
                </tr>
                <tr>
                    <td>Fill in at set-up:</td>
                </tr>
            </table>
        </div>
        <div class="points-total">
            <table class="roster" cellspacing="0">
                <tr>
                    <th>Total Command Points</th>
                    <td></td>
                </tr>
                <tr>
                    <th>Reinforcement Points</th>
                    <td></td>
                </tr>
                <tr>
                    <th>TOTAL POINTS</th>
                    <td><xsl:value-of select="../bs:costs/bs:cost[@name='pts']/@value"/></td>
                </tr>
            </table>
        </div>
    </section>

</xsl:template>
	<!-- endinject -->
	
	<xsl:template match="bs:force" mode="roster">
		<tr>
			<td></td>
			<td><xsl:value-of select="@name"/></td>
			<td></td>
			<td></td>
		</tr>
	</xsl:template>
	
	<xsl:template match="bs:force" mode="cards">
		<!-- Render cards template -->
		<xsl:apply-templates select="bs:selections/bs:selection[@type='model' or @type='unit']"/>
	</xsl:template>
	
	<!-- inject:card.xsl -->
    <xsl:template match="bs:selections/bs:selection[@type='model' or @type='unit']">
		<div class="card">
			<div><xsl:value-of select="@name"/></div>
			<div>
				<table class="unit">
					<tr>
		                <th>
		                    Name
		                </th>
		                <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Unit']" mode="header"/>
		                <xsl:apply-templates select="bs:selections/bs:selection[@type='model']/bs:profiles/bs:profile[@typeName='Unit']" mode="header"/>
		            </tr>
		            <tr>
		                <td>
		                	<xsl:choose>
		                		<xsl:when test="bs:selections/bs:selection[@type='model']">
		                			<xsl:value-of select="bs:selections/bs:selection[@type='model']/@name"/>
		                		</xsl:when>
		                		<xsl:otherwise>
		                			<xsl:value-of select="@name"/>
		                		</xsl:otherwise>
		                	</xsl:choose>
		                </td>
		                <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Unit']" mode="body"/>
		                <xsl:apply-templates select="bs:selections/bs:selection[@type='model']/bs:profiles/bs:profile[@typeName='Unit']" mode="body"/>
		            </tr>
				</table>
			</div>
			<div>
				<table class="weapon">
					<xsl:variable name="weapons" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Weapon']"/>
					<xsl:for-each select="$weapons[1]">
                        <th>
                            <xsl:value-of select="@typeName"/>
                        </th>
                        <xsl:apply-templates mode="header"/>                    
                    </xsl:for-each>
					<xsl:for-each select="$weapons">
						<tr>
	                        <td>
	                            <xsl:value-of select="@name"/>
	                        </td>
	                        <xsl:apply-templates mode="body"/>                    
	                    </tr>
					</xsl:for-each>
					
				</table>
			</div>
			<div>
				<table class="abilities">
					<xsl:variable name="abilities" select="bs:rules/bs:rule"/>
                    <tr>
                    	<td>
                    		Abilities
                    	</td>
            			<xsl:for-each select="$abilities">
	                        <td>
	                            <xsl:value-of select="@name"/>; 
	                        </td>
						</xsl:for-each>
                    </tr>
				</table>
			</div>
			<div>
				<table class="factionkw">
					<xsl:variable name="factionkw" select="bs:categories/bs:category[@primary='false' and contains(@name, 'Faction')]"/>
					<tr>
						<td>
							Faction Keywords
						</td>
						<xsl:for-each select="$factionkw">
							<td>
								<xsl:value-of select="@name"/>
							</td>
						</xsl:for-each>
					</tr>
				</table>
			</div>
			<div>
				<table>
					<xsl:variable name="kw" select="bs:categories/bs:category[@primary='false' and not(contains(@name, 'Faction'))]"/>
					<tr>
						<td>
							Keywords
						</td>
						<xsl:for-each select="$kw">
							<td>
								<xsl:value-of select="@name"/>
							</td>
						</xsl:for-each>
					</tr>
				</table>
			</div>
			<div></div>
		</div>
	</xsl:template>
    <!-- endinject -->
	
    <xsl:template match="bs:characteristics/bs:characteristic" mode="header">
        <th>
            <xsl:value-of select="@name"/>
        </th>
    </xsl:template>
    <xsl:template match="bs:characteristics/bs:characteristic" mode="body">
        <td>
            <xsl:value-of select="."/>    
        </td>
    </xsl:template>
	
</xsl:stylesheet>