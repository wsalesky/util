xquery version "3.0";
declare namespace tei="http://www.tei-c.org/ns/1.0";
(:for $recs in doc('/db/apps/srophe/data')//tei:placeName:)

declare function local:left-half-ring-pers(){
    for $recs in collection('/db/apps/srophe/data/persons/tei')//tei:persName[contains(.,'ʿ')]
    let $parent := $recs/ancestor::tei:person
    let $rec-id := substring-after($parent/@xml:id,'-')
    let $pers-name := string-join($recs/child::*,' ')
    let $new-name := 
        (
            <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 1))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','')}</persName>,
            <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 2))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','‘')}</persName>
        )
    return 
        (update insert $new-name following $parent/tei:persName[last()],local:do-change-stmt($recs))
};

declare function local:right-half-ring-pers(){
    for $recs in collection('/db/apps/srophe/data/persons/tei')//tei:persName[contains(.,'ʾ')]
    let $parent := $recs/ancestor::tei:person
    let $rec-id := substring-after($parent/@xml:id,'-')
    let $pers-name := string-join($recs/child::*,' ')
    let $new-name := 
        (
            <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 1))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','')}</persName>,
            <persName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:persName) + 2))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($pers-name,'ʿ','’')}</persName>
        )
    return 
        (update insert $new-name following $parent/tei:persName[last()],local:do-change-stmt($recs))
};

declare function local:left-half-ring-place(){
    for $recs in collection('/db/apps/srophe/data/places/tei')//tei:placeName[contains(.,'ʿ')]
    let $parent := $recs/ancestor::tei:place
    let $rec-id := substring-after($parent/@xml:id,'-')
    let $place-name := $recs/text()
    let $new-name := 
        (
            <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 1))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','')}</placeName>,
            <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 2))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','‘')}</placeName>
        )
    return 
        (update insert $new-name following $parent/tei:placeName[last()],local:do-change-stmt($recs))
};

declare function local:right-half-ring-place(){
    for $recs in collection('/db/apps/srophe/data/places/tei')//tei:placeName[contains(.,'ʾ')]
    let $parent := $recs/ancestor::tei:place
    let $rec-id := substring-after($parent/@xml:id,'-')
    let $place-name := $recs/text()
    let $new-name := 
        (
            <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 1))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','')}</placeName>,
            <placeName xmlns="http://www.tei-c.org/ns/1.0" xml:id="{concat('name',$rec-id,'-',(count($parent/tei:placeName) + 2))}" xml:lang="en-xsrp1" syriaca-tags="#syriaca-simplified-script">{replace($place-name,'ʿ','’')}</placeName>
        )
    return 
        (update insert $new-name following $parent/tei:placeName[last()],local:do-change-stmt($recs))
};

declare function local:do-change-stmt($recs){
    let $change := 
        <change xmlns="http://www.tei-c.org/ns/1.0" who="http://syriaca.org/documentation/editors.xml#wsalesky" when="{current-date()}">ADDED: Add alternate names for search functionality.</change>
    return
        (
         update insert $change preceding $recs/ancestor::tei:TEI/tei:teiHeader/tei:revisionDesc/tei:change[1],
         update value $recs/ancestor::tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date with current-date())
};

(xmldb:login('/db/apps/srophe/', 'admin', '', true()),
local:left-half-ring-pers(),
local:right-half-ring-pers(),
local:left-half-ring-place(),
local:right-half-ring-place()
)
