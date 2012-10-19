<?php  
/**
 * Wholesaleview controller class
 * 
 * Created by James Allsup / Welford Media
 * http://www.welfordmedia.co.uk / http://support.welfordmedia.co.uk
 */
class ControllerModuleWholesaleview extends Controller 
{
    public function index(){
        $this->load->language('module/wholesaleview');
        
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
            'href'      => $this->url->link('module/wholesaleview', 'token=' . $this->session->data['token'], 'SSL'),
            'separator' => ' :: '
        );
        
        $this->data['cancel']       = $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['export']       = $this->url->link('module/wholesaleview/export', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['import']       = $this->url->link('module/wholesaleview/import', 'token=' . $this->session->data['token'], 'SSL');
        $this->data['token']        = $this->session->data['token'];
        
        $this->template = 'module/wholesaleview.tpl';
        $this->children = array(
                'common/header',
                'common/footer'
        );
        $this->response->setOutput($this->render());
    }
    
    public function install(){
        $this->load->model('wholesaleview/wholesaleview');
        
        $this->model_wholesaleview_wholesaleview->install();
    }
    
    public function uninstall(){        
        $this->load->model('wholesaleview/wholesaleview');
        
        $this->model_wholesaleview_wholesaleview->uninstall();
    }   
}
?>