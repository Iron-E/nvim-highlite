--- @meta

--- @alias highlite.color.8_bit 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|120|121|122|123|124|125|126|127|128|129|130|131|132|133|134|135|136|137|138|139|140|141|142|143|144|145|146|147|148|149|150|151|152|153|154|155|156|157|158|159|160|161|162|163|164|165|166|167|168|169|170|171|172|173|174|175|176|177|178|179|180|181|182|183|184|185|186|187|188|189|190|191|192|193|194|195|196|197|198|199|200|201|202|203|204|205|206|207|208|209|210|211|212|213|214|215|216|217|218|219|220|221|222|223|224|225|226|227|228|229|230|231|232|233|234|235|236|237|238|239|240|241|242|243|244|245|246|247|248|249|250|251|252|253|254|255 an 8 bit color

--- @alias highlite.color.ansi "black"|"darkblue"|"darkgreen"|"darkcyan"|"darkred"|"darkmagenta"|"brown"|"darkyellow"|"lightgray"|"lightgrey"|"gray"|"grey"|"darkgray"|"darkgrey"|"blue"|"lightblue"|"green"|"lightgreen"|"cyan"|"lightcyan"|"red"|"lightred"|"magenta"|"lightmagenta"|"yellow"|"lightyellow"|"white" an ANSI color name

--- @class highlite.color.definition a color which can be rendered in any terminal
--- @field [1] string the RGB value
--- @field [2] highlite.color.8_bit
--- @field [3] highlite.color.ansi

--- @alias highlite.group.blend 0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100

--- @alias highlite.group.link string|{link: string} a |:highlight-link| to an existing highlight group

--- @class highlite.group.new a new highlight group
--- @field bg? highlite.color.definition
--- @field blend? highlite.group.blend the transparency value
--- @field bold? boolean
--- @field dark? highlite.group.new special highlight definition for when `&bg` is 'dark'
--- @field default? boolean
--- @field fg? highlite.color.definition
--- @field italic? boolean
--- @field light? highlite.group.new special highlight definition for when `&bg` is 'light'
--- @field nocombine? boolean
--- @field reverse? boolean
--- @field sp? highlite.color.definition
--- @field standout? boolean
--- @field strikethrough? boolean
--- @field undercurl? boolean
--- @field underdashed? boolean
--- @field underdotted? boolean
--- @field underdouble? boolean
--- @field underline? boolean

--- @alias highlite.group.definition highlite.group.link|highlite.group.new a link to an existing group or a new group

--- @class highlite.groups
--- @field [string] highlite.group.definition|fun(self: self): highlite.group.new a collection of highlight group definitions

--- @class highlite.group.nvim_api a highlight group as expected by the `nvim_set_hl` function
--- @field bg? string
--- @field blend? highlite.group.blend the transparency value
--- @field bold? boolean
--- @field ctermbg? highlite.color.8_bit|highlite.color.ansi
--- @field ctermfg? highlite.color.8_bit|highlite.color.ansi
--- @field default? boolean
--- @field fg? string
--- @field italic? boolean
--- @field link? string
--- @field nocombine? boolean
--- @field reverse? boolean
--- @field sp? string
--- @field standout? boolean
--- @field strikethrough? boolean
--- @field undercurl? boolean
--- @field underdashed? boolean
--- @field underdotted? boolean
--- @field underdouble? boolean
--- @field underline? boolean
