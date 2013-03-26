<?php 
//-----------------------------------------------------
// Newsletter Enhancements for Opencart
// Created by DmitryNek
// exmail.Nek@gmail.com
//-----------------------------------------------------
?>
<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/ne/schedule.png" alt="" width="22" height="22" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="preview();" class="button"><span><?php echo $button_preview; ?></span></a><a onclick="$('#form').submit();" class="button"><span><?php echo $button_save; ?></span></a> <a onclick="location = '<?php echo $cancel; ?>';" class="button"><span><?php echo $button_cancel; ?></span></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <input type="hidden" name="date_next" value="<?php echo $date_next; ?>" />
        <table id="schedule" class="form">
          <tr>
				<td><?php echo $entry_active; ?></td>
				<td>
					<?php if($active) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="active_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="active_1" name="active" value="1" />
				<label for="active_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="active_0" name="active" value="0" />
				</td>
		  </tr>
          <tr>
			<td><span class="required">*</span> <?php echo $entry_name; ?></td>
			<td>
				<input type="text" name="name" value="<?php echo $name; ?>" size="60" />
				<?php if ($error_name) { ?>
					<span class="error"><?php echo $error_name; ?></span>
				<?php } ?>
			</td>
		  </tr>
		  <tr>
				<td><?php echo $entry_recurrent; ?></td>
				<td>
					<?php if($recurrent) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="recurrent_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="recurrent_1" name="recurrent" value="1" />
				<label for="recurrent_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="recurrent_0" name="recurrent" value="0" />
				</td>
		  </tr>
		  <tbody id="once">
			<tr>
			  <td><span class="required">*</span> <?php echo $entry_datetime; ?></td>
			  <td>
			  	<input type="text" name="date" value="<?php echo $date; ?>" class="date" />
			  	&nbsp;<?php echo $text_at; ?>&nbsp;
			  	<select name="time">
					<option value="0" <?php echo $time == '0' ? ' selected="selected"' : "" ?>>00:00</option>
					<option value="1" <?php echo $time == '1' ? ' selected="selected"' : "" ?>>01:00</option>
					<option value="2" <?php echo $time == '2' ? ' selected="selected"' : "" ?>>02:00</option>
					<option value="3" <?php echo $time == '3' ? ' selected="selected"' : "" ?>>03:00</option>
					<option value="4" <?php echo $time == '4' ? ' selected="selected"' : "" ?>>04:00</option>
					<option value="5" <?php echo $time == '5' ? ' selected="selected"' : "" ?>>05:00</option>
					<option value="6" <?php echo $time == '6' ? ' selected="selected"' : "" ?>>06:00</option>
					<option value="7" <?php echo $time == '7' ? ' selected="selected"' : "" ?>>07:00</option>
					<option value="8" <?php echo $time == '8' ? ' selected="selected"' : "" ?>>08:00</option>
					<option value="9" <?php echo $time == '9' ? ' selected="selected"' : "" ?>>09:00</option>
					<option value="10" <?php echo $time == '10' ? ' selected="selected"' : "" ?>>10:00</option>
					<option value="11" <?php echo $time == '11' ? ' selected="selected"' : "" ?>>11:00</option>
					<option value="12" <?php echo $time == '12' ? ' selected="selected"' : "" ?>>12:00</option>
					<option value="13" <?php echo $time == '13' ? ' selected="selected"' : "" ?>>13:00</option>
					<option value="14" <?php echo $time == '14' ? ' selected="selected"' : "" ?>>14:00</option>
					<option value="15" <?php echo $time == '15' ? ' selected="selected"' : "" ?>>15:00</option>
					<option value="16" <?php echo $time == '16' ? ' selected="selected"' : "" ?>>16:00</option>
					<option value="17" <?php echo $time == '17' ? ' selected="selected"' : "" ?>>17:00</option>
					<option value="18" <?php echo $time == '18' ? ' selected="selected"' : "" ?>>18:00</option>
					<option value="19" <?php echo $time == '19' ? ' selected="selected"' : "" ?>>19:00</option>
					<option value="20" <?php echo $time == '20' ? ' selected="selected"' : "" ?>>20:00</option>
					<option value="21" <?php echo $time == '21' ? ' selected="selected"' : "" ?>>21:00</option>
					<option value="22" <?php echo $time == '22' ? ' selected="selected"' : "" ?>>22:00</option>
					<option value="23" <?php echo $time == '23' ? ' selected="selected"' : "" ?>>23:00</option>
				</select>
        &nbsp;<?php echo $text_current_server_time; ?>
			  </td>
			</tr>
		  </tbody>
		  <tbody id="recurrent">
			<tr>
			  <td><?php echo $entry_frequency; ?></td>
			  <td>
			  	<select name="frequency">
					<option value="1" <?php echo $frequency == '1' ? ' selected="selected"' : "" ?>>
						<?php echo $text_daily; ?>
					</option>
					<option value="7" <?php echo $frequency == '7' ? ' selected="selected"' : "" ?>>
						<?php echo $text_weekly; ?>
					</option>
					<option value="30" <?php echo $frequency == '30' ? ' selected="selected"' : "" ?>>
						<?php echo $text_monthly; ?>
					</option>
				</select>
			  </td>
			</tr>
			<tr>
			  <td><?php echo $entry_daytime; ?></td>
			  <td>
			  	<select name="day" <?php echo ( $frequency == '1' ) ? 'disabled="disabled"' : '' ?>>
					<option value="1" <?php echo $day == '1' ? ' selected="selected"' : "" ?>><?php echo $text_monday; ?></option>
					<option value="2" <?php echo $day == '2' ? ' selected="selected"' : "" ?>><?php echo $text_tuesday; ?></option>
					<option value="3" <?php echo $day == '3' ? ' selected="selected"' : "" ?>><?php echo $text_wednesday; ?></option>
					<option value="4" <?php echo $day == '4' ? ' selected="selected"' : "" ?>><?php echo $text_thursday; ?></option>
					<option value="5" <?php echo $day == '5' ? ' selected="selected"' : "" ?>><?php echo $text_friday; ?></option>
					<option value="6" <?php echo $day == '6' ? ' selected="selected"' : "" ?>><?php echo $text_saturday; ?></option>
					<option value="0" <?php echo $day == '0' ? ' selected="selected"' : "" ?>><?php echo $text_sunday; ?></option>
					<?php if ( $frequency == '1' ) { ?>
					<option value="" selected="selected"><?php echo $text_daily; ?></option>
					<?php } ?>
				</select>
				&nbsp;<?php echo $text_at; ?>&nbsp;
				<select name="rtime">
					<option value="0" <?php echo $rtime == '0' ? ' selected="selected"' : "" ?>>00:00</option>
					<option value="1" <?php echo $rtime == '1' ? ' selected="selected"' : "" ?>>01:00</option>
					<option value="2" <?php echo $rtime == '2' ? ' selected="selected"' : "" ?>>02:00</option>
					<option value="3" <?php echo $rtime == '3' ? ' selected="selected"' : "" ?>>03:00</option>
					<option value="4" <?php echo $rtime == '4' ? ' selected="selected"' : "" ?>>04:00</option>
					<option value="5" <?php echo $rtime == '5' ? ' selected="selected"' : "" ?>>05:00</option>
					<option value="6" <?php echo $rtime == '6' ? ' selected="selected"' : "" ?>>06:00</option>
					<option value="7" <?php echo $rtime == '7' ? ' selected="selected"' : "" ?>>07:00</option>
					<option value="8" <?php echo $rtime == '8' ? ' selected="selected"' : "" ?>>08:00</option>
					<option value="9" <?php echo $rtime == '9' ? ' selected="selected"' : "" ?>>09:00</option>
					<option value="10" <?php echo $rtime == '10' ? ' selected="selected"' : "" ?>>10:00</option>
					<option value="11" <?php echo $rtime == '11' ? ' selected="selected"' : "" ?>>11:00</option>
					<option value="12" <?php echo $rtime == '12' ? ' selected="selected"' : "" ?>>12:00</option>
					<option value="13" <?php echo $rtime == '13' ? ' selected="selected"' : "" ?>>13:00</option>
					<option value="14" <?php echo $rtime == '14' ? ' selected="selected"' : "" ?>>14:00</option>
					<option value="15" <?php echo $rtime == '15' ? ' selected="selected"' : "" ?>>15:00</option>
					<option value="16" <?php echo $rtime == '16' ? ' selected="selected"' : "" ?>>16:00</option>
					<option value="17" <?php echo $rtime == '17' ? ' selected="selected"' : "" ?>>17:00</option>
					<option value="18" <?php echo $rtime == '18' ? ' selected="selected"' : "" ?>>18:00</option>
					<option value="19" <?php echo $rtime == '19' ? ' selected="selected"' : "" ?>>19:00</option>
					<option value="20" <?php echo $rtime == '20' ? ' selected="selected"' : "" ?>>20:00</option>
					<option value="21" <?php echo $rtime == '21' ? ' selected="selected"' : "" ?>>21:00</option>
					<option value="22" <?php echo $rtime == '22' ? ' selected="selected"' : "" ?>>22:00</option>
					<option value="23" <?php echo $rtime == '23' ? ' selected="selected"' : "" ?>>23:00</option>
				</select>
        &nbsp;<?php echo $text_current_server_time; ?>
			  </td>
			</tr>
		  </tbody>
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
                  <option value=""></option>
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
      <tbody id="random-setting">
      <tr>
				<td><?php echo $entry_random; ?></td>
				<td>
					<?php if($random) {
					$checked1 = ' checked="checked"';
					$checked0 = '';
					} else {
					$checked1 = '';
					$checked0 = ' checked="checked"';
					} ?>
				<label for="random_1"><?php echo $entry_yes; ?></label>
				<input type="radio"<?php echo $checked1; ?> id="random_1" name="random" value="1" />
				<label for="random_0"><?php echo $entry_no; ?></label>
				<input type="radio"<?php echo $checked0; ?> id="random_0" name="random" value="0" />
				</td>
			</tr>
      </tbody>
      <tbody id="random">
      <tr>
        <td><span class="required">*</span> <?php echo $entry_random_count; ?></td>
        <td><input type="text" name="random_count" value="<?php echo $random_count; ?>" size="3" /></td>
      </tr>
      </tbody>
      <tbody id="defined-setting">
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
      </tbody>
      <tbody id="defined-product">
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
		$('#schedule .to').hide();
		$('#schedule #to-' + $(this).attr('value').replace('_', '-')).show();
	});
	$('select[name=\'to\']').trigger('change');

	$('select[name=\'frequency\']').change(function() {
		var len = $('select[name=\'day\'] option').size();
		if ($(this).val() == '30' || $(this).val() == '1') {
			if (len == 8) {
				$('select[name=\'day\']').removeAttr('disabled');
				$('select[name=\'day\'] option:last').remove();
			}
			$('select[name=\'day\']').append($("<option></option>").attr("value", "").text('<?php echo $text_daily; ?>'));
			$('select[name=\'day\'] option:last').attr('selected', 'selected');
			$('select[name=\'day\']').attr('disabled', 'disabled');
		} else if (len == 8) {
			$('select[name=\'day\']').removeAttr('disabled');
			$('select[name=\'day\'] option:last').remove();
		}
	});

	$('input[name=\'recurrent\']').bind('click', function() {
		checkFreq();
	});

  $('select[name=\'language_id\'], select[name=\'template_id\']').bind('change', function(){
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
    getTemplate();
  });

  $('select[name=to]').bind('change', function(){
	  if ($(this).attr('value') == 'marketing' || $(this).attr('value') == 'marketing_all' || $(this).attr('value') == 'subscribe' || $(this).attr('value') == 'all') {
      if ($('.marketing_list' + $('select[name=store_id]').attr('value') + ' input:checkbox').size() == 0) {
        $('#to-marketing').hide();
      } else {
        $('#to-marketing').show();
      }
    }
  });

  if ($('input[name=recurrent]:checked').val() == 1)
  {
    $('#defined-setting').hide();
    $('#random-setting').show();
  }
  else
  {
    $('#random-setting').hide();
    $('#defined-setting').show();
  }

