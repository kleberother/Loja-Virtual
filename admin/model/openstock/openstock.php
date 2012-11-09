<?php 
/** 
 * OpenStock model class
 * 
 * Created by James Allsup / Welford Media
 * www.welfordmedia.co.uk / support.welfordmedia.co.uk
 */
class ModelOpenstockOpenstock extends Model 
{    
    public function calcOptions($pId){
        $SQL = "SELECT `" . DB_PREFIX . "product_option_value`.`product_option_value_id`, `" . DB_PREFIX . "product_option_value`.`option_id`
            FROM
                `" . DB_PREFIX . "product_option_value`,
                `" . DB_PREFIX . "option_value_description`,
                `" . DB_PREFIX . "option_value`,
                `" . DB_PREFIX . "option`
            WHERE
                `" . DB_PREFIX . "product_option_value`.`product_id` = '".$pId."'
            AND
                ((`" . DB_PREFIX . "option`.`type` = 'radio') OR (`" . DB_PREFIX . "option`.`type` = 'select'))
            AND
                `" . DB_PREFIX . "product_option_value`.`option_value_id` = `" . DB_PREFIX . "option_value_description`.`option_value_id`
            AND
                `" . DB_PREFIX . "option_value`.`option_value_id` = `" . DB_PREFIX . "product_option_value`.`option_value_id`
            AND
                `" . DB_PREFIX . "option`.`option_id` = `" . DB_PREFIX . "option_value`.`option_id`
            ORDER BY `" . DB_PREFIX . "option`.`sort_order`, `" . DB_PREFIX . "option_value`.`sort_order` ASC";

        $options_qry = $this->db->query($SQL);

        $unique_grp = array();
        foreach($options_qry->rows as $row)
        {                    
            if(!array_key_exists($row['option_id'], $unique_grp))
            {
                $unique_grp[$row['option_id']] = array();
            }

            $unique_grp[$row['option_id']][] = $row['product_option_value_id'];
        }

        $newArray = array();
        $i = 0;
        foreach($unique_grp as $key => $grp)
        {
            $newArray[$i] = $grp;
            $i++;
        }

        $final = array();

        if(!empty($newArray))
        {
            foreach($newArray[0] as $k1 => $v1)
            {
                if(!empty($newArray[1]))
                {
                    foreach($newArray[1] as $k2 => $v2)
                    {
                        if(!empty($newArray[2]))
                        {
                            foreach($newArray[2] as $k3 => $v3)
                            {
                                if(!empty($newArray[3]))
                                {
                                    foreach($newArray[3] as $k4 => $v4)
                                    {
                                        if(!empty($newArray[4]))
                                        {
                                            foreach($newArray[4] as $k5 => $v5)
                                            {
                                                if(!in_array($v1.':'.$v2.':'.$v3.':'.$v4.':'.$v5, $final))
                                                {
                                                    $final[] = $v1.':'.$v2.':'.$v3.':'.$v4.':'.$v5;
                                                }
                                            }
                                        }else{
                                            if(!in_array($v1.':'.$v2.':'.$v3.':'.$v4, $final))
                                            {
                                                $final[] = $v1.':'.$v2.':'.$v3.':'.$v4;
                                            }
                                        }
                                    }
                                }else{
                                    if(!in_array($v1.':'.$v2.':'.$v3, $final))
                                    {
                                        $final[] = $v1.':'.$v2.':'.$v3;
                                    }
                                }
                            }
                        }else{
                            if(!in_array($v1.':'.$v2, $final))
                            {
                                $final[] = $v1.':'.$v2;
                            }
                        }
                    }
                }else{
                    if(!in_array($v1, $final))
                    {
                        $final[] = $v1;
                    }
                }
            }
        }

        return $final;
    }
    
