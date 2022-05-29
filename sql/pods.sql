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
