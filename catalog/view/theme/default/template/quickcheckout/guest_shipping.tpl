<div class="left">
  <span class="required">*</span> <?php echo $entry_firstname; ?><br />
  <input type="text" name="firstname" value="<?php echo $firstname; ?>" class="large-field" />
</div>
<div class="left">
  <span class="required">*</span> <?php echo $entry_lastname; ?><br />
  <input type="text" name="lastname" value="<?php echo $lastname; ?>" class="large-field" />
</div>
<div style="clear:both;"></div>
<?php if ($this->config->get('quickcheckout_address_2')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_address_1; ?><br />
  <input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" /><br />
</div>
<div class="left">
	<?php echo $entry_address_2; ?><br />
	<input type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div style="margin-bottom:20px;">
  <span class="required">*</span> <?php echo $entry_address_1; ?><br />
  <input type="text" name="address_1" value="<?php echo $address_1; ?>" class="large-field" />
  <input style="display:none" type="text" name="address_2" value="<?php echo $address_2; ?>" class="large-field" />
</div>
<?php } ?>
<div style="clear:both;"></div>
<?php if ($this->config->get('quickcheckout_company')) { ?>
<div class="left">
  <?php echo $entry_company; ?><br />
  <input type="text" name="company" value="<?php echo $company; ?>" class="large-field" /><br />
</div>
<?php } else { ?>
<div style="display:none;" class="left">
  <input style="display:none;" type="text" name="company" value="<?php echo $company; ?>" class="large-field" />
</div>
<?php } ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_city; ?><br />
  <input type="text" name="city" value="<?php echo $city; ?>" class="large-field" />
</div>
<div class="left">
  <span id="shipping-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />
  <input type="text" name="postcode" value="<?php echo $postcode; ?>" class="large-field" />
</div>
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
    </select>
</div>
<div class="left">
  <span class="required">*</span> <?php echo $entry_zone; ?><br />
  <select name="zone_id" class="large-field">
  </select>
</div>
<div style="clear:both;"></div>
 
<script type="text/javascript"><!--
$('#shipping-address select[name=\'country_id\']').bind('change', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/checkout/country&country_id=' + this.value,
		dataType: 'json',
		beforeSend: function() {
			$('#shipping-address select[name=\'country_id\']').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},
		complete: function() {
			$('.wait').remove();
		},			
		success: function(json) {
			if (json['postcode_required'] == '1') {
				$('#shipping-postcode-required').show();
			} else {
				$('#shipping-postcode-required').hide();
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
			
			$('#shipping-address select[name=\'zone_id\']').html(html);
			
			reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());	
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});
});

$('#shipping-address select[name=\'country_id\']').trigger('change');

$('#shipping-address select[name=\'zone_id\']').bind('change', function() {
	reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(),$('#shipping-address input[name=\'postcode\']').val());	
});

$('#shipping-address select[name=\'zone_id\']').trigger('change');
//--></script>