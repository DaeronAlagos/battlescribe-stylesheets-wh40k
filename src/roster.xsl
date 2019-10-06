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