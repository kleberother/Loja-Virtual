<?php if ($error_warning) { ?>
<div class="warning"><?php echo $error_warning; ?></div>
<?php } ?>
<?php if ($shipping_methods) { ?>
<p><?php echo $text_shipping_method; ?></p>
<?php if ($this->config->get('quickcheckout_shipping')) { ?>
<table class="radio">
  <?php foreach ($shipping_methods as $shipping_method) { ?>
  <tr>
    <td colspan="3"><b><?php echo $shipping_method['title']; ?></b></td>
  </tr>
  <?php if (!$shipping_method['error']) { ?>
  <?php foreach ($shipping_method['quote'] as $quote) { ?>
  <tr class="highlight">
    <td><?php if ($quote['code'] == $code || !$code) { ?>
      <?php $code = $quote['code']; ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" checked="checked" />
      <?php } else { ?>
      <input type="radio" name="shipping_method" value="<?php echo $quote['code']; ?>" id="<?php echo $quote['code']; ?>" />
      <?php } ?></td>
    <td><label for="<?php echo $quote['code']; ?>"><?php echo $quote['title']; ?></label></td>
    <td style="text-align: right;"><label for="<?php echo $quote['code']; ?>"><?php echo $quote['text']; ?></label></td>
  </tr>
  <?php } ?>
  <?php } else { ?>
  <tr>
    <td colspan="3"><div class="error"><?php echo $shipping_method['error']; ?></div></td>
  </tr>
  <?php } ?>
  <?php } ?>
</table>
<?php } else { ?>
 <?php if ($shipping_methods) { ?>
  <select style="max-width: 99%;" name="shipping_method">
   <?php foreach ($shipping_methods as $shipping_method) { ?>
     <?php if (!$shipping_method['error']) { ?>
		<?php foreach ($shipping_method['quote'] as $quote) { ?>
		  <?php if ($quote['code'] == $code || !$code) { ?>
		  <?php $code = $quote['code']; ?>
			 <option value="<?php echo $quote['code']; ?>" selected="selected">
		  <?php } else { ?>
			<option value="<?php echo $quote['code']; ?>">
		  <?php } ?>
		  <?php echo $quote['title']; ?>&nbsp;&nbsp;(<?php echo $quote['text']; ?>) </option>
		<?php } ?>
	 <?php } ?>
   <?php } ?>
  </select>
 <?php } else { ?>
	<div class="error"><?php echo $shipping_method['error']; ?></div>
 <?php } ?>
<?php } ?>
<br />
<?php } ?>
<textarea style="display:none;" name="comment" rows="8" style="width: 98%;"><?php echo $comment; ?></textarea>

<?php if ($this->config->get('quickcheckout_shipping')) { ?>
<script type="text/javascript"><!--
	$('#shipping-method input[name=\'shipping_method\']').bind('change', function() {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method/validate',
			type: 'post',
			data: $('#shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-payment-method').attr('disabled', true);
				$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			complete: function() {
				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();
			},			
			success: function(json) {
				$('.warning, .error').remove();
		
				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) {
					if (json['error']['warning']) {
						$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
						$('html, body').animate({ scrollTop: 0 }, 'slow');
						$('.warning').fadeIn('slow');
					}			
				} else {
					loadCart();				
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	});

	$('#shipping-method input[name=\'shipping_method\']').trigger('change');
//--></script> 
<?php } else { ?>
<script type="text/javascript"><!--
	$('#shipping-method select[name=\'shipping_method\']').bind('change', function() {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method/validate',
			type: 'post',
			data: $('#shipping-method select, #shipping-method textarea'),
			dataType: 'json',
			beforeSend: function() {
				$('#button-payment-method').attr('disabled', true);
				$('#button-payment-method').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			complete: function() {
				$('#button-payment-method').attr('disabled', false);
				$('.wait').remove();
			},			
			success: function(json) {
				$('.warning, .error').remove();
		
				if (json['redirect']) {
					location = json['redirect'];
				} else if (json['error']) {
					if (json['error']['warning']) {
						$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
						$('html, body').animate({ scrollTop: 0 }, 'slow');
						$('.warning').fadeIn('slow');
					}			
				} else {
					loadCart();				
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	});

	$('#shipping-method select[name=\'shipping_method\']').trigger('change');
//--></script> 
<?php } ?>