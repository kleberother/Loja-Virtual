<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
<div id="warning-messages"></div>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div id="quickcheckoutconfirm">
  <?php if (!$logged) { ?>
  <div class="quickcheckoutmid" id="login-box">
    <div id="checkout">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_option; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
	<div class="or"><?php echo $text_or; ?></div>
  </div>
  <?php } ?>
  <div class="quickcheckoutleft">
    <?php if (!$logged) { ?>
    <div id="payment-address">
	  <div class="quickcheckout-heading"><span><?php echo $text_checkout_account; ?></span></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } else { ?>
    <div id="payment-address">
	  <div class="quickcheckout-heading"><span><?php echo $text_checkout_payment_address; ?></span></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } ?>
    <?php if ($shipping_required) { ?>
    <div id="shipping-address">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_shipping_address; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
	<?php } ?>
  </div>
  <div class="quickcheckoutright">
    <?php if ($shipping_required) { ?>
    <div id="shipping-method">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_shipping_method; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
    <?php } ?>
    <div id="payment-method">
	  <div class="quickcheckout-heading"><?php echo $text_checkout_payment_method; ?></div>
      <div class="quickcheckout-content"></div>
    </div>
  </div>
  
  <div style="clear: both;"></div>
  
  <div class="quickcheckoutmid" style="display:none;">
	<div class="quickcheckout-heading"><?php echo $text_checkout_confirm; ?></div>
    <div id="confirm">
      <div class="quickcheckout-content"></div>
    </div>
  </div>
  
  <div style="clear: both;"></div>
  
  <div class="quickcheckutmid">
	<div id="cart">
	  <div class="quickcheckout-content" style="border:none; text-align:center;"></div>
	</div>
  </div>
  
  <div style="clear: both;"></div>
  
  <div class="quickcheckutmid">
	<div id="terms">
	  <div class="quickcheckout-content" style="padding:10px; text-align:right;"></div>
	</div>
  </div>
	
  </div>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$(window).load(function() {
    $.blockUI({
	message: '<h1><?php echo $text_please_wait; ?></h1>',
	css: { 
        border: 'none', 
        padding: '15px', 
        backgroundColor: '#000000', 
        '-webkit-border-radius': '10px', 
        '-moz-border-radius': '10px', 
		'-khtml-border-radius': '10px',
		'border-radius': '10px',
        opacity: .8, 
        color: '#fff' 
    } }); 
 
    setTimeout($.unblockUI, 2000); 
}); 

