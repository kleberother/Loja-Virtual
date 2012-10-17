<div class="left">
  <span class="required">*</span> <?php echo $entry_firstname; ?><br />
  <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" /><br />
</div>
<div class="left">
  <span class="required">*</span> <?php echo $entry_lastname; ?><br />
  <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" /><br />
</div>
<div style="clear:both;"></div>
<?php if($this->config->get('quickcheckout_company')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_email; ?><br />
  <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" /><br />
</div>
<div class="left">
  <?php echo $entry_company; ?><br />
  <input type="text" name="company" value="<?php echo $company; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div style="margin-bottom: 20px;">
  <span class="required">*</span> <?php echo $entry_email; ?><br />
  <input type="text" name="email" value="<?php echo $email; ?>" class="large-field" /><br />
  <input style="display:none" type="text" name="company" value="<?php echo $company; ?>" class="large-field" />
</div>
<?php } ?>
<div style="clear:both;"></div>
<div class="left" style="display: <?php echo (count($customer_groups) > 1 ? 'block' : 'none'); ?>;"><?php echo $entry_account; ?><br />
    <select name="customer_group_id" class="large-field">
      <?php foreach ($customer_groups as $customer_group) { ?>
      <?php if ($customer_group['customer_group_id'] == $customer_group_id) { ?>
      <option value="<?php echo $customer_group['customer_group_id']; ?>" selected="selected"><?php echo $customer_group['name']; ?></option>
      <?php } else { ?>
      <option value="<?php echo $customer_group['customer_group_id']; ?>"><?php echo $customer_group['name']; ?></option>
      <?php } ?>
      <?php } ?>
    </select>
</div>
<div id="company-id-display" class="left">
	<span id="company-id-required" class="required">*</span> <?php echo $entry_company_id; ?><br />
	<input type="text" name="company_id" value="<?php echo $company_id; ?>" class="large-field" /><br />
</div>
<div id="tax-id-display" class="left">
	<span id="tax-id-required" class="required">*</span> <?php echo $entry_tax_id; ?><br />
    <input type="text" name="tax_id" value="<?php echo $tax_id; ?>" class="large-field" /><br />
</div>
<div class="left">
  <span class="required">*</span> <?php echo $entry_address_1; ?><br />
  <input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" /><br />
</div>
<?php if ($this->config->get('quickcheckout_address_2')) { ?>
<div class="left">
  <?php echo $entry_address_2; ?><br />
  <input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" /><br />
</div>
<div class="left">
  <span class="required">*</span> <?php echo $entry_telephone; ?><br />
  <input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
	<div class="left">
		<span class="required">*</span> <?php echo $entry_telephone; ?><br />
		<input type="text" name="telephone" value="<?php echo $telephone; ?>" class="large-field" /><br />
		<input type="text" style="display:none;" name="address_2" value="<?php echo $address_2; ?>" class="large-field" />
	</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_fax')) { ?>
<div class="left">
  <?php echo $entry_fax; ?><br />
  <input type="text" name="fax" value="<?php echo $fax; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
	<input style="display:none;" type="text" name="fax" value="<?php echo $fax; ?>" class="large-field" />
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_city')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_city; ?><br />
  <input type="text" name="city" value="<?php echo $city; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
  <input type="text" style="display:none;" name="city" value="<?php echo $city; ?>" class="large-field" />
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_postcode')) { ?>
<div class="left">
  <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />
  <input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
  <input type="text" style="display:none;" name="postcode" value="<?php echo $postcode; ?>" class="large-field" />
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_country')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_country; ?><br />
	<select name="country_id" class="large-field">
		<?php foreach ($countries as $country) { ?>
			<?php if ($country['country_id'] == $country_id) { ?>
				<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
			<?php } else { ?>
				<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
			<?php } ?>
		<?php } ?>
  </select><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
	<select style="display:none;" name="country_id" class="large-field">
		<?php foreach ($countries as $country) { ?>
			<?php if ($country['country_id'] == $country_id) { ?>
				<option value="<?php echo $country['country_id']; ?>" selected="selected"><?php echo $country['name']; ?></option>
			<?php } else { ?>
				<option value="<?php echo $country['country_id']; ?>"><?php echo $country['name']; ?></option>
			<?php } ?>
		<?php } ?>
  </select>
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_zone')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_zone; ?><br />
  <select name="zone_id" class="large-field">
  </select><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
  <select style="display:none;" name="zone_id" class="large-field">
  </select>
</div>
<?php } ?>
<div style="clear:both;"></div>

  <br />
  <br />
  <br />
