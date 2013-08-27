SELECT SUM(machines.quota_purchased), license_type_id
FROM mozy_pro_keys, machines
WHERE NOT deleted 
  AND mozy_pro_keys.machine_id = machines.id
  AND machines.quota_purchased > 0
  AND machines.user_id IN (
 	SELECT id 
	FROM users 
	WHERE NOT deleted 
	  AND user_group_id IN (
		SELECT id 
		FROM user_groups 
		WHERE pro_partner_id IN (
			SELECT id 
			FROM pro_partners 
			WHERE tree_sortkey BETWEEN '#{self.tree_sortkey}' AND tree_right('#{self.tree_sortkey}')
		) OFFSET 0
	) OFFSET 0
)
GROUP BY license_type_id;