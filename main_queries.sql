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

/*
## Posts - Migración básica para los campos disponibles
*/
INSERT  INTO wp_posts(  `ID` ,  `post_date` ,  `post_date_gmt` ,  `post_content` ,  `post_title` ,  `post_excerpt` ,  `post_status` ,  `comment_status` ,  `ping_status` ,  `post_name` ,  `post_parent` ,  `guid` ,  `menu_order` ,  `post_type` ,  `comment_count` ,  `post_author`  ) 
SELECT sid, fecha_oculta, fecha_oculta, cuerpo, titulo, entradilla,  "publish",  "closed",  "closed", lower(fn_remove_accents(titulo)) , 0, CONCAT(  'http://preprod.mundoobrero.es/?p=', sid ) , 0,  "post", 0,1
FROM mo_noticias;
