<?php if ($addresses) { ?>
<input type="radio" name="shipping_address" value="existing" id="shipping-address-existing" checked="checked" />
<label for="shipping-address-existing"><?php echo $text_address_existing; ?></label>
<div id="shipping-existing">
  <select name="address_id" style="width: 100%; margin-bottom: 15px;" size="5">
    <?php foreach ($addresses as $address) { ?>
    <?php if ($address['address_id'] == $address_id) { ?>
    <option value="<?php echo $address['address_id']; ?>" selected="selected"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
    <?php } else { ?>
    <option value="<?php echo $address['address_id']; ?>"><?php echo $address['firstname']; ?> <?php echo $address['lastname']; ?>, <?php echo $address['address_1']; ?>, <?php echo $address['city']; ?>, <?php echo $address['zone']; ?>, <?php echo $address['country']; ?></option>
    <?php } ?>
    <?php } ?>
  </select>
</div>
<p>
  <input type="radio" name="shipping_address" value="new" id="shipping-address-new" />
  <label for="shipping-address-new"><?php echo $text_address_new; ?></label>
</p>
<?php } ?>
<div id="shipping-new" style="display: <?php echo ($addresses ? 'none' : 'block'); ?>;">
  <div class="left">
	<span class="required">*</span> <?php echo $entry_firstname; ?><br />
    <input type="text" name="firstname" value="" class="large-field" />
  </div>
  <div class="left">
    <span class="required">*</span> <?php echo $entry_lastname; ?><br />
    <input type="text" name="lastname" value="" class="large-field" />
  </div>
  <div style="clear:both;"></div>
<?php if ($this->config->get('quickcheckout_address_2')) { ?>
<div class="left">
	<span class="required">*</span> <?php echo $entry_address_1; ?><br />
	<input type="text" name="address_1" value="" class="large-field" /><br />
</div>
<div class="left">
    <?php echo $entry_lastname; ?><br />
	<input type="text" name="address_2" value="" class="large-field" /><br />
</div>
<?php } else { ?>
  <div style="margin-bottom:20px;">
	<span class="required">*</span> <?php echo $entry_address_1; ?><br />
	<input type="text" name="address_1" value="" class="large-field" /><br />
	<input style="display:none;" type="text" name="address_2" value="" class="large-field" />
  </div>
<?php } ?>
  <div style="clear:both;"></div>
<?php if ($this->config->get('quickcheckout_company')) { ?>
<div class="left">
	<?php echo $entry_company; ?><br />
	<input type="text" name="company" value="" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
	<input style="display: none;" type="text" name="company" value="" class="large-field" />
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_city')) { ?>
<div class="left">
  <span class="required">*</span> <?php echo $entry_city; ?><br />
  <input type="text" name="city" value="" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
  <input type="text" style="display:none;" name="city" value="" class="large-field" />
</div>
<?php } ?>
<?php if ($this->config->get('quickcheckout_postcode')) { ?>
<div class="left">
  <span id="payment-postcode-required" class="required">*</span> <?php echo $entry_postcode; ?><br />
  <input type="text" name="postcode" value="" class="large-field" /><br />
</div>
<?php } else { ?>
<div class="left" style="display:none;">
  <input type="text" style="display:none;" name="postcode" value="" class="large-field" />
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

</div>

<script type="text/javascript"><!--
// Shipping address form functions
$(document).ready(function() {
	reloadShippingMethodById($('#shipping-address select[name=\'address_id\']').val());
});

$('#shipping-address input[name=\'shipping_address\']').live('change', function() {
	if (this.value == 'new') {
		$('#shipping-existing').slideUp();
		$('#shipping-new').slideDown();
		
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
					reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(), $('#shipping-address input[name=\'postcode\']').val());
				},
				error: function(xhr, ajaxOptions, thrownError) {
					alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
				}
			});
		});

		$('#shipping-address select[name=\'country_id\']').trigger('change');

		$('#shipping-address select[name=\'zone_id\']').bind('change', function() {
				reloadShippingMethod($('#shipping-address select[name=\'country_id\']').val(), $('#shipping-address select[name=\'zone_id\']').val(), 1 , $('#shipping-address input[name=\'city\']').val(), $('#shipping-address input[name=\'postcode\']').val());
		});

		$('#shipping-address select[name=\'zone_id\']').trigger('change');
	} else {
		$('#shipping-existing').slideDown();
		$('#shipping-new').slideUp();
	}
});

$('#shipping-address select[name=\'address_id\']').live('change', function() {
	reloadShippingMethodById($('#shipping-address select[name=\'address_id\']').val());
});
$('#shipping-address select[name=\'address_id\']').trigger('change');
//--></script> 