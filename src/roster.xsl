<xsl:template name="roster">
    <table>
        <tr>
            <td colspan="2">Army Roster</td>
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
    <table>
        <tr>
            <td>Detachment Name</td>
            <td>Type</td>
            <td>CPS</td>
            <td>Points</td>
        </tr>
        <xsl:apply-templates select="bs:force" mode="roster"/>
    </table>
    <div><table>
        <tr>
            <td>Warlord Trait</td>
        </tr>
        <tr>
            <td>Fill in at set-up:</td>
        </tr>
    </table></div>
    <div>
        <table>
            <tr>
                <td>Total Command Points</td>
                <td></td>
            </tr>
            <tr>
                <td>Reinforcement Points</td>
                <td></td>
            </tr>
            <tr>
                <td>TOTAL POINTS</td>
                <td><xsl:value-of select="../bs:costs/bs:cost[@name='pts']/@value"/></td>
            </tr>
        </table>
    </div>
</xsl:template>