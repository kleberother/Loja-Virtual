<?php
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------

class ModelNeNewsletter extends Model {

	public function get($data) {
		$query = $this->db->query("SELECT history_id FROM `" . DB_PREFIX . "ne_stats_personal` WHERE stats_personal_id = '" . (int)$data['uid'] . "' AND email = '" . $this->db->escape($data['email']) . "'");
		if ($query->row) {
			$history_id = $query->row['history_id'];
			$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ne_history` WHERE history_id = '" . (int)$history_id . "'");

			return $query->row;
		} else {
			return false;
		}
	}
	
	public function info($email) {
		$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "customer WHERE email = '" . $this->db->escape($email) . "'");
		$info = $query->row;

		if (!$info) {
			$query = $this->db->query("SELECT * FROM " . DB_PREFIX . "ne_marketing WHERE email = '" . $this->db->escape($email) . "'");
			$info = $query->row;
			if ($info) {
				$info['marketing'] = true;
			}
		}
		
		return $info;
	}

	public function get_show($history_id) {
		$query = $this->db->query("SELECT * FROM `" . DB_PREFIX . "ne_history` WHERE history_id = '" . (int)$history_id . "'");
		return $query->row;
	}
}

?>