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