    public function install(){
        
        $this->log->write('OPENSTOCK --> Starting install');
        
        $this->db->query("ALTER TABLE `".DB_PREFIX."product` ADD `has_option` TINYINT( 1 ) NOT NULL");
        $this->db->query("ALTER TABLE `".DB_PREFIX."order` ADD `return_stock` TINYINT( 1 ) NOT NULL");
        
        $this->log->write('OPENSTOCK --> Altered '.DB_PREFIX.'product table');
        
        $sql = "
            CREATE TABLE IF NOT EXISTS `".DB_PREFIX."product_option_relation` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `product_id` int(11) NOT NULL,
              `var` char(100) NOT NULL,
              `sku` char(50) NOT NULL,
              `stock` int(11) NOT NULL,
              `active` tinyint(4) NOT NULL DEFAULT '1',
              `subtract` tinyint(1) NOT NULL DEFAULT '0',
              `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
              `image` text NOT NULL,
              PRIMARY KEY (`id`)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
        ";
        $query = $this->db->query($sql);
        $this->log->write('OPENSTOCK --> Created '.DB_PREFIX.'product_option_relation table');
        
        $sql = "
            CREATE TABLE IF NOT EXISTS `".DB_PREFIX."product_option_relation_group_price` (
              `id` int(11) NOT NULL AUTO_INCREMENT,
              `product_option_relation_id` int(11) NOT NULL,
              `customer_group_id` int(11) NOT NULL,
              `product_id` int(11) NOT NULL,
              `price` decimal(10,4) NOT NULL DEFAULT '0.0000',
              PRIMARY KEY (`id`)
            ) ENGINE=MyISAM  DEFAULT CHARSET=utf8;
        ";
        $query = $this->db->query($sql);
        $this->log->write('OPENSTOCK --> Created '.DB_PREFIX.'product_option_relation_group_price table');
        
        $this->log->write('OPENSTOCK --> Completed install');
    }
    
    public function uninstall(){
        
        $this->log->write('OPENSTOCK --> Starting uninstall');
        
        $query = $this->db->query("ALTER TABLE `".DB_PREFIX."product` DROP `has_option`");
        $query = $this->db->query("ALTER TABLE `".DB_PREFIX."order` DROP `return_stock`");
        $this->log->write('OPENSTOCK --> Altered '.DB_PREFIX.'product table');
        
        $query = $this->db->query("DROP TABLE `".DB_PREFIX."product_option_relation`");
        $this->log->write('OPENSTOCK --> Dropped '.DB_PREFIX.'product_option_relation table');
        
        $query = $this->db->query("DROP TABLE `".DB_PREFIX."product_option_relation_group_price`");
        $this->log->write('OPENSTOCK --> Dropped '.DB_PREFIX.'product_option_relation_group_price table');
        
        $this->log->write('OPENSTOCK --> Completed uninstall');
    }
    
    public function getProductsWithOptions(){
        
        $this->load->model('catalog/product');
        $this->load->model('catalog/option');
        $this->load->model('tool/image');
        
        $query = $this->db->query("SELECT `product_id` FROM `".DB_PREFIX."product` WHERE `has_option` = '1'");
        
        if($query->num_rows)
        {
            $products = array();
            
            foreach($query->rows as $row)
            {
                $p              = $this->model_catalog_product->getProduct($row['product_id']);
                $p['options']   = $this->getProductOptionStocks($row['product_id']);	
                
                
                unset($p['description']);
                
                $products[] = $p;
            }
            
            return $products;
        }else{
            return false;
        }
    }
    
    public function getProductOptionStocks($pId) {
        $SQL = "
                SELECT `" . DB_PREFIX . "product_option_value`.`product_option_value_id`, `" . DB_PREFIX . "option_value_description`.`name`
                FROM
                    `" . DB_PREFIX . "product_option_value`,
                    `" . DB_PREFIX . "option_value_description`,
                    `" . DB_PREFIX . "option_value`,
                    `" . DB_PREFIX . "option`
                WHERE
                    `" . DB_PREFIX . "product_option_value`.`product_id` = '" . $pId . "'
                AND
                    `" . DB_PREFIX . "product_option_value`.`option_value_id` = `" . DB_PREFIX . "option_value_description`.`option_value_id`
                AND
                    `" . DB_PREFIX . "option_value`.`option_value_id` = `" . DB_PREFIX . "product_option_value`.`option_value_id`
                AND
                    `" . DB_PREFIX . "option`.`option_id` = `" . DB_PREFIX . "option_value`.`option_id`
                ORDER BY `" . DB_PREFIX . "option`.`sort_order`, `" . DB_PREFIX . "option_value`.`sort_order` ASC";
        $options_qry = $this->db->query($SQL);

        $optionValues = array();
        foreach ($options_qry->rows as $row) {
            $optionValues[$row['product_option_value_id']] = $row['name'];
        }

        $SQL = "SELECT * FROM `" . DB_PREFIX . "product_option_relation` WHERE `product_id` = '" . $pId . "' ORDER BY `var` ASC";
        $mix_qry = $this->db->query($SQL);

        $optionsStockArray = array();

        foreach ($mix_qry->rows as $row) {
            $options = explode(':', $row['var']);
            $combi = '';
            foreach ($options as $k => $v) {
                $combi .= $optionValues[$v] . ' > ';
            }

            $sql2 = "SELECT * FROM `" . DB_PREFIX . "product_option_relation_group_price` WHERE `product_id` = '" . $pId . "' AND `product_option_relation_id` = '" . (int) $row['id'] . "'";
            $grp_mix_qry = $this->db->query($sql2);

            $gpArr = array();

            foreach ($grp_mix_qry->rows as $row2) {
                $gpArr[$row2['customer_group_id']] = $row2['price'];
            }

            if (!empty($row) && $row['image'] && file_exists(DIR_IMAGE . $row['image'])) {
                $thumb = $this->model_tool_image->resize($row['image'], 100, 100);
            } else {
                $thumb = $this->model_tool_image->resize('no_image.jpg', 100, 100);
            }

            $optionsStockArray[$row['id']] = array(
                'id' => $row['id'],
                'sku' => $row['sku'],
                'product_id' => $row['product_id'],
                'combi' => $combi,
                'stock' => $row['stock'],
                'active' => $row['active'],
                'var' => $row['var'],
                'subtract' => $row['subtract'],
                'price' => $row['price'],
                'opts' => $optionValues,
                'grp' => $gpArr,
                'image' => $row['image'],
                'thumb' => $thumb
            );
        }

        return $optionsStockArray;
    }
}
?>