checkFreq();

  $('input[name=\'random\']').bind('click', function() {
    checkRandom();
  });

  $('input[name=\'defined\']').bind('click', function() {
    checkDefined();
  });

$('input[name=\'defined_categories\']').bind('click', function() {
  checkDefinedCategories();
});

  var subject = $('input[name=subject]').val();
  var message = '';
  for (instance in CKEDITOR.instances) {
    message = CKEDITOR.instances[instance].getData();
  }

  if (!subject.length && !message.length) {
    getTemplate();
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

      return false;
    }
  });

  $('#defined_product div img').live('click', function() {
    $(this).parent().remove();
    $('#defined_product div:odd').attr('class', 'odd');
    $('#defined_product div:even').attr('class', 'even');
  });

	$("[id^='defined_product_'].scrollbox div img").live('click', function() {
	  $(this).parent().remove();
	  $("[id^='defined_product_'].scrollbox div:odd").attr('class', 'odd');
	  $("[id^='defined_product_'].scrollbox div:even").attr('class', 'even');

	  getTemplate();
	});
	
	function checkFreq() {
		if ($('input[name=\'recurrent\']:checked').val() == 1) {
			$('#once').hide();
			$('#recurrent').show();

      $('#defined-setting').hide();
      $('#random-setting').show();
		} else {
			$('#recurrent').hide();
			$('#once').show();

      $('#random-setting').hide();
      $('#defined-setting').show();
		}

    checkDefined();
    checkRandom();
	}

  function checkRandom() {
    if ($('input[name=random]:checked').val() == 1 && $('input[name=recurrent]:checked').val() == 1)
    {
      $('#random').show();
    }
    else
    {
      $('#random').hide();
    }
  }

  function checkDefined() {
    if ($('input[name=defined]:checked').val() == 1 && $('input[name=recurrent]:checked').val() != 1)
    {
      $('#defined-product').show();
    }
    else
    {
      $('#defined-product').hide();
    }
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
}
checkDefinedCategories();

	function getTemplate() {
    $.ajax({
      type: 'post',
      url: 'index.php?route=ne/schedule/template&token=<?php echo $token; ?>',
      data: {
        template_id: $('select[name=template_id]').val(), 
        language_id: $('select[name=language_id]').val(),
        store_id: $('select[name=store_id]').val()
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

    var dialog = $('<div style="display:none;background:#ffffff;"></div>').appendTo('body').dialog({title: '<?php echo $text_loading; ?>', width: '800', height: '600', close: function(event, ui) { dialog.remove(); }, modal: true}).dialog('open');
    dialog.addClass('ne_loading');
    $.ajax({
      type: 'post',
      url: 'index.php?route=ne/newsletter/preview&token=<?php echo $token; ?>',
      data: {
        recurrent: $('input[name=recurrent]:checked').val(), 
        special: $('input[name=special]:checked').val(), 
        latest: $('input[name=latest]:checked').val(), 
        popular: $('input[name=popular]:checked').val(), 
        random: $('input[name=random]:checked').val(), 
        defined: defined_products,
		defined_more: defined_products_more,
		defined_categories: defined_categories,
        template_id: $('select[name=template_id]').val(), 
        language_id: $('select[name=language_id]').val(), 
        store_id: $('select[name=store_id]').val(),
        message: message, 
        subject: $('input[name=subject]').val(),
        random_count: $('input[name=random_count]').val()
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
  }
//--></script>
<script type="text/javascript"><!--
$(document).ready(function() {
	$('.date').datepicker({dateFormat: 'yy-mm-dd'});
});
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