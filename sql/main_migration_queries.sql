/*
# Categorías y posts de noticias
## Categorías - Las extraemos con el mismo ID que MO para facilitar futuros joins
*/

INSERT  INTO  `wp_terms` (  `term_id` ,  `name` ,  `slug`,  `term_group` ) 
SELECT  `id_seccion` ,  `seccion`,  lower( fn_remove_accents(seccion)  ) , 0
FROM secciones
WHERE id_seccion < 8;

INSERT  INTO  `wp_term_taxonomy` (  `term_taxonomy_id` , `term_id` ,  `taxonomy` ) 
SELECT  `term_id`,`term_id`,'category'
FROM wp_terms;

-- ## Posts - Migración básica para los campos disponibles

INSERT  INTO wp_posts(  `ID` ,  `post_date` ,  `post_date_gmt` ,  `post_content` ,  `post_title` ,  `post_excerpt` ,  `post_status` ,  `comment_status` ,  `ping_status` ,  `post_name` ,  `post_parent` ,  `guid` ,  `menu_order` ,  `post_type` ,  `comment_count` ,  `post_author`  ) 
SELECT sid, fecha_oculta, fecha_oculta, cuerpo, titulo, entradilla,  "publish",  "closed",  "closed", lower(fn_remove_accents(titulo)) , 0, CONCAT(  'http://preprod.mundoobrero.es/?p=', sid ) , 0,  "post", 0,1
FROM mo_noticias;

-- ## Posts a Categorías - Asociación posts-categoría

INSERT  INTO  `wp_term_relationships` (  `object_id` ,  `term_taxonomy_id` ,  `term_order`  ) 
SELECT DISTINCT  sid, seccion, 0
FROM mo_noticias


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

/* # Autores - Trabajando con datos en Pods 
## Autores como taxonomía: repetir categorías + term_group como "campo comodín"
*/

INSERT  INTO wp_terms(  `name` ,  `term_group` ) 
SELECT TRIM( CONCAT( coalesce( aut_nombre, '' ) , ' ', coalesce( aut_apellido1, '' ) , ' ', coalesce( aut_apellido2, '' ) ) ) , id_autor
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

update `wp_terms` set slug = lower(fn_remove_accents(name));


-- ## Libros

update wp_posts
join (
SELECT id_noticia, id_libro, CONCAT('<div id="libros"><p>
              <img src="http://test.mundoobrero.es/wp-content/uploads/img/libros/',imagen,'" class="attachment-thumbnail size-thumbnail" width="108" height="150">
                      <span class="titulo">',titulo,'</span>
                                <span class="autor">',autor,'</span>',
                                coalesce(concat('<span class="editorial">',editorial,'</span>'),''),
              '</p></div>') as insert_libro
FROM `libros` li
join noticias_libros nl
on li.id = nl.id_libro) libros
on id_noticia = ID

set post_content = concat(insert_libro,post_content)