<?php if ($shipping_required) { ?>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #DDDDDD;">
  <?php if (!$guest_checkout) { ?>
	  <input type="checkbox" name="create_account" value="1" id="create" checked="checked" style="display:none;"/>
	  <div id="create_account"></div>
  <?php } else { ?>
	  <input type="checkbox" name="create_account" value="1" id="create" /> <label for="create"><?php echo $text_create_account; ?></label><br />
	  <div id="create_account"></div>
  <?php } ?>
  <?php if ($shipping_address) { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" checked="checked" />
  <?php } else { ?>
  <input type="checkbox" name="shipping_address" value="1" id="shipping" />
  <?php } ?>
  <label for="shipping"><?php echo $entry_shipping; ?></label>
  <br />
  <br />
  <br />
</div>
<?php } else { ?>
<div style="clear: both; padding-top: 15px; border-top: 1px solid #DDDDDD;">
  <?php if (!$guest_checkout) { ?>
	  <input type="checkbox" name="create_account" value="1" id="create" checked="checked" style="display:none;"/>
	  <div id="create_account"></div>
  <?php } else { ?>
	  <input type="checkbox" name="create_account" value="1" id="create" /> <label for="create"><?php echo $text_create_account; ?></label><br />
	  <div id="create_account"></div>
  <?php } ?>
  <br />
</div>
<?php } ?>
<script type="text/javascript"><!--
$('#payment-address select[name=\'customer_group_id\']').live('change', function() {
	var customer_group = [];
	
<?php foreach ($customer_groups as $customer_group) { ?>
	customer_group[<?php echo $customer_group['customer_group_id']; ?>] = [];
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_display'] = '<?php echo $customer_group['company_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['company_id_required'] = '<?php echo $customer_group['company_id_required']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_display'] = '<?php echo $customer_group['tax_id_display']; ?>';
	customer_group[<?php echo $customer_group['customer_group_id']; ?>]['tax_id_required'] = '<?php echo $customer_group['tax_id_required']; ?>';
<?php } ?>	

	if (customer_group[this.value]) {
		if (customer_group[this.value]['company_id_display'] == '1') {
			$('#company-id-display').show();
		} else {
			$('#company-id-display').hide();
		}
		
		if (customer_group[this.value]['company_id_required'] == '1') {
			$('#company-id-required').show();
		} else {
			$('#company-id-required').hide();
		}
		
		if (customer_group[this.value]['tax_id_display'] == '1') {
			$('#tax-id-display').show();
		} else {
			$('#tax-id-display').hide();
		}
		
		if (customer_group[this.value]['tax_id_required'] == '1') {
			$('#tax-id-required').show();
		} else {
			$('#tax-id-required').hide();
		}	
	}
});

$('#payment-address select[name=\'customer_group_id\']').trigger('change');
//--></script>  
<script type="text/javascript"><!--
$('#payment-address select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#payment-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#payment-postcode-required').show();
			} else {
				$('#payment-postcode-required').hide();
			}
			
			html = '<option value=""><?php echo $text_select; ?></option>';
			
			if (json['zone'] != '') {
				for (i = 0; i < json['zone'].length; i++) {
        			html += '<option value="' + json['zone'][i]['zone_id'] + '"';
	    			
					if (json['zone'][i]['zone_id'] == '<?php echo $zone_id; ?>') {
	      				html += ' selected="selected"';
	    			}
	
	    			html += '>' + json['zone'][i]['name'] + '</option>';
				}
			} else {
				html += '<option value="0" selected="selected"><?php echo $text_none; ?></option>';
			}
			
			$('#payment-address select[name=\'zone_id\']').html(html);
			
			if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
				reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
				reloadShippingMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
			} else {
				reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#payment-address select[name=\'country_id\']').trigger('change');

// Guest Shipping Form
$('#payment-address input[name=\'shipping_address\']').live('change', function() {
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		$('#shipping-address').slideUp('slow');
		
		reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
		reloadShippingMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(),$('#payment-address input[name=\'postcode\']').val());	

	} else {
		$('#shipping-address').slideDown('slow');
		$.ajax({
			url: 'index.php?route=quickcheckout/guest_shipping',
			dataType: 'html',
			beforeSend: function() {
				$('#shipping-address .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			success: function(html) {
				$('#shipping-address .quickcheckout-content').html(html);
					
				$('#shipping-address .quickcheckout-content').slideDown('slow');
				
				reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
				reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());	
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
});	
$('#payment-address input[name=\'shipping_address\']').trigger('change');

$('#payment-address select[name=\'zone_id\']').bind('change', function() {
	if ($('#payment-address input[name=\'shipping_address\']:checked').attr('value')) {
		reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
		reloadShippingMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
	} else {
		reloadPaymentMethod($('#payment-address select[name=\'country_id\']').val(), $('#payment-address select[name=\'zone_id\']').val(), 1 , $('#payment-address input[name=\'city\']').val(), $('#payment-address input[name=\'postcode\']').val());
	}
});

$('#payment-address select[name=\'zone_id\']').trigger('change');

// Create account
$('#payment-address input[name=\'create_account\']').live('change', function() {
	if ($('#payment-address input[name=\'create_account\']:checked').attr('value')) {
		$('#create_account').slideDown('slow');
		$.ajax({
			url: 'index.php?route=quickcheckout/register',
			dataType: 'html',
			beforeSend: function() {
				$('#create_account').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			success: function(html) {
				$('#create_account').html(html);
				$('#create_account').slideDown('slow');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	} else {
		$('#create_account').slideUp('slow');
	}
});	
$('#payment-address input[name=\'create_account\']').trigger('change');
//--></script>