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
    flex-basis: 50%;
    min-height: 3cm; }
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
  min-height: 7.5cm;
  background-color: #8a8a8a;
  border: 1px solid #2e2e2e;
  border-radius: 0.4em; }
  .card .card-header {
    color: #eeeeee;
    background-color: #1A2B1B;
    border-top-left-radius: 0.4em;
    border-top-right-radius: 0.4em;
    text-align: center;
    text-transform: uppercase;
    padding: 0.2cm; }
  .card .wound-track {
    height: 2.5cm;
    width: 6cm;
    float: right;
    z-index: 1;
    position: absolute;
    margin-left: 9.5cm;
    background-color: white;
    border: 1px solid #2e2e2e; }

table.unit, table.weapon {
  width: 100%;
  font-size: 0.8em;
  border-collapse: collapse; }
  table.unit tr, table.weapon tr {
    background-color: #cccccc; }
    table.unit tr:nth-child(odd), table.weapon tr:nth-child(odd) {
      background-color: #AFB7A4; }
    table.unit tr::nth-child(even), table.weapon tr::nth-child(even) {
      background-color: #cccccc; }
  table.unit th, table.weapon th {
    background-color: #748A4E; }
  table.unit th:first-child, table.unit td:first-child, table.weapon th:first-child, table.weapon td:first-child {
    padding: 0.1cm;
    min-width: 2cm;
    width: 2cm;
    text-align: left; }
  table.unit th:last-child, table.unit td:last-child, table.weapon th:last-child, table.weapon td:last-child {
    min-width: 6cm; }

table.unit th, table.unit td {
  width: 1.44444cm;
  text-align: center; }

table.weapon th, table.weapon td {
  width: 2.16667cm;
  text-align: center; }

@media print {
  .card {
    float: left;
    page-break-inside: avoid; } }

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
			<div class="wound-track"></div>
			<div class="card-header">
				<xsl:value-of select="@name"/>
			</div>
			<div class="card-body">
				<table class="unit" cellspacing="0">
					<tr>
		                <th>
		                    Name
		                </th>
		                <xsl:apply-templates select="bs:profiles/bs:profile[@typeName='Unit']" mode="header"/>
		                <xsl:apply-templates select="bs:selections/bs:selection[@type='model']/bs:profiles/bs:profile[@typeName='Unit']" mode="header"/>
										<th></th>
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
										<td></td>
		            </tr>
				</table>
			</div>
			<div class="card-body">
				<table class="weapon" cellspacing="0">
					<xsl:variable name="weapons" select="bs:selections/bs:selection/bs:profiles/bs:profile[@typeName='Weapon']"/>
					<xsl:for-each select="$weapons[1]">
                        <th>
                            <xsl:value-of select="@typeName"/>
                        </th>
                        <xsl:apply-templates mode="header"/>    
												<th></th>                
                    </xsl:for-each>
					<xsl:for-each select="$weapons">
						<tr>
	                        <td>
	                            <xsl:value-of select="@name"/>
	                        </td>
	                        <xsl:apply-templates mode="body"/>  
													<td></td>                  
	                    </tr>
					</xsl:for-each>
					
				</table>
			</div>
			<div class="card-body">
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
			<div class="card-body">
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
			<div class="card-body">
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