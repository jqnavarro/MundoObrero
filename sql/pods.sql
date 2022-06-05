/* # Autores - Trabajando con datos en Pods 
## Autores como taxonomía: repetir categorías + term_group como "campo comodín"
*/

INSERT  INTO wp_terms(  `name` , `slug`,  `term_group` ) 
SELECT TRIM( CONCAT( coalesce( aut_nombre, '' ) , ' ', coalesce( aut_apellido1, '' ) , ' ', coalesce( aut_apellido2, '' ) ) ) 
, fn_remove_accents(TRIM( CONCAT( coalesce( aut_nombre, '' ) , ' ', coalesce( aut_apellido1, '' ) , ' ', coalesce( aut_apellido2, '' ) ) ))
, id_autor
FROM autores;

INSERT  INTO  `wp_term_taxonomy` (  `term_taxonomy_id` ,  `term_id` ,  `taxonomy`  ) 
SELECT te.term_id, te.term_id,  'autor'
FROM wp_terms te
LEFT  JOIN wp_term_taxonomy ta ON ta.term_id = te.term_id
WHERE ta.term_id IS NULL;

INSERT  INTO  `wp_term_relationships` ( object_id, term_taxonomy_id, term_order ) 
SELECT  DISTINCT id_noticia, term_id, 0
FROM noticias_autores na, wp_terms wt
WHERE term_group = id_autor;

INSERT  INTO wp_termmeta(  `term_id` ,  `meta_key` ,  `meta_value`  )
SELECT term_id, "twitter", twitter
FROM `wp_terms` wp, autores mo
WHERE id_autor = term_group
AND twitter IS NOT NULL;

-- Descripción de autor:

update `wp_term_taxonomy` tt
join wp_terms wt
on tt.term_id = wt.term_id
and taxonomy = 'autor'
join autores na
on term_group = id_autor
set description = descripcion;

-- Asociación autor-noticia:

INSERT  INTO  `wp_term_relationships` ( object_id, term_taxonomy_id, term_order ) 
SELECT  DISTINCT id_noticia, term_id, 0
FROM noticias_autores na, wp_terms wt
WHERE term_group = id_autor;

/* # Columnas - Misma técnica que con Autores */

INSERT  INTO wp_terms(  `name` , `slug`,  `term_group`  ) 
SELECT nombre, lower( fn_remove_accents(nombre)  ), id_columna
FROM columnas;

INSERT  INTO  `wp_term_taxonomy` (  `term_taxonomy_id` ,  `term_id` ,  `taxonomy`  ) 
SELECT te.term_id, te.term_id,  'columna'
FROM wp_terms te
LEFT  JOIN wp_term_taxonomy ta ON ta.term_id = te.term_id
WHERE ta.term_id IS  NULL;

-- Asignar columnas a posts

INSERT  INTO  `wp_term_relationships` ( object_id, term_taxonomy_id, term_order ) 
SELECT  DISTINCT sid, wt.term_id, 0
FROM mo_noticias na, wp_terms wt, wp_term_taxonomy ta
WHERE term_group = columna
AND ta.term_taxonomy_id = wt.term_id
AND ta.taxonomy = 'columna';

-- Asignar imágenes

insert into wp_termmeta ( term_id, meta_key, meta_value)
select tx.term_id, 'img_columna', wp2.ID
from wp_terms tr
join wp_term_taxonomy tx
on tx.term_id = tr.term_id
and taxonomy = 'columna'
join columnas col
on id_columna = term_group
JOIN wp_posts wp2
on img_col = REPLACE(wp2.guid, 'http://test.mundoobrero.es/wp-content/uploads/', '')
and wp2.post_type = "attachment";
INSERT  INTO wp_termmeta( term_id, meta_key, meta_value ) 
SELECT term_id,  '_pods_img_columna', concat(  'a:1:{i:0;i:', meta_value,  ';}'  ) 
FROM wp_termmeta
WHERE meta_key =  'img_columna';
insert into wp_podsrel (pod_id,field_id,item_id,related_pod_id,related_field_id,related_item_id,weight)
SELECT post_parent, wp.ID, term_id, 0, 0, meta_value,0
FROM `wp_posts` wp
join wp_termmeta tm
on meta_key = post_name
WHERE post_name = 'img_columna'
and post_type = '_pods_field';

-- ## Contador de posts en categorias - Reset
UPDATE wp_term_taxonomy SET count = (
SELECT COUNT(*) FROM wp_term_relationships rel 
    LEFT JOIN wp_posts po ON (po.ID = rel.object_id) 
    WHERE 
        rel.term_taxonomy_id = wp_term_taxonomy.term_taxonomy_id 
        AND 
        wp_term_taxonomy.taxonomy NOT IN ('link_category')
        AND 
        po.post_status IN ('publish', 'future')
);

update wp_terms set `term_group` = 0 where `term_group` > 0;
