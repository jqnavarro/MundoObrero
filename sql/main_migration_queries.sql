-- Resetear el auto increment al número que queramos: ALTER TABLE wp_terms AUTO_INCREMENT = 11;

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
SELECT sid, fecha_oculta, fecha_oculta, cuerpo, titulo, entradilla,  "publish",  "closed",  "closed", fn_remove_accents(titulo) , 0, CONCAT(  'http://preprod.mundoobrero.es/?p=', sid ) , 0,  "post", 0,1
FROM mo_noticias;

-- ## Posts a Categorías - Asociación posts-categoría

INSERT  INTO  `wp_term_relationships` (  `object_id` ,  `term_taxonomy_id` ,  `term_order`  ) 
SELECT DISTINCT  sid, seccion, 0
FROM mo_noticias

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
