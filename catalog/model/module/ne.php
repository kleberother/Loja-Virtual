<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ModelModuleNe extends Model {
	
	public function subscribe($data, $salt, $list = array()) {
		$i = 0;
		$email = isset($data['email']) ? $data['email'] : false;
		
		if (($this->config->get('ne_unloginned_subscribe_fields') == 2 || $this->config->get('ne_unloginned_subscribe_fields') == 3) && (!isset($data['name']) || !$data['name'])) {
			return false;
		}

		if ($this->config->get('ne_unloginned_subscribe_fields') == 3 && (!isset($data['lastname']) || !$data['lastname'])) {
			return false;
		}

		$email = htmlspecialchars($email);

		if (!isset($data['lastname'])) {
			$data['lastname'] = '';
		}

		if (!isset($data['name'])) {
			$data['name'] = '';
		}

		if ($email && filter_var($email, FILTER_VALIDATE_EMAIL)) {
			$this->db->query("INSERT INTO " . DB_PREFIX . "ne_marketing SET email = '" . $this->db->escape($email) . "', firstname = '" . $this->db->escape($data['name']) . "', lastname = '" . $this->db->escape($data['lastname']) . "', code = '" . $this->db->escape(md5($salt . $email)) . "', store_id = '" . (int)$this->config->get('config_store_id') . "', subscribed = 1 ON DUPLICATE KEY UPDATE subscribed = 1, firstname = '" . $this->db->escape($data['name']) . "', lastname = '" . $this->db->escape($data['lastname']) . "'");
			if ($this->db->countAffected() > 0) {

				if ($list) {
					$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ne_marketing WHERE email = '" . $this->db->escape($email) . "' AND store_id = '" . (int)$this->config->get('config_store_id') . "'");
					$row = $query->row;
					$this->db->query("DELETE FROM " . DB_PREFIX . "ne_marketing_to_list WHERE marketing_id = '" . (int)$row['marketing_id'] . "'");
					foreach ($list as $id) {
						$this->db->query("INSERT INTO " . DB_PREFIX . "ne_marketing_to_list SET marketing_id = '" . (int)$row['marketing_id'] . "', marketing_list_id = '" . (int)$id . "'");
					}
				}
				return true;
			} 
			return null;
		}
		return false;
	}
	
}

?>