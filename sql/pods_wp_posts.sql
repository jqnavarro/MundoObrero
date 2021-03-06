SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

INSERT INTO `wp_posts` (`post_author`, `post_date`, `post_date_gmt`, `post_content`, `post_title`, `post_excerpt`, `post_status`, `comment_status`, `ping_status`, `post_password`, `post_name`, `to_ping`, `pinged`, `post_modified`, `post_modified_gmt`, `post_content_filtered`, `post_parent`, `guid`, `menu_order`, `post_type`, `post_mime_type`, `comment_count`) VALUES
(1, '2022-01-19 09:20:10', '2022-01-19 09:20:10', '', 'Post', '12617', 'publish', 'closed', 'closed', '', 'post', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 0, 'http://test.mundoobrero.es/?post_type=_pods_pod&#038;p=12617', 0, '_pods_pod', '', 0),
(1, '2022-01-19 09:20:13', '2022-01-19 09:20:13', '', 'Campos extra', '12618', 'publish', 'closed', 'closed', '', 'campos-extra', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_group&#038;p=12618', 0, '_pods_group', '', 0),
(1, '2022-01-19 09:20:58', '2022-01-19 09:20:58', 'Número en la edición en papel al que corresponde esta publicación', 'Número', '12619', 'publish', 'closed', 'closed', '', 'numero', '', '', '2022-05-29 18:27:45', '2022-05-29 18:27:45', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12619', 4, '_pods_field', '', 0),
(1, '2022-01-19 09:34:44', '2022-01-19 09:34:44', 'Antetítulo de la publicación', 'Antetítulo', '12620', 'publish', 'closed', 'closed', '', 'antetitulo', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12620', 0, '_pods_field', '', 0),
(1, '2022-01-19 09:37:28', '2022-01-19 09:37:28', '', 'Subtítulo', '12621', 'publish', 'closed', 'closed', '', 'subtitulo', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12621', 1, '_pods_field', '', 0),
(1, '2022-01-19 09:40:09', '2022-01-19 09:40:09', '', 'Vídeo', '12622', 'publish', 'closed', 'closed', '', 'video', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12622', 2, '_pods_field', '', 0),
(1, '2022-01-19 09:43:29', '2022-01-19 09:43:29', '', 'Enlace', '12625', 'publish', 'closed', 'closed', '', 'enlace', '', '', '2022-05-29 18:27:44', '2022-05-29 18:27:44', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12625', 3, '_pods_field', '', 0),
(1, '2022-01-19 10:51:17', '2022-01-19 10:51:17', 'Página de la edición en papel donde aparece esta publicación', 'Página', '12629', 'publish', 'closed', 'closed', '', 'pagina', '', '', '2022-05-29 18:27:45', '2022-05-29 18:27:45', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=12629', 5, '_pods_field', '', 0),
(1, '2022-01-23 19:06:46', '2022-01-23 19:06:46', '[each columna]\n<p class="columna">\n[if img_columna]<span class="imagen">{@img_columna._img}</span>[/if]\n<span class="nombre">{@name}</span>\n</p>\n[/each]\n\n<div class="post-header">\n	<p><ul class="post-categorias">\n		[each category]\n{@category.name,limit_by_2_length}\n	[/each]</ul>\n\n	[if antetitulo]<span class="antetitulo">{@antetitulo}</span>[/if]\n	\n<h1 class="entry-title">{@post_title}</h1>\n	\n	[if subtitulo]<div class="subtitulo">{@subtitulo}</div>[/if]\n	\n<div class="post-meta vcard">\n	<ul class="post-autores">\n			[each autor]<li class="post-autor"><a href="{@autor.permalink}">{@autor.name}</a></li>[/each]\n	[if descripcion_autores](*)[/if]\n		</ul> | {@post_date,fecha_mo}\n			\n</div>\n</div>\n\n[if post_thumbnail]\n<div class="post-thumbnail-mo header">\n<img src="{@post_thumbnail_url.large}" alt="{@post_title}"> \n<span class="leyenda">{@post_thumbnail.full,wis_extract_caption}</span>\n</div>\n[/if]\n<div class="post-wrap">\n<div class="post-content entry-content">\n\n[if video]\n<iframe width="395" height="222" src="https://www.youtube.com/embed/{@video}" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>	\n[/if]	\n\n	{@post_content}\n\n[if descripcion_autores]\n	<div class="descripcion-autores">{@descripcion_autores}</div>\n	\n[/if]	\n\n[if post_tag]\n<h3>Etiquetas:</h3>\n<ul class="mo-tags">\n		[each post_tag]<li><a href="{@post_tag.permalink}">{@post_tag.name}</a></li>[/each]\n</ul>\n[/if]\n</div>\n\n\n', 'Publicaciones', '23046', 'publish', 'closed', 'closed', '', 'publicaciones', '', '', '2022-05-26 16:01:42', '2022-05-26 16:01:42', '', 0, 'http://test.mundoobrero.es/?post_type=_pods_template&#038;p=23046', 0, '_pods_template', '', 0),
(1, '2022-02-20 21:30:51', '2022-02-20 21:30:51', 'Artículos relacionados', 'Relacionados', '23182', 'publish', 'closed', 'closed', '', 'relacionados', '', '', '2022-05-29 18:27:45', '2022-05-29 18:27:45', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=23182', 6, '_pods_field', '', 0),
(1, '2022-04-14 17:30:32', '2022-04-14 17:30:32', '', 'Autores', '34179', 'publish', 'closed', 'closed', '', 'autores', '', '', '2022-05-29 16:07:58', '2022-05-29 16:07:58', '', 0, 'http://test.mundoobrero.es/?post_type=_pods_pod&#038;p=34179', 0, '_pods_pod', '', 0),
(1, '2022-04-14 17:30:34', '2022-04-14 17:30:34', '', 'More Fields', '34180', 'publish', 'closed', 'closed', '', 'more-fields', '', '', '2022-05-29 16:07:58', '2022-05-29 16:07:58', '', 34179, 'http://test.mundoobrero.es/?post_type=_pods_group&#038;p=34180', 0, '_pods_group', '', 0),
(1, '2022-04-14 17:30:56', '2022-04-14 17:30:56', '', 'Twitter', '34181', 'publish', 'closed', 'closed', '', 'twitter', '', '', '2022-05-29 16:07:59', '2022-05-29 16:07:59', '', 34179, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=34181', 0, '_pods_field', '', 0),
(1, '2022-04-22 21:22:40', '2022-04-22 21:22:40', '', 'Columnas', '34227', 'publish', 'closed', 'closed', '', 'columnas', '', '', '2022-05-29 16:11:12', '2022-05-29 16:11:12', '', 0, 'http://test.mundoobrero.es/?post_type=_pods_pod&#038;p=34227', 0, '_pods_pod', '', 0),
(1, '2022-04-27 17:23:57', '2022-04-27 17:23:57', '', 'Imagen de la columna', '34233', 'publish', 'closed', 'closed', '', 'imagen-de-la-columna', '', '', '2022-05-04 12:54:46', '2022-05-04 12:54:46', '', 34227, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=34233', 0, '_pods_field', '', 0),
(1, '2022-05-16 12:41:01', '2022-05-16 12:41:01', '', 'Descripción autores', '34615', 'publish', 'closed', 'closed', '', 'descripcion-autores', '', '', '2022-05-29 18:27:45', '2022-05-29 18:27:45', '', 12617, 'http://test.mundoobrero.es/?post_type=_pods_field&#038;p=34615', 7, '_pods_field', '', 0);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

update wp_posts wp1
inner join wp_posts wp2
on wp2.post_excerpt = wp1.post_parent
and wp1.post_type like '_pods%' and wp2.post_type like '_pods%'
set wp1.post_parent = wp2.ID;

update wp_posts
set post_excerpt = ''
where post_type like '_pods%';
