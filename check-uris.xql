xquery version "3.0";
(:~ 
 : Srophe utility function to update bibl elements with full bibl entry from syriaca.org bibl module
 : See: https://github.com/srophe/bethqatraye-data/issues/50 
 :   
 : @author Winona Salesky
 : @version 1.0 
 : 
 :) 
import module namespace http="http://expath.org/ns/http-client";

declare namespace tei="http://www.tei-c.org/ns/1.0";
declare namespace file="http://exist-db.org/xquery/file";

(:
 : Global variables, change for each use case
:)
(: Set $web to true() to access via Syriaca.org production server, flase() to run locally, this will require having srophe-app-data installed on your local version of eXist:)
declare variable $data-root := '/db/apps/bethqatraye-data/data';
declare variable $baseURI := 'http://bqgazetteer.bethmardutho.org/place/';
declare variable $editor := 'srophe-util';
declare variable $changeLog := 'CHANGED: Update bibl elements with full citation information from Syriaca.org entry.';

let $uris := distinct-values(collection($data-root)//tei:idno[@type='URI'])
(:
let $refs := 
        distinct-values(tokenize(string-join(collection($data-root)//@ref 
        | collection($data-root)//@target
        | collection($data-root)//@passive
        | collection($data-root)//@active
        | collection($data-root)//@matches,' '),' '))[not(contains(.,'/documentation'))]
:)        
let $refs := collection($data-root)//@ref 
        | collection($data-root)//@target
        | collection($data-root)//@passive
        | collection($data-root)//@active
        | collection($data-root)//@matches
for $r in $refs
for $rt in tokenize($r,' ')[not(contains(.,'/documentation'))]
where $rt != $uris
return 
    <div doc="{document-uri(root($r))}">{$r}</div>