<?php if (!$logged) { ?> 
// Login box
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/login',
		dataType: 'html',
		beforeSend: function() {
			$('#checkout .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#checkout .quickcheckout-content').html(html);
				
			$('#checkout .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Login Form Clicked
$('#button-login').live('click', function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/login/validate',
		type: 'post',
		data: $('#checkout #login :input'),
		dataType: 'json',
		beforeSend: function() {
			$('#button-login').attr('disabled', true);
			$('#button-login').after('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		complete: function() {
			$('#button-login').attr('disabled', false);
			$('.wait').remove();
		},				
		success: function(json) {
			$('.warning, .error').remove();
			
			if (json['redirect']) {
				location = json['redirect'];
			} else if (json['error']) {
				$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '</div>');
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
				$('.warning').fadeIn('slow');
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Validate Register
function validateRegister() {
	$.ajax({
		url: 'index.php?route=quickcheckout/register/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
		dataType: 'json',		
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
				
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}	
					
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
				}	
																		
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
				
				if (json['error']['password']) {
					$('#payment-address input[name=\'password\'] + br').after('<span class="error">' + json['error']['password'] + '</span>');
				}	
				
				if (json['error']['confirm']) {
					$('#payment-address input[name=\'confirm\'] + br').after('<span class="error">' + json['error']['confirm'] + '</span>');
				}																																	
			} else {
				<?php if ($shipping_required) { ?>
					var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
					
					if (shipping_address) {
						validateShippingMethod();
					} else {
						validateGuestShippingAddress();					
					}
				<?php } else {?>
					validatePaymentMethod();
				<?php } ?>
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load Guest Payment Form
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/guest',
		dataType: 'html',
		beforeSend: function() {
			$('#payment-address .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#payment-address .quickcheckout-content').html(html);
				
			$('#payment-address .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Validate Guest Payment Address
function validateGuestAddress() {
$.ajax({
		url: 'index.php?route=quickcheckout/guest/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'checkbox\']:checked, #payment-address select'),
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
								
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\'] + br').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\'] + br').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#payment-address input[name=\'email\'] + br').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\'] + br').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}	
					
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
				}	
																		
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\'] + br').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\'] + br').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\'] + br').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\'] + br').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\'] + br').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				var create_acc = $('#payment-address input[name=\'create_account\']:checked').attr('value');
				
				<?php if ($shipping_required) { ?>	
					var shipping_address = $('#payment-address input[name=\'shipping_address\']:checked').attr('value');
					
					if (create_acc) {
						validateRegister();
					} else {
						if (shipping_address) {
							validateShippingMethod();
						} else {
							validateGuestShippingAddress();					
						}
					}
				<?php } else { ?>
					if (create_acc) {
						validateRegister();
					} else {
						validatePaymentMethod();
					}
				<?php } ?>				
			}	 
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Validate Guest Shipping Address
function validateGuestShippingAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/guest_shipping/validate',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address select'),
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
								
				if (json['error']['firstname']) {
					$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
														
				if (json['error']['address_1']) {
					$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				validateShippingMethod();
			}	 
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Confirm Payment
$('#button-payment-method').live('click', function() {
	validateGuestAddress();	
});
<?php } else { ?>
// Load payment addresses
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_address',
		dataType: 'html',
		success: function(html) {
			$('#payment-address .quickcheckout-content').html(html);
			
			$('#payment-address .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});

<?php if ($shipping_required) { ?>
// Load shipping addresses
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/shipping_address',
		dataType: 'html',
		success: function(html) {
			$('#shipping-address .quickcheckout-content').html(html);
			
			$('#shipping-address .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});
<?php } ?>

// Validate Payment Address
function validatePaymentAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_address/validate',
		type: 'post',
		data: $('#payment-address input[type=\'text\'], #payment-address input[type=\'password\'], #payment-address input[type=\'checkbox\']:checked, #payment-address input[type=\'radio\']:checked, #payment-address input[type=\'hidden\'], #payment-address select'),
		dataType: 'json',		
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
								
				if (json['error']['firstname']) {
					$('#payment-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#payment-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['telephone']) {
					$('#payment-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}		
				
				if (json['error']['company_id']) {
					$('#payment-address input[name=\'company_id\'] + br').after('<span class="error">' + json['error']['company_id'] + '</span>');
				}	
				
				if (json['error']['tax_id']) {
					$('#payment-address input[name=\'tax_id\'] + br').after('<span class="error">' + json['error']['tax_id'] + '</span>');
				}	
														
				if (json['error']['address_1']) {
					$('#payment-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#payment-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#payment-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#payment-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#payment-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				<?php if ($shipping_required) { ?>
					validateShippingAddress();
				<?php } else { ?>
					validatePaymentMethod();
				<?php } ?>	
			}	  
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

<?php if ($shipping_required) { ?>
// Validate Shipping Address
function validateShippingAddress() {
	$.ajax({
		url: 'index.php?route=quickcheckout/shipping_address/validate',
		type: 'post',
		data: $('#shipping-address input[type=\'text\'], #shipping-address input[type=\'password\'], #shipping-address input[type=\'checkbox\']:checked, #shipping-address input[type=\'radio\']:checked, #shipping-address select'),
		dataType: 'json',		
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
								
				if (json['error']['firstname']) {
					$('#shipping-address input[name=\'firstname\']').after('<span class="error">' + json['error']['firstname'] + '</span>');
				}
				
				if (json['error']['lastname']) {
					$('#shipping-address input[name=\'lastname\']').after('<span class="error">' + json['error']['lastname'] + '</span>');
				}	
				
				if (json['error']['email']) {
					$('#shipping-address input[name=\'email\']').after('<span class="error">' + json['error']['email'] + '</span>');
				}
				
				if (json['error']['telephone']) {
					$('#shipping-address input[name=\'telephone\']').after('<span class="error">' + json['error']['telephone'] + '</span>');
				}		
										
				if (json['error']['address_1']) {
					$('#shipping-address input[name=\'address_1\']').after('<span class="error">' + json['error']['address_1'] + '</span>');
				}	
				
				if (json['error']['city']) {
					$('#shipping-address input[name=\'city\']').after('<span class="error">' + json['error']['city'] + '</span>');
				}	
				
				if (json['error']['postcode']) {
					$('#shipping-address input[name=\'postcode\']').after('<span class="error">' + json['error']['postcode'] + '</span>');
				}	
				
				if (json['error']['country']) {
					$('#shipping-address select[name=\'country_id\']').after('<span class="error">' + json['error']['country'] + '</span>');
				}	
				
				if (json['error']['zone']) {
					$('#shipping-address select[name=\'zone_id\']').after('<span class="error">' + json['error']['zone'] + '</span>');
				}
			} else {
				validateShippingMethod();
			}  
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}
<?php } ?>

// Confirm payment
$('#button-payment-method').live('click', function() {
	validatePaymentAddress();	
});
<?php } ?>

// Payment Method
function reloadPaymentMethod(country_id, zone_id, isset, city, postcode) {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method',
		data: {country_id: country_id, zone_id: zone_id, isset: isset, city: city, postcode: postcode},
		dataType: 'html',
		beforeSend: function() {
			$('#payment-method .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#payment-method .quickcheckout-content').html(html);
				
			$('#payment-method .quickcheckout-content').slideDown('slow');
			
			loadCart();
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

function reloadPaymentMethodById(address_id) {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method',
		data: {address_id: address_id},
		dataType: 'html',
		beforeSend: function() {
			$('#payment-method .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#payment-method .quickcheckout-content').html(html);
				
			$('#payment-method .quickcheckout-content').slideDown('slow');
			
			loadCart();
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Validate Payment Method
function validatePaymentMethod() {
	$.ajax({
		url: 'index.php?route=quickcheckout/payment_method/validate', 
		type: 'post',
		data: $('#payment-method select, #payment-method input[type=\'radio\']:checked, #payment-method input[type=\'checkbox\']:checked, #payment-method textarea'),
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
				validateTerms();				
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Shipping Method
<?php if ($shipping_required) { ?>
	function reloadShippingMethod(country_id, zone_id, isset, city, postcode) {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method',
			data: {country_id: country_id, zone_id: zone_id, isset: isset, city: city, postcode: postcode},
			dataType: 'html',
			beforeSend: function() {
				$('#shipping-method .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			success: function(html) {
				$('#shipping-method .quickcheckout-content').html(html);
					
				$('#shipping-method .quickcheckout-content').slideDown('slow');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
	
	function reloadShippingMethodById(address_id) {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method',
			data: {address_id: address_id},
			dataType: 'html',
			beforeSend: function() {
				$('#shipping-method .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
			},	
			success: function(html) {
				$('#shipping-method .quickcheckout-content').html(html);
					
				$('#shipping-method .quickcheckout-content').slideDown('slow');
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
	
	// Validate Shipping Method
	function validateShippingMethod() {
		$.ajax({
			url: 'index.php?route=quickcheckout/shipping_method/validate',
			type: 'post',
			data: $('#shipping-method select, #shipping-method input[type=\'radio\']:checked, #shipping-method textarea'),
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
					validatePaymentMethod();					
				}
			},
			error: function(xhr, ajaxOptions, thrownError) {
				alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
			}
		});	
	}
<?php } ?>

// Load button
$(document).ready(function() {
	$.ajax({
		url: 'index.php?route=quickcheckout/terms',
		dataType: 'html',
		beforeSend: function() {
			$('#terms .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#terms .quickcheckout-content').html(html);
				
			$('#terms .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
});	

// Validate button
function validateTerms() {
	$.ajax({
		url: 'index.php?route=quickcheckout/terms/validate',
		type: 'post',
		data: $('#terms input[type=\'checkbox\']:checked'),
		dataType: 'json',
		success: function(json) {
			if (json['error']) {
				if (json['error']['warning']) {
					$('#warning-messages').prepend('<div class="warning" style="display: none;">' + json['error']['warning'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					$('html, body').animate({ scrollTop: 0 }, 'slow');
					$('.warning').fadeIn('slow');
				}
			} else {
				loadConfirm();
			}
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load confirm
function loadConfirm() {
	$.ajax({
		url: 'index.php?route=quickcheckout/confirm',
		dataType: 'html',
		success: function(html) {
			$('#quickcheckoutconfirm').html(html);
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}

// Load cart
function loadCart() {
	$.ajax({
		url: 'index.php?route=quickcheckout/cart',
		dataType: 'html',
		beforeSend: function() {
			$('#cart .quickcheckout-content').slideUp('fast');
			$('#cart .quickcheckout-content').html('<span class="wait">&nbsp;<img src="catalog/view/theme/default/image/loading.gif" alt="" /></span>');
		},	
		success: function(html) {
			$('#cart .quickcheckout-content').html(html);
				
			$('#cart .quickcheckout-content').slideDown('slow');
		},
		error: function(xhr, ajaxOptions, thrownError) {
			alert(thrownError + "\r\n" + xhr.statusText + "\r\n" + xhr.responseText);
		}
	});	
}
//--></script> 
<?php echo $footer; ?>