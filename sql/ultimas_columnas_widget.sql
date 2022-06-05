select t1.term_taxonomy_id, t1.id as post_id, t1.post_date

from (
select term_taxonomy_id, id, post_date
from wp_posts po
join (
    SELECT object_id, term_taxonomy_id
	FROM `wp_term_relationships`
	WHERE term_taxonomy_id IN ( 
    	SELECT term_taxonomy_id
		FROM `wp_term_taxonomy`
		WHERE taxonomy = 'columna' )) tx
on object_id = id ) t1
join (
    select term_taxonomy_id, max(post_date) as last_date
	from wp_posts po
	join (
    	SELECT object_id, term_taxonomy_id
		FROM `wp_term_relationships`
		WHERE term_taxonomy_id IN ( 
    		SELECT term_taxonomy_id
			FROM `wp_term_taxonomy`
			WHERE taxonomy = 'columna' )) tx
	on object_id = id
    	group by 1 ) t2
on t1.term_taxonomy_id = t2.term_taxonomy_id and post_date = last_date
order by post_date desc
