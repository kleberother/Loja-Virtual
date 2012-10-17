<?php  
/**
 * OpenStock controller class
 * 
 * Created by James Allsup / Welford Media
 * http://www.welfordmedia.co.uk / http://support.welfordmedia.co.uk
 */
class ControllerModuleOpenstock extends Controller 
{
    public function index(){
        $this->load->language('module/openstock');
        
        if(isset($this->session->data['error']))
        {
            $this->data['error'] = $this->session->data['error'];
            unset($this->session->data['error']);
        }else{
            $this->data['error'] = '';
        }
        
        if(isset($this->session->data['success']))
        {
            $this->data['success'] = $this->session->data['success'];
            unset($this->session->data['success']);
        }else{
            $this->data['success'] = '';
        }
        
        $this->data['heading_title']        = $this->language->get('heading_title');
        $this->data['module_installed']     = $this->language->get('module_installed');
        $this->data['module_export_txt']    = $this->language->get('module_export_txt');
        
        $this->data['button_cancel']        = $this->language->get('button_cancel');
        $this->data['button_export']        = $this->language->get('button_export');
        $this->data['button_import']        = $this->language->get('button_import');
        
        $this->data['tab_status']           = $this->language->get('tab_status');
        $this->data['tab_export']           = $this->language->get('tab_export');
        $this->data['tab_import']           = $this->language->get('tab_import');
        
        $this->data['label_export']         = $this->language->get('label_export');
        $this->data['help_export']          = $this->language->get('help_export');
        
        $this->data['label_import']         = $this->language->get('label_import');
        $this->data['help_import']          = $this->language->get('help_import');
        
        $this->document->setTitle($this->language->get('heading_title'));
        
        $this->data['breadcrumbs'] = array();

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_home'),
            'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => false
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('text_module'),
            'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );

        $this->data['breadcrumbs'][] = array(
            'text'      => $this->language->get('heading_title'),
            'href'      => $this->url->link('module/openstock', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['cancel']       = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['export']       = $this->url->link('module/openstock/export', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['import']       = $this->url->link('module/openstock/import', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token']        = $this->session->data['token'];
        
        $this->template = 'module/openstock.tpl';
        $this->children = array(
                'common/header',
                'common/footer'
        );
        $this->response->setOutput($this->render());
    }
    
    public function install(){
        $this->load->model('openstock/openstock');
        
        $this->model_openstock_openstock->install();
    }
    
    public function uninstall(){        
        $this->load->model('openstock/openstock');
        
        $this->model_openstock_openstock->uninstall();
    }
    
    public function export(){
        $this->load->model('openstock/openstock');
        $this->load->model('openstock/csv');
        
        $this->model_openstock_csv->init();
        
        $this->model_openstock_csv->setHeading('VID #','SKU','Product name','Variant name','Stock','Price','Status');
        
        $products = $this->model_openstock_openstock->getProductsWithOptions();
        
        if($products != false)
        {
            foreach($products as $product)
            {
                foreach($product['options'] as $option)
                {
                    $this->model_openstock_csv->addLine(
                        $option['id'],
                        $option['sku'],
                        html_entity_decode($product['name']),
                        html_entity_decode($option['combi']),
                        $option['stock'], 
                        $option['price'], 
                        $option['active']
                    );
                }
            }

            $this->model_openstock_csv->output("D","OpenStock_export.csv");
            
            $this->model_openstock_csv->clear();
        }
    }
    
    public function import(){
        $this->load->language('module/openstock');
        
        if($this->request->server['REQUEST_METHOD'] != 'POST')
        {
            $this->session->data['error'] = $this->language->get('notice_error_nofile');
        }else{
            if($fp = fopen($_FILES['uploadFile']['tmp_name'],'r'))
            {
                $c = 0;
                while($csv_line = fgetcsv($fp,1024)) 
                {
                    if($c != 0)
                    {                        
                        $this->db->query("
                            UPDATE `".DB_PREFIX."product_option_relation` 
                            SET 
                                `stock` = '".(int)$csv_line['4']."', 
                                `price` = '".(float)$csv_line['5']."', 
                                `active` = '".(int)$csv_line['6']."' 
                            WHERE `id` = '".(int)$csv_line['0']."' 
                            LIMIT 1
                        ");
                    }
                    
                    $c++;
                }
                
                $this->session->data['success'] = $this->language->get('notice_success');
            }else{
                $this->session->data['error'] = $this->language->get('notice_error_fail');
            }
        }
        
        $this->redirect($this->url->link('module/openstock', 'token=' . $this->session->data['token'], 'SSL'));
    }
}
?>