<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php echo $header; ?>
  <style>#progressbar .ui-progressbar-value { background-color: #ccc; }  </style>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <?php if ($success) { ?>
  <div class="success"><?php echo $success; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/ne/boost.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
      <div class="buttons">
        <a onclick="preview();" class="button"><span><?php echo $button_preview; ?></span></a>
        <a onclick="$('#form').attr('action', '<?php echo $save; ?>');$('#form').submit();" class="button"><span><?php echo ($back ? $button_update : $button_save); ?></span></a>
        <a onclick="send()" class="button"><span><?php echo $button_send; ?></span></a>
        <a onclick="$('input[name=spam_check]').val('1');$('#form').attr('action', '<?php echo $action; ?>');$('#form').submit();" class="button"><span><?php echo $button_check; ?></span></a>
        <a onclick="location = '<?php echo ($back ? $back : $reset); ?>';" class="button"><span><?php echo ($back ? $button_back : $button_reset); ?></span></a>
      </div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
      	<input type="hidden" name="id" value="<?php echo $id; ?>" />
      	<input type="hidden" name="spam_check" value="" />
        <table id="mail" class="form">
          <tr>
            <td><?php echo $entry_template; ?></td>
            <td><select name="template_id">
                <?php foreach ($templates as $template) { ?>
                <?php if ($template['template_id'] == $template_id) { ?>
                <option value="<?php echo $template['template_id']; ?>" selected="selected"><?php echo $template['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $template['template_id']; ?>"><?php echo $template['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_language; ?></td>
            <td><select name="language_id">
                <?php foreach ($languages as $language) { ?>
                <?php if ($language['language_id'] == $language_id) { ?>
                <option value="<?php echo $language['language_id']; ?>" selected="selected"><?php echo $language['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $language['language_id']; ?>"><?php echo $language['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
            <td><?php echo $entry_store; ?></td>
            <td><select name="store_id">
                <?php array_unshift($stores, array('store_id' => 0, 'name' => $text_default)); ?>
                <?php foreach ($stores as $store) { ?>
                <?php if ($store['store_id'] == $store_id) { ?>
                <option value="<?php echo $store['store_id']; ?>" selected="selected"><?php echo $store['name']; ?></option>
                <?php } else { ?>
                <option value="<?php echo $store['store_id']; ?>"><?php echo $store['name']; ?></option>
                <?php } ?>
                <?php } ?>
              </select></td>
          </tr>
          <tr>
          	<td></td>
          	<td><p><?php echo $text_clear_warning; ?></p></td>
          </tr>
          <tr>
            <td><?php echo $entry_to; ?></td>
            <td><select name="to">
                <?php if ($to == 'newsletter') { ?>
                <option value="newsletter" selected="selected"><?php echo $text_newsletter; ?></option>
                <?php } else { ?>
                <option value="newsletter"><?php echo $text_newsletter; ?></option>
                <?php } ?>
                <?php if ($to == 'customer_all') { ?>
                <option value="customer_all" selected="selected"><?php echo $text_customer_all; ?></option>
                <?php } else { ?>
                <option value="customer_all"><?php echo $text_customer_all; ?></option>
                <?php } ?>
                <?php if ($to == 'customer_group') { ?>
                <option value="customer_group" selected="selected"><?php echo $text_customer_group; ?></option>
                <?php } else { ?>
                <option value="customer_group"><?php echo $text_customer_group; ?></option>
                <?php } ?>
                <?php if ($to == 'customer') { ?>
                <option value="customer" selected="selected"><?php echo $text_customer; ?></option>
                <?php } else { ?>
                <option value="customer"><?php echo $text_customer; ?></option>
                <?php } ?>
                <?php if ($to == 'affiliate_all') { ?>
                <option value="affiliate_all" selected="selected"><?php echo $text_affiliate_all; ?></option>
                <?php } else { ?>
                <option value="affiliate_all"><?php echo $text_affiliate_all; ?></option>
                <?php } ?>
                <?php if ($to == 'affiliate') { ?>
                <option value="affiliate" selected="selected"><?php echo $text_affiliate; ?></option>
                <?php } else { ?>
                <option value="affiliate"><?php echo $text_affiliate; ?></option>
                <?php } ?>
                <?php if ($to == 'product') { ?>
                <option value="product" selected="selected"><?php echo $text_product; ?></option>
                <?php } else { ?>
                <option value="product"><?php echo $text_product; ?></option>
                <?php } ?>
				<?php if ($to == 'marketing') { ?>
		            <option value="marketing" selected="selected"><?php echo $text_marketing; ?></option>
		        <?php } else { ?>
		        	<option value="marketing"><?php echo $text_marketing; ?></option>
		        <?php } ?>
				<?php if ($to == 'marketing_all') { ?>
		            <option value="marketing_all" selected="selected"><?php echo $text_marketing_all; ?></option>
		        <?php } else { ?>
		        	<option value="marketing_all"><?php echo $text_marketing_all; ?></option>
		        <?php } ?>
				<?php if ($to == 'subscriber') { ?>
		            <option value="subscriber" selected="selected"><?php echo $text_subscriber_all; ?></option>
		        <?php } else { ?>
		        	<option value="subscriber"><?php echo $text_subscriber_all; ?></option>
		        <?php } ?>
				<?php if ($to == 'all') { ?>
		            <option value="all" selected="selected"><?php echo $text_all; ?></option>
		        <?php } else { ?>
		        	<option value="all"><?php echo $text_all; ?></option>
		        <?php } ?>
              </select></td>
          </tr>
          <?php if ($list_data) { ?>
          <tbody id="to-marketing" class="to">
            <tr>
              <td><?php echo $entry_marketing; ?></td>
              <td>
                <?php foreach ($stores as $store) { ?>
                  <div class="scrollbox list_display marketing_list<?php echo $store['store_id']; ?>">
                    <?php $class = 'even'; ?>
                    <?php if (isset($list_data[$store['store_id']]) && $list_data[$store['store_id']]) foreach ($list_data[$store['store_id']] as $key => $list) { ?>
                    <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                    <div class="<?php echo $class; ?>">
                      <?php if ($marketing_list && is_array($marketing_list) && in_array($store['store_id'] . '_' . $key, $marketing_list)) { ?>
                      <label><input type="checkbox" name="marketing_list[]" value="<?php echo $store['store_id']; ?>_<?php echo $key; ?>" checked="checked" />
                      <?php echo $list[$this->config->get('config_language_id')]; ?></label>
                      <?php } else { ?>
                      <label><input type="checkbox" name="marketing_list[]" value="<?php echo $store['store_id']; ?>_<?php echo $key; ?>" />
                      <?php echo $list[$this->config->get('config_language_id')]; ?></label>
                      <?php } ?>
                    </div>
                    <?php } ?>
                  </div>
                <?php } ?>
              </td>
            </tr>
          </tbody>
          <?php } ?>
          <tbody id="to-customer-group" class="to">
            <tr>
              <td><?php echo $entry_customer_group; ?></td>
              <td><select name="customer_group_id">
                  <?php foreach ($customer_groups as $customer_group) { ?>
                  <?php if ($customer_group['customer_group_id'] == $customer_group_id && $to == 'customer_group') { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
            </tr>
          </tbody>
          <tbody id="to-customer" class="to">
            <tr>
              <td><?php echo $entry_customer; ?></td>
              <td><input type="text" name="customers" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div class="scrollbox" id="customer">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($customers as $customer) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="customer<?php echo $customer['customer_id']; ?>" class="<?php echo $class; ?>"><?php echo $customer['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="customer[]" value="<?php echo $customer['customer_id']; ?>" />
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
          </tbody>
          <tbody id="to-affiliate" class="to">
            <tr>
              <td><?php echo $entry_affiliate; ?></td>
              <td><input type="text" name="affiliates" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div class="scrollbox" id="affiliate">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($affiliates as $affiliate) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="affiliate<?php echo $affiliate['affiliate_id']; ?>" class="<?php echo $class; ?>"><?php echo $affiliate['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="affiliate[]" value="<?php echo $affiliate['affiliate_id']; ?>" />
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
          </tbody>
          <tbody id="to-product" class="to">
            <tr>
              <td><?php echo $entry_product; ?></td>
              <td><input type="text" name="products" value="" /></td>
            </tr>
            <tr>
              <td>&nbsp;</td>
              <td><div class="scrollbox" id="product">
                  <?php $class = 'odd'; ?>
                  <?php foreach ($products as $product) { ?>
                  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
                  <div id="product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>"><?php echo $product['name']; ?><img src="view/image/delete.png" />
                    <input type="hidden" name="product[]" value="<?php echo $product['product_id']; ?>" />
                  </div>
                  <?php } ?>
                </div></td>
            </tr>
          </tbody>
            <tr>
				<td><?php echo $entry_defined; ?></td>
				<td>
					<?php if($defined) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="defined_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="defined_1" name="defined" value="1" />
				<label for="defined_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="defined_0" name="defined" value="0" />
				</td>
			</tr>
			<tbody id="defined-product">
				<tr>
					<td><?php echo $entry_section_name; ?></td>
					<td><input type="text" size="60" name="defined_product_text" value="" />
				</tr>
				<tr>
					<td><?php echo $entry_product; ?></td>
					<td><input type="text" name="defined_products" value="" /></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<div class="scrollbox" id="defined_product">
							<?php $class = 'odd'; ?>
							<?php foreach ($defined_products as $product) { ?>
								<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
								<div id="defined_product<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>">
									<?php echo $product['name']; ?>
									<img src="view/image/delete.png" />
									<input type="hidden" name="defined_product[]" value="<?php echo $product['product_id']; ?>" />
								</div>
							<?php } ?>
						</div>
					</td>
				</tr>
				<?php foreach ($defined_products_more as $index => $dpm) { ?>
				  <tr>
					<td><?php echo $entry_section_name; ?></td>
					<td><input type="text" size="60" name="defined_product_more[<?php echo $index; ?>][text]" value="<?php echo $dpm['text']; ?>" /> <a onclick="removeSection(this);" class="button"><span><?php echo $button_remove; ?></span></a></td>
				  </tr>
				  <tr>
					<td><?php echo $entry_product; ?></td>
					<td><input type="text" name="defined_products_<?php echo $index; ?>" value="" data-id="<?php echo $index; ?>" /></td>
				  </tr>
				  <tr>
					<td>&nbsp;</td>
					<td>
					  <div class="scrollbox" id="defined_product_<?php echo $index; ?>">
						<?php $class = 'odd'; ?>
						<?php foreach ($dpm['products'] as $product) { ?>
						  <?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
						  <div id="defined_product_entry<?php echo $index; ?>_<?php echo $product['product_id']; ?>" class="<?php echo $class; ?>">
							<?php echo $product['name']; ?>
							<img src="view/image/delete.png" />
							<input type="hidden" name="defined_product_more[<?php echo $index; ?>][products][]" value="<?php echo $product['product_id']; ?>" />
						  </div>
						<?php } ?>
					  </div>
					</td>
				  </tr>
				<?php } ?>
				<tr>
				  <td></td>
				  <td class="left"><a onclick="addDefinedSection();" class="button"><span><?php echo $button_add_defined_section; ?></span></a></td>
				</tr>
			</tbody>
			<tr>
				<td><?php echo $entry_special; ?></td>
				<td>
					<?php if($special) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="special_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="special_1" name="special" value="1" />
				<label for="special_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="special_0" name="special" value="0" />
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_latest; ?></td>
				<td>
					<?php if($latest) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="latest_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="latest_1" name="latest" value="1" />
				<label for="latest_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="latest_0" name="latest" value="0" />
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_popular; ?></td>
				<td>
					<?php if($popular) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="popular_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="popular_1" name="popular" value="1" />
				<label for="popular_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="popular_0" name="popular" value="0" />
				</td>
			</tr>
			<tr>
				<td><?php echo $entry_defined_categories; ?></td>
				<td>
					<?php if($defined_categories) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="defined_categories_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="defined_categories_1" name="defined_categories" value="1" />
				<label for="defined_categories_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="defined_categories_0" name="defined_categories" value="0" />
				</td>
			</tr>
			<tbody id="defined-categories">
				<tr>
					<td>&nbsp;</td>
					<td><div class="scrollbox">
						<?php $class = 'odd'; ?>
						<?php foreach ($categories as $category) { ?>
							<?php $class = ($class == 'even' ? 'odd' : 'even'); ?>
							<div class="<?php echo $class; ?>">
								<?php if ($defined_category && is_array($defined_category) && in_array($category['category_id'], $defined_category)) { ?>
									<input type="checkbox" name="defined_category[]" value="<?php echo $category['category_id']; ?>" checked="checked" />
								<?php } else { ?>
									<input type="checkbox" name="defined_category[]" value="<?php echo $category['category_id']; ?>" />
								<?php } ?>
								<?php echo $category['name']; ?>
							</div>
					<?php } ?>
					</div>
				</tr>
			</tbody>
			<tr>
				<td><?php echo $entry_attachments; ?></td>
				<td>
					<table id="attachment">
						<tbody id="attachment_0">
							<tr>
								<td class="left"><input type="hidden" name="attachments_count" value="1" /><input type="file" name="attachment_0" value="" /></td>
								<td></td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td class="left"><a onclick="addFile();" class="button"><span><?php echo $button_add_file; ?></span></a></td>
								<td></td>
							</tr>
						</tfoot>
					</table>
				</td>
			</tr>
			<tr>
				<td><span class="required">*</span> <?php echo $entry_subject; ?></td>
				<td>
					<input type="text" name="subject" value="<?php echo $subject; ?>" size="60" />
					<?php if ($error_subject) { ?>
						<span class="error"><?php echo $error_subject; ?></span>
					<?php } ?>
				</td>
			</tr>
			<tr>
				<td><span class="required">*</span> <?php echo $entry_message; ?></td>
				<td>
					<textarea name="message"><?php echo $message; ?></textarea>
					<?php if ($error_message) { ?>
						<span class="error"><?php echo $error_message; ?></span>
					<?php } ?>
					<p><?php echo $text_message_info; ?></p>
				</td>
			</tr>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript" src="view/javascript/ckeditor/ckeditor.js"></script> 
<script type="text/javascript"><!--
    
    
        $.fn.serializeObject = function()
        {
            var o = {};
            var a = this.serializeArray();
            $.each(a, function() {
                if (o[this.name] !== undefined) {
                    if (!o[this.name].push) {
                        o[this.name] = [o[this.name]];
                    }
                    o[this.name].push(this.value || '');
                } else {
                    o[this.name] = this.value || '';
                }
            });
            return o;
        };    
    
	$(document).ready(function() {


            $('input[name=defined]').bind('click', function() {
                    checkDefined();
            });

            $('input[name=defined_categories]').bind('click', function() {
                    checkDefinedCategories();
            });

            $('input[name=special], input[name=latest], input[name=popular]').bind('click', function() {
                    getTemplate();
            });

            $('select[name=language_id], select[name=template_id]').bind('change', function(){
                    getDefinedText();
                    getTemplate(true);
            });

            $('select[name=customer_group_id]').bind('change', function(){
                getTemplate();
            });

            $('input[name="defined_category[]"]').bind('click', function(){
                    getTemplate();
            });

            $('.list_display').hide();
            $('.marketing_list' + $('select[name=store_id]').attr('value')).show();

            $('select[name=store_id]').bind('change', function(){
                $('.list_display').hide();
                $('.list_display input:checkbox').removeAttr('checked');

		if ($('select[name=to]').attr('value') == 'marketing' || $('select[name=to]').attr('value') == 'marketing_all' || $('select[name=to]').attr('value') == 'subscriber' || $('select[name=to]').attr('value') == 'all') {
                if ($('.marketing_list' + $(this).attr('value') + ' input:checkbox').size() == 0) {
                    $('#to-marketing').hide();
                } else {
                    $('#to-marketing').show();
                }  
            }
      
            $('.marketing_list' + $(this).attr('value')).show();
                getTemplate(true);
            });
            

            $('select[name=to]').bind('change', function(){
                    if ($(this).attr('value') == 'marketing' || $(this).attr('value') == 'marketing_all' || $(this).attr('value') == 'subscriber' || $(this).attr('value') == 'all') {
                if ($('.marketing_list' + $('select[name=store_id]').attr('value') + ' input:checkbox').size() == 0) {
                $('#to-marketing').hide();
                } else {
                $('#to-marketing').show();
                }
            }
            getTemplate();
            });

            if ($('input[name=defined]:checked').val() == 1)
            {
                    $('#defined-product').show();
            }
            else
            {
                    $('#defined-product').hide();
            }

            if ($('input[name=defined_categories]:checked').val() == 1)
            {
                    $('#defined-categories').show();
            }
            else
            {
                    $('#defined-categories').hide();
            }

            $('input[name=\'defined_products\']').autocomplete({
                    delay: 0,
                    source: function(request, response) {
                            $.ajax({
                                    url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
                                    dataType: 'json',
                                    data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
                                    type: 'POST',
                                    success: function(json) {		
                                            response($.map(json, function(item) {
                                                    return {
                                                            label: item.name,
                                                            value: item.product_id
                                                    }
                                            }));
                                    }
                            });
                    }, 
                    select: function(event, ui) {
                            $('#defined_product' + ui.item.value).remove();
                            $('#defined_product').append('<div id="defined_product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="defined_product[]" value="' + ui.item.value + '" /></div>');
                            $('#defined_product div:odd').attr('class', 'odd');
                            $('#defined_product div:even').attr('class', 'even');

                            getTemplate();
                            return false;
                    }
            });

            $('#defined_product div img').live('click', function() {
                    $(this).parent().remove();
                    $('#defined_product div:odd').attr('class', 'odd');
                    $('#defined_product div:even').attr('class', 'even');

                    getTemplate();
            });

            $("[id^='defined_product_'].scrollbox div img").live('click', function() {
                    $(this).parent().remove();
                    $("[id^='defined_product_'].scrollbox div:odd").attr('class', 'odd');
                    $("[id^='defined_product_'].scrollbox div:even").attr('class', 'even');

                    getTemplate();
            });

            if (!$('textarea[name=message]').val()) {
                    getTemplate();
            }

            $('.file_remove').live('click', function(){
                    removeFile($(this).attr("alt"));
            });

            getDefinedText();
	});

	function getDefinedText() {
		$.ajax({
			type: 'post',
			url: 'index.php?route=ne/newsletter/get_defined_text&token=<?php echo $token; ?>',
			data: {
				template_id: $('select[name=template_id]').val(),
				language_id: $('select[name=language_id]').val()
			},
			dataType: 'json',
			success: function(json) {
				$('input[name=defined_product_text]').val(json.text);
			}
		});
	}

	function getTemplate(clear) {
		var defined_products = [];
		if ($('input[name=defined]:checked').val() == 1) {
			$('#defined_product input').each(function(id) { 
				var item = $('#defined_product input').get(id); 
				defined_products.push(item.value);
			});
		}

		var defined_products_more = [];
		if ($('input[name=defined]:checked').val() == 1) {
			for (var i = 0; i < defined_section_row; i++) {
			  defined_products_more[i] = {
				'text' : $('input[name="defined_product_more[' + i + '][text]"]').val(),
				'products' : []
			  };
			  $('#defined_product_' + i + ' input').each(function(id) {
				var item = $('#defined_product_' + i + ' input').get(id);
				defined_products_more[i]['products'].push(item.value);
			  });
			}
		}

		var defined_categories = [];
		if ($('input[name=defined_categories]:checked').val() == 1) {
			$('input[name="defined_category[]"]:checked').each(function(){
				defined_categories.push($(this).val());
			});
		}

		var message = '';
		for (instance in CKEDITOR.instances) {
			message = CKEDITOR.instances[instance].getData();
		}
		
		$.ajax({
			type: 'post',
			url: 'index.php?route=ne/newsletter/template&token=<?php echo $token; ?>',
			data: {
				special: $('input[name=special]:checked').val(), 
				latest: $('input[name=latest]:checked').val(), 
				popular: $('input[name=popular]:checked').val(), 
				defined: defined_products,
				defined_text: $('input[name=defined_product_text]').val(),
				defined_more: defined_products_more,
				defined_categories: defined_categories,
				to: $('select[name=to]').val(), 
				template_id: $('select[name=template_id]').val(), 
				language_id: $('select[name=language_id]').val(),
				customer_group_id: ($('select[name=customer_group_id]').length ? $('select[name=customer_group_id]').val() : ''),
				store_id: $('select[name=store_id]').val(),
				message: message, 
				subject: $('input[name=subject]').val(), 
				clear: clear
			},
			dataType: 'json',
			success: function(json) {
				$('input[name=subject]').val(json.subject);
				for (instance in CKEDITOR.instances) {
					CKEDITOR.instances[instance].setData(json.body);
				}
			}
		});
	}
        
        
        function send(){

            var dialog = $('<div><div class="ne_status">- de -</div><div id="progressbar"></div></div>').appendTo('body').dialog({title: '<?php echo $text_loading; ?>', width: '260', height: '100', close: function(event, ui) { dialog.remove(); }, modal: true}).dialog('open');

            var message = '';
            for (instance in CKEDITOR.instances) {
                    message = CKEDITOR.instances[instance].getData();
            }
            
            dialog.dialog('option', 'title', "Enviando Newsletters");
            $("#progressbar").progressbar({ value: false });
            
            function resend(){
                
                
                var postForms = $('#form').serializeObject();
                postForms["message"] = message;
                
                
                $.post("index.php?route=ne/newsletter&token=<?php echo $token; ?>",postForms,function(status){

                    var verify = status;

                    if(verify != "redirect"){

                        eval("var o = " + status);

                        $(".ne_status").html(o.sent + " de " + o.all);

                        $("#progressbar").progressbar( "option", {
                            value: Math.floor( ( o.sent * 100 ) / o.all )
                        });

                        setTimeout(function(){
                            resend();
                        },10000);

                    }else{
                        location.reload(true);
                    }

                });
            
            }
            
            resend();

        }
        

	function preview() {
		var defined_products = [];
		if ($('input[name=defined]:checked').val() == 1) {
			$('#defined_product input').each(function(id) { 
				var item = $('#defined_product input').get(id); 
				defined_products.push(item.value);
			});
		}

		var defined_products_more = [];
		if ($('input[name=defined]:checked').val() == 1) {
			for (var i = 0; i < defined_section_row; i++) {
			  defined_products_more[i] = {
				'text' : $('input[name="defined_product_more[' + i + '][text]"]').val(),
				'products' : []
			  };
			  $('#defined_product_' + i + ' input').each(function(id) {
				var item = $('#defined_product_' + i + ' input').get(id);
				defined_products_more[i]['products'].push(item.value);
			  });
			}
		}

		var defined_categories = [];
		if ($('input[name=defined_categories]:checked').val() == 1) {
			$('input[name="defined_category[]"]:checked').each(function(){
				defined_categories.push($(this).val());
			});
		}

		var message = '';
		for (instance in CKEDITOR.instances) {
			message = CKEDITOR.instances[instance].getData();
		}

		var dialog = $('<div style="display:none;background:#ffffff;" class="ne_loading"></div>').appendTo('body').dialog({title: '<?php echo $text_loading; ?>', width: '800', height: '600', close: function(event, ui) { dialog.remove(); }, modal: true}).dialog('open');
		dialog.addClass('ne_loading');
		$.ajax({
			type: 'post',
			url: 'index.php?route=ne/newsletter/preview&token=<?php echo $token; ?>',
			data: {
				special: $('input[name=special]:checked').val(), 
				latest: $('input[name=latest]:checked').val(), 
				popular: $('input[name=popular]:checked').val(), 
				defined: defined_products,
				defined_text: $('input[name=defined_product_text]').val(),
				defined_more: defined_products_more,
				defined_categories: defined_categories,
				template_id: $('select[name=template_id]').val(), 
				language_id: $('select[name=language_id]').val(),
				customer_group_id: ($('select[name=customer_group_id]').length ? $('select[name=customer_group_id]').val() : ''),
				store_id: $('select[name=store_id]').val(),
				message: message, 
				subject: $('input[name=subject]').val()
			},
			dataType: 'json',
			success: function(data) {
				dialog.dialog('option', 'title', data.subject);
				dialog.removeClass('ne_loading');
				dialog.html(data.body);
			}
		});
	}

	$('input[name^=\'defined_products_\']').autocomplete({
		delay: 0,
		source: function(request, response) {
		  $.ajax({
			url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			dataType: 'json',
			data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
			type: 'POST',
			success: function(json) {
			  response($.map(json, function(item) {
				return {
				  label: item.name,
				  value: item.product_id
				}
			  }));
			}
		  });
		},
		select: function(event, ui) {
		  var id = $(this).attr('data-id');

		  $('#defined_product_entry' + id + '_' + ui.item.value).remove();
		  $('#defined_product_' + id).append('<div id="defined_product_entry' + id + '_' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="defined_product_more[' + id + '][products][]" value="' + ui.item.value + '" /></div>');
		  $('#defined_product_' + id + ' div:odd').attr('class', 'odd');
		  $('#defined_product_' + id + ' div:even').attr('class', 'even');

		  getTemplate();
		  return false;
		}
	  });

	  var defined_section_row = <?php echo max(count($defined_products_more), 0); ?>;

	  function addDefinedSection() {

		html  = '<tr>';
		html += '<td><?php echo $entry_section_name; ?></td>';
		html += '<td><input type="text" size="60" name="defined_product_more[' + defined_section_row + '][text]" value="" /> <a onclick="removeSection(this);" class="button"><span><?php echo $button_remove; ?></span></a></td>';
		html += '</tr>';
		html += '<tr>';
		html += '<td><?php echo $entry_product; ?></td>';
		html += '<td><input type="text" name="defined_products_' + defined_section_row + '" value="" data-id="' + defined_section_row + '" /></td>';
		html += '</tr>';
		html += '<tr>';
		html += '<td>&nbsp;</td>';
		html += '<td>';
		html += '<div class="scrollbox" id="defined_product_' + defined_section_row + '">';
		html += '</div>';
		html += '</td>';
		html += '</tr>';

		$('#defined-product tr:last-child').before(html);

		$('input[name=\'defined_products_' + defined_section_row + '\']').autocomplete({
		  delay: 0,
		  source: function(request, response) {
			$.ajax({
			  url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
			  dataType: 'json',
			  data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
			  type: 'POST',
			  success: function(json) {
				response($.map(json, function(item) {
				  return {
					label: item.name,
					value: item.product_id
				  }
				}));
			  }
			});
		  },
		  select: function(event, ui) {
			var id = $(this).attr('data-id');

			$('#defined_product_entry' + id + '_' + ui.item.value).remove();
			$('#defined_product_' + id).append('<div id="defined_product_entry' + id + '_' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="defined_product_more[' + id + '][products][]" value="' + ui.item.value + '" /></div>');
			$('#defined_product_' + id + ' div:odd').attr('class', 'odd');
			$('#defined_product_' + id + ' div:even').attr('class', 'even');

			getTemplate();
			return false;
		  }
		});

		defined_section_row++;
        }

        function removeSection(el) {
            var tr = $(el).closest("tr");
            tr.next().remove();
            tr.next().remove();
            tr.remove();
            defined_section_row--;

            getTemplate();
        }

        var attachment_row = 1;

        function addFile() {
            html  = '<tbody id="attachment_' + attachment_row + '">';
            html += '<tr>';	
            html += '<td class="left"><input type="file" name="attachment_' + attachment_row + '" value="" /></td>';
            html += '<td class="left"><img class="file_remove" alt="attachment_' + attachment_row + '" src="view/image/delete.png" /></td>';
            html += '</tr>';	
        html += '</tbody>';

            $('#attachment tfoot').before(html);

            attachment_row++;

            $('input[name=attachments_count]').val(attachment_row);
        }

        function removeFile(row) {
		$('#' + row).remove();
		attachment_row--;
		$('input[name=attachments_count]').val(attachment_row);
	}

	function checkDefined() {
		if ($('input[name=defined]:checked').val() == 1)
		{
			$('#defined-product').show();
		}
		else
		{
			$('#defined-product').hide();
		}
		getTemplate();
	}

	function checkDefinedCategories() {
		if ($('input[name=defined_categories]:checked').val() == 1)
		{
			$('#defined-categories').show();
		}
		else
		{
			$('#defined-categories').hide();
		}
		getTemplate();
	}
//--></script>

				
<script type="text/javascript"><!--
	CKEDITOR.replace('message', {
		height:'500',
		filebrowserBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashBrowseUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserImageUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>',
		filebrowserFlashUploadUrl: 'index.php?route=common/filemanager&token=<?php echo $token; ?>'
	});
//--></script> 

<script type="text/javascript"><!--	
	$('select[name=\'to\']').bind('change', function() {
		$('#mail .to').hide();
		$('#mail #to-' + $(this).attr('value').replace('_', '-')).show();
	});

	$('select[name=\'to\']').trigger('change');
//--></script>

<script type="text/javascript"><!--
	$.widget('custom.catcomplete', $.ui.autocomplete, {
		_renderMenu: function(ul, items) {
			var self = this, currentCategory = '';
			
			$.each(items, function(index, item) {
				if (item.category != currentCategory) {
					ul.append('<li class="ui-autocomplete-category">' + item.category + '</li>');
					
					currentCategory = item.category;
				}
				
				self._renderItem(ul, item);
			});
		}
	});

	$('input[name=\'customers\']').catcomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=sale/customer/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
        data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
        type: 'POST',
				success: function(json) {	
					response($.map(json, function(item) {
						return {
							category: item.customer_group,
							label: item.name,
							value: item.customer_id
						}
					}));
				}
			});
			
		}, 
		select: function(event, ui) {
			$('#customer' + ui.item.value).remove();
			
			$('#customer').append('<div id="customer' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="customer[]" value="' + ui.item.value + '" /></div>');

			$('#customer div:odd').attr('class', 'odd');
			$('#customer div:even').attr('class', 'even');
					
			return false;
		}
	});

	$('#customer div img').live('click', function() {
		$(this).parent().remove();
		
		$('#customer div:odd').attr('class', 'odd');
		$('#customer div:even').attr('class', 'even');	
	});
//--></script> 

<script type="text/javascript"><!--	
	$('input[name=\'affiliates\']').autocomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=sale/affiliate/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
        data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
        type: 'POST',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.affiliate_id
						}
					}));
				}
			});
			
		}, 
		select: function(event, ui) {
			$('#affiliate' + ui.item.value).remove();
			
			$('#affiliate').append('<div id="affiliate' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="affiliate[]" value="' + ui.item.value + '" /></div>');

			$('#affiliate div:odd').attr('class', 'odd');
			$('#affiliate div:even').attr('class', 'even');
					
			return false;
		}
	});

	$('#affiliate div img').live('click', function() {
		$(this).parent().remove();
		
		$('#affiliate div:odd').attr('class', 'odd');
		$('#affiliate div:even').attr('class', 'even');	
	});

	$('input[name=\'products\']').autocomplete({
		delay: 0,
		source: function(request, response) {
			$.ajax({
				url: 'index.php?route=catalog/product/autocomplete&token=<?php echo $token; ?>&filter_name=' +  encodeURIComponent(request.term),
				dataType: 'json',
        data: {token: '<?php echo $token; ?>', filter_name: encodeURIComponent(request.term)},
        type: 'POST',
				success: function(json) {		
					response($.map(json, function(item) {
						return {
							label: item.name,
							value: item.product_id
						}
					}));
				}
			});
		}, 
		select: function(event, ui) {
			$('#product' + ui.item.value).remove();
			
			$('#product').append('<div id="product' + ui.item.value + '">' + ui.item.label + '<img src="view/image/delete.png" /><input type="hidden" name="product[]" value="' + ui.item.value + '" /></div>');

			$('#product div:odd').attr('class', 'odd');
			$('#product div:even').attr('class', 'even');
					
			return false;
		}
	});

	$('#product div img').live('click', function() {
		$(this).parent().remove();
		
		$('#product div:odd').attr('class', 'odd');
		$('#product div:even').attr('class', 'even');	
	});
//--></script> 
<?php echo $footer; ?>