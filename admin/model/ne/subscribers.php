<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ModelNeSubscribers extends Model {

	public function getTotal($data = array()) {
		$sql = "SELECT COUNT(*) AS total FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id)";

		$implode = array();
		
		if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
			$implode[] = "LCASE(CONCAT(c.firstname, ' ', c.lastname)) LIKE '%" . $this->db->escape(mb_strtolower($data['filter_name'], 'UTF-8')) . "%'";
		}
		
		if (isset($data['filter_email']) && !is_null($data['filter_email'])) {
			$implode[] = "c.email LIKE '%" . $this->db->escape($data['filter_email']) . "%'";
		}

		if (isset($data['filter_customer_group_id']) && !is_null($data['filter_customer_group_id'])) {
			$implode[] = "c.customer_group_id = '" . (int)$data['filter_customer_group_id'] . "'";
		}
		
		if (isset($data['filter_newsletter']) && !is_null($data['filter_newsletter'])) {
			$implode[] = "c.newsletter = '" . (int)$data['filter_newsletter'] . "'";
		}

		if (isset($data['filter_store']) && !is_null($data['filter_store'])) {
			$implode[] = "`store_id` = '" . (int)$data['filter_store'] . "'";
		}

		$implode[] = "c.approved = '1'";
		
		if ($implode) {
			$sql .= " WHERE " . implode(" AND ", $implode);
		}	
		
		$query = $this->db->query($sql);
		
		return $query->row['total'];	
	}

	public function getList($data = array()) {
		$sql = "SELECT *, CONCAT(c.firstname, ' ', c.lastname) AS name, cgd.name AS customer_group FROM " . DB_PREFIX . "customer c LEFT JOIN " . DB_PREFIX . "customer_group cg ON (c.customer_group_id = cg.customer_group_id) LEFT JOIN " . DB_PREFIX . "customer_group_description cgd ON (cgd.customer_group_id = cg.customer_group_id)";

                
		$implode = array();
		
		if (isset($data['filter_name']) && !is_null($data['filter_name'])) {
			$implode[] = "LCASE(CONCAT(c.firstname, ' ', c.lastname)) LIKE '%" . $this->db->escape(mb_strtolower($data['filter_name'], 'UTF-8')) . "%'";
		}
		
		if (isset($data['filter_email']) && !is_null($data['filter_email'])) {
			$implode[] = "c.email LIKE '%" . $this->db->escape($data['filter_email']) . "%'";
		}

		if (isset($data['filter_customer_group_id']) && !is_null($data['filter_customer_group_id'])) {
			$implode[] = "c.customer_group_id = '" . (int)$data['filter_customer_group_id'] . "'";
		}
		
		if (isset($data['filter_newsletter']) && !is_null($data['filter_newsletter'])) {
			$implode[] = "c.newsletter = '" . (int)$data['filter_newsletter'] . "'";
		}

		if (isset($data['filter_store']) && !is_null($data['filter_store'])) {
			$implode[] = "`store_id` = '" . (int)$data['filter_store'] . "'";
		}

		$implode[] = "c.approved = '1'";
		
		if ($implode) {
			$sql .= " WHERE cgd.language_id = '" . (int) $this->config->get('config_language_id') . "' AND " . implode(" AND ", $implode);
		}
		
		$sort_data = array(
			'name',
			'c.email',
			'customer_group',
			'c.newsletter',
			'store_id'
		);	
			
		if (isset($data['sort']) && in_array($data['sort'], $sort_data)) {
			$sql .= " ORDER BY " . $data['sort'];	
		} else {
			$sql .= " ORDER BY name";	
		}
			
		if (isset($data['order']) && ($data['order'] == 'DESC')) {
			$sql .= " DESC";
		} else {
			$sql .= " ASC";
		}
		
		if (isset($data['start']) || isset($data['limit'])) {
			if ($data['start'] < 0) {
				$data['start'] = 0;
			}			

			if ($data['limit'] < 1) {
				$data['limit'] = 20;
			}	
			
			$sql .= " LIMIT " . (int)$data['start'] . "," . (int)$data['limit'];
		}		
		
		$query = $this->db->query($sql);
		
		return $query->rows;	
	}

	public function subscribe($id = 0) {
		$id = (int)$id;
		if ($id > 0) {
			$sql = "UPDATE " . DB_PREFIX . "customer SET newsletter = 1 WHERE customer_id = " . $id;
			$this->db->query($sql);
		}
	}

	public function unsubscribe($id = 0) {
		$id = (int)$id;
		if ($id > 0) {
			$sql = "UPDATE " . DB_PREFIX . "customer SET newsletter = 0 WHERE customer_id = " . $id;
			$this->db->query($sql);
		}
	}
	
}

?>