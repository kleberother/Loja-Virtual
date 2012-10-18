<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<div id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <h1><?php echo $heading_title; ?></h1>
  <div class="product-info">
    <?php if ($thumb || $images) { ?>
    <div class="left">
      <?php if ($thumb) { ?>
      <div class="image"><a href="<?php echo $popup; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $thumb; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" id="image" /></a></div>
      <?php } ?>
      <?php if ($images) { ?>
      <div class="image-additional">
        <?php foreach ($images as $image) { ?>
        <a href="<?php echo $image['popup']; ?>" title="<?php echo $heading_title; ?>" class="colorbox" rel="colorbox"><img src="<?php echo $image['thumb']; ?>" title="<?php echo $heading_title; ?>" alt="<?php echo $heading_title; ?>" /></a>
        <?php } ?>
      </div>
      <?php } ?>
    </div>
    <?php } ?>
    <div class="right">
      <div class="description">
        <?php if ($manufacturer) { ?>
        <span><?php echo $text_manufacturer; ?></span> <a href="<?php echo $manufacturers; ?>"><?php echo $manufacturer; ?></a><br />
        <?php } ?>
        <span><?php echo $text_model; ?></span> <?php echo $model; ?><br />
        <?php if ($reward) { ?>
        <span><?php echo $text_reward; ?></span> <?php echo $reward; ?><br />
        <?php } ?>
        <?php if($has_option == 0 && $subtract == 0){echo'<span>'.$text_stock.'</span>'.$stock.'</div>';}?></div>
      <?php if ($price) { ?>
      <div class="price"><?php echo $text_price; ?>
        <?php if (!$special) { ?>
        <?php echo $price; ?>
        <?php } else { ?>
        <span class="price-old"><?php echo $price; ?></span> <span class="price-new"><?php echo $special; ?></span>
        <?php } ?>
        <br />
        <?php if ($tax) { ?>
        <span class="price-tax"><?php echo $text_tax; ?> <?php echo $tax; ?></span><br />
        <?php } ?>
        <?php if ($points) { ?>
        <span class="reward"><small><?php echo $text_points; ?> <?php echo $points; ?></small></span><br />
        <?php } ?>
        <?php if ($discounts) { ?>
        <br />
        <div class="discount">
          <?php foreach ($discounts as $discount) { ?>
          <?php echo sprintf($text_discount, $discount['quantity'], $discount['price']); ?><br />
          <?php } ?>
        </div>
        <?php } ?>
      </div>
      <?php } ?>

                            <?php if($config_option_store){ ?>
                        
      <?php if ($options) { ?>
      <div class="options">
        <h2><?php echo $text_option; ?></h2>
        <br />
        <?php $i = 0; foreach ($options as $option) { ?>
        <?php if ($option['type'] == 'select') { $i++; ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <select name="option[<?php echo $option['product_option_id']; ?>]" class="optionChoice">
            <option value=""><?php echo $text_select; ?></option>
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <option value="<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            
            <?php } ?>
            </option>
            <?php } ?>
          </select>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'radio') { $i++;?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" class="optionChoice" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'checkbox') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <?php foreach ($option['option_value'] as $option_value) { ?>
          <input type="checkbox" name="option[<?php echo $option['product_option_id']; ?>][]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" />
          <label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
            <?php if ($option_value['price']) { ?>
            
            <?php } ?>
          </label>
          <br />
          <?php } ?>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'image') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <table class="option-image">
            <?php foreach ($option['option_value'] as $option_value) { ?>
            <tr>
              <td style="width: 1px;"><input type="radio" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option_value['product_option_value_id']; ?>" id="option-value-<?php echo $option_value['product_option_value_id']; ?>" class="optionChoice" /></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><img src="<?php echo $option_value['image']; ?>" alt="<?php echo $option_value['name'] . ($option_value['price'] ? ' ' . $option_value['price_prefix'] . $option_value['price'] : ''); ?>" /></label></td>
              <td><label for="option-value-<?php echo $option_value['product_option_value_id']; ?>"><?php echo $option_value['name']; ?>
                  <?php if ($option_value['price']) { ?>
                  
                  <?php } ?>
                </label></td>
            </tr>
            <?php } ?>
          </table>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'text') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'textarea') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <textarea name="option[<?php echo $option['product_option_id']; ?>]" cols="40" rows="5"><?php echo $option['option_value']; ?></textarea>
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'file') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="button" value="<?php echo $button_upload; ?>" id="button-option-<?php echo $option['product_option_id']; ?>" class="button">
          <input type="hidden" name="option[<?php echo $option['product_option_id']; ?>]" value="" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'date') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="date" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'datetime') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="datetime" />
        </div>
        <br />
        <?php } ?>
        <?php if ($option['type'] == 'time') { ?>
        <div id="option-<?php echo $option['product_option_id']; ?>" class="option">
          <?php if ($option['required']) { ?>
          <span class="required">*</span>
          <?php } ?>
          <b><?php echo $option['name']; ?>:</b><br />
          <input type="text" name="option[<?php echo $option['product_option_id']; ?>]" value="<?php echo $option['option_value']; ?>" class="time" />
        </div>
        <br />
        <?php } ?>
        <?php } ?>
      </div>
      <?php } ?>

                            <?php }else{ ?>
                            
                            
                                <?php if($options){ 

                                    // Define as opções, Tamanhos e Cores, da grade.
                                    $i=0 ; foreach ($options as $option){
                                        switch(strtoupper($option["name"])){
                                            case "CORES":
                                                $i++;
                                                $cores = $option;
                                            break;
                                            case "TAMANHOS":
                                                $i++;
                                                $tamanhos = $option;
                                            break;
                                        }
                                    }


                                ?>
                                <div class="cart grade">
                                    <div>
                                        <table id="grade" cellpadding="2" cellspacing="0" border="0">
                                            <tr>
                                                <td></td>
                                                <td></td>
                                                <?php foreach ($tamanhos["option_value"] as $tamanho){ ?>
                                                    <td align="center"><?php echo $tamanho["name"]; ?></td>
                                                <?php } ?>
                                            </tr>
                                            <?php foreach ($cores["option_value"] as $cor){ ?>                
                                            <tr>
                                                
                                                <td>
                                                <?php if($cor['image_big']){?>
                                                    <a href="<?php echo $cor['image_big']; ?>" rel="expand"><img src="<?php echo $cor['image']; ?>" alt="<?php echo $cor['name']; ?>" /></a>
                                                <?php } ?>
                                                </td>
                                                
                                                <td align="right">
                                                    <?php echo $cor["name"]; ?>
                                                </td>
                                                <?php foreach ($tamanhos["option_value"] as $tamanho){ ?>
                                                    <td>
                                                        <input type="text" name="cor_<?php echo $cores['product_option_id']; ?>_<?php echo $cor['product_option_value_id']; ?>xtamanho_<?php echo $tamanhos['product_option_id']; ?>_<?php echo $tamanho['product_option_value_id']; ?>" size="2" value="0" data-id="<?php echo $tamanho['product_option_value_id']; ?>:<?php echo $cor['product_option_value_id']; ?>" />
                                                    </td>
                                                <?php } ?>                    
                                            </tr>
                                            <?php } ?>
                                        </table>
                                    </div>
                                </div>
                                <div class="cart quantity-button">
                                    <div>
                                        <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
                                        <a id="button-cart" class="button" /><?php echo $button_cart; ?></a>
                                        <input type="button" onclick="location.href='<?php echo $checkout; ?>'" value="Ver carrinho completo" class="button carrinho" style="margin:7px 0 10px 7px;" />
                                    </div>
                                </div>
                                <?php } ?>                            
                            
                            
                            <?php } ?>
                        
      <div class="cart">
<input type="hidden" name="optionNumbers" value="<?php echo $i; ?>" id="optionNumbers" />
<div id="product-cart">

                            <?php if(!$config_option_store){ ?>
                                <div style="display:none">
                            <?php } ?>
                        
        <div><?php echo $text_qty; ?>
          <input type="text" name="quantity" size="2" value="<?php echo $minimum; ?>" />
          <input type="hidden" name="product_id" size="2" value="<?php echo $product_id; ?>" />
          &nbsp;
          <input type="button" value="<?php echo $button_cart; ?>" id="button-cart" class="button" />

                            <?php if(!$config_option_store){ ?>
                                </div>
                            <?php } ?>
                        
        </div>
        <div><span>&nbsp;&nbsp;&nbsp;<?php echo $text_or; ?>&nbsp;&nbsp;&nbsp;</span></div>
</div>
        <div><a onclick="addToWishList('<?php echo $product_id; ?>');"><?php echo $button_wishlist; ?></a><br />
          <a onclick="addToCompare('<?php echo $product_id; ?>');"><?php echo $button_compare; ?></a></div>
        <?php if ($minimum > 1) { ?>
        <div class="minimum"><?php echo $text_minimum; ?></div>
        <?php } ?>
      </div>
      <?php if ($review_status) { ?>
      <div class="review">
        <div><img src="catalog/view/theme/default/image/stars-<?php echo $rating; ?>.png" alt="<?php echo $reviews; ?>" />&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $reviews; ?></a>&nbsp;&nbsp;|&nbsp;&nbsp;<a onclick="$('a[href=\'#tab-review\']').trigger('click');"><?php echo $text_write; ?></a></div>
        <div class="share"><!-- AddThis Button BEGIN -->
          <div class="addthis_default_style"><a class="addthis_button_compact"><?php echo $text_share; ?></a> <a class="addthis_button_email"></a><a class="addthis_button_print"></a> <a class="addthis_button_facebook"></a> <a class="addthis_button_twitter"></a></div>
          <script type="text/javascript" src="//s7.addthis.com/js/250/addthis_widget.js"></script> 
          <!-- AddThis Button END --> 
        </div>
      </div>
      <?php } ?>
    </div>
  </div>
  <div id="tabs" class="htabs"><a href="#tab-description"><?php echo $tab_description; ?></a>
    <?php if ($attribute_groups) { ?>
    <a href="#tab-attribute"><?php echo $tab_attribute; ?></a>
    <?php } ?>
    <?php if ($review_status) { ?>
    <a href="#tab-review"><?php echo $tab_review; ?></a>
    <?php } ?>
    <?php if ($products) { ?>
    <a href="#tab-related"><?php echo $tab_related; ?> (<?php echo count($products); ?>)</a>
    <?php } ?>
  </div>
  <div id="tab-description" class="tab-content"><?php echo $description; ?></div>
  <?php if ($attribute_groups) { ?>
  <div id="tab-attribute" class="tab-content">
    <table class="attribute">
      <?php foreach ($attribute_groups as $attribute_group) { ?>
      <thead>
        <tr>
          <td colspan="2"><?php echo $attribute_group['name']; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
        <tr>
          <td><?php echo $attribute['name']; ?></td>
          <td><?php echo $attribute['text']; ?></td>
        </tr>
        <?php } ?>
      </tbody>
      <?php } ?>
    </table>
  </div>
  <?php } ?>
  <?php if ($review_status) { ?>
  <div id="tab-review" class="tab-content">
    <div id="review"></div>
    <h2 id="review-title"><?php echo $text_write; ?></h2>
    <b><?php echo $entry_name; ?></b><br />
    <input type="text" name="name" value="" />
    <br />
    <br />
    <b><?php echo $entry_review; ?></b>
    <textarea name="text" cols="40" rows="8" style="width: 98%;"></textarea>
    <span style="font-size: 11px;"><?php echo $text_note; ?></span><br />
    <br />
    <b><?php echo $entry_rating; ?></b> <span><?php echo $entry_bad; ?></span>&nbsp;
    <input type="radio" name="rating" value="1" />
    &nbsp;
    <input type="radio" name="rating" value="2" />
    &nbsp;
    <input type="radio" name="rating" value="3" />
    &nbsp;
    <input type="radio" name="rating" value="4" />
    &nbsp;
    <input type="radio" name="rating" value="5" />
    &nbsp;<span><?php echo $entry_good; ?></span><br />
    <br />
    <b><?php echo $entry_captcha; ?></b><br />
    <input type="text" name="captcha" value="" />
    <br />
    <img src="index.php?route=product/product/captcha" alt="" id="captcha" /><br />
    <br />
    <div class="buttons">
      <div class="right"><a id="button-review" class="button"><?php echo $button_continue; ?></a></div>
    </div>
  </div>
  <?php } ?>
  <?php if ($products) { ?>
  <div id="tab-related" class="tab-content">
    <div class="box-product">
      <?php foreach ($products as $product) { ?>
      <div>
        <?php if ($product['thumb']) { ?>
        <div class="image"><a href="<?php echo $product['href']; ?>"><img src="<?php echo $product['thumb']; ?>" alt="<?php echo $product['name']; ?>" /></a></div>
        <?php } ?>
        <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?></a></div>
        <?php if ($product['price']) { ?>
        <div class="price">
          <?php if (!$product['special']) { ?>
          <?php echo $product['price']; ?>
          <?php } else { ?>
          <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
          <?php } ?>
        </div>
        <?php } ?>
        <?php if ($product['rating']) { ?>
        <div class="rating"><img src="catalog/view/theme/default/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
        <?php } ?>
        <a onclick="addToCart('<?php echo $product['product_id']; ?>');" class="button"><?php echo $button_cart; ?></a></div>
      <?php } ?>
    </div>
  </div>
  <?php } ?>
  <?php if ($tags) { ?>
  <div class="tags"><b><?php echo $text_tags; ?></b>
    <?php for ($i = 0; $i < count($tags); $i++) { ?>
    <?php if ($i < (count($tags) - 1)) { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>,
    <?php } else { ?>
    <a href="<?php echo $tags[$i]['href']; ?>"><?php echo $tags[$i]['tag']; ?></a>
    <?php } ?>
    <?php } ?>
  </div>
  <?php } ?>
  <?php echo $content_bottom; ?></div>
<script type="text/javascript"><!--
$('.colorbox').colorbox({
	overlayClose: true,
	opacity: 0.5
});
//--></script> 
<script type="text/javascript"><!--
$('#button-cart').bind('click', function() {

                        
                                if($("#grade").get().length){


                                    $(this).empty().append("Carregando...");

                                    var inputs = $("#grade input");
                                    var soma = 0;

                                    $.each(inputs,function(key,object){
                                        soma += parseInt($(object).val());                
                                    });


                                    if(soma < <?php echo $minimum; ?>){
                                        alert("Quantidade minima de <?php echo $minimum; ?>");
                                        return false;
                                    }

                                    document.activeAjaxConnections = 0;


                                    $.each(inputs,function(key,object){

                                        var opcoes = $(object).attr("name").split("x");

                                        var cores = opcoes[0].split("_");
                                        var tamanhos = opcoes[1].split("_");         

                                        title_tamanho = "option[" + tamanhos[1] + "]";
                                        title_cor = "option[" + cores[1] + "]";



                                        var options =  title_tamanho +"="+ tamanhos[2] +"&"+ title_cor +"="+ cores[2] +"&"+ "quantity" +"="+ $(object).val() +"&"+ "product_id" +"="+ $('.product-info input[NAME=\'product_id\']').val();




                                        if(parseInt($(object).val()) > 0){

                                            $.ajax({
                                                url: 'index.php?route=checkout/cart/add',
                                                type: 'post',
                                                data: options,
                                                dataType: 'json',
                                                beforeSend: function() {
                                                    document.activeAjaxConnections++;
                                                },                        
                                                success: function(json) {
                                                    document.activeAjaxConnections--;
                                                    if (0 == document.activeAjaxConnections) {

                                                        $('.success, .warning, .attention, information, .error').remove();

                                                        if (json['error']) {
                                                            if (json['error']['option']) {
                                                                for (i in json['error']['option']) {
                                                                        $('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
                                                                }
                                                            }
                                                        } 

                                                        if (json['success']) {


                                                            location.href = "index.php?route=checkout/cart";
                                                            /*

                                }
                        
                                                            $('#button-cart').empty().append("<?php echo $button_cart; ?>");


                                                            $('#notification').html('<div class="success" style="display: none;">' + json['success'] + '</div>');   
                                                            $('.success').dialog({
                                                                title: "<?php echo $button_cart; ?>",
                                                                modal: true,
                                                                zIndex: 999999
                                                            });
                                                            $('.success').fadeIn('slow');
                                                            $('#cart-total').html(json['total']);
                                                            $('html, body').animate({ scrollTop: 0 }, 'slow'); 
                                                            */
                                                        }	
                                                    }
                                                },
                                                error :function(){
                                                    document.activeAjaxConnections--;
                                                }
                                            });

                                            $(object).val("0");
                                        }

                                    });


                                }else{
                        
	$.ajax({
		url: 'index.php?route=checkout/cart/add',
		type: 'post',
		data: $('.product-info input[type=\'text\'], .product-info input[type=\'hidden\'], .product-info input[type=\'radio\']:checked, .product-info input[type=\'checkbox\']:checked, .product-info select, .product-info textarea'),
		dataType: 'json',
		success: function(json) {
			$('.success, .warning, .attention, information, .error').remove();
			
			if (json['error']) {
				if (json['error']['option']) {
					for (i in json['error']['option']) {
						$('#option-' + i).after('<span class="error">' + json['error']['option'][i] + '</span>');
					}
				}
			} 
			
			if (json['success']) {
				$('#notification').html('<div class="success" style="display: none;">' + json['success'] + '<img src="catalog/view/theme/default/image/close.png" alt="" class="close" /></div>');
					
				$('.success').fadeIn('slow');
					
				$('#cart-total').html(json['total']);
				
				$('html, body').animate({ scrollTop: 0 }, 'slow'); 
			}	
		}
	});

                                }
                        
});
//--></script>
<?php if ($options) { ?>
<script type="text/javascript" src="catalog/view/javascript/jquery/ajaxupload.js"></script>
<?php $i = 0; foreach ($options as $option) { ?>
<?php if ($option['type'] == 'file') { ?>
<script type="text/javascript"><!--
new AjaxUpload('#button-option-<?php echo $option['product_option_id']; ?>', {
	action: 'index.php?route=product/product/upload',
	name: 'file',
	autoSubmit: true,
	responseType: 'json',
	onSubmit: function(file, extension) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').after('<img src="catalog/view/theme/default/image/loading.gif" class="loading" style="padding-left: 5px;" />');
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', true);
	},
	onComplete: function(file, json) {
		$('#button-option-<?php echo $option['product_option_id']; ?>').attr('disabled', false);
		
		$('.error').remove();
		
		if (json['success']) {
			alert(json['success']);
			
			$('input[name=\'option[<?php echo $option['product_option_id']; ?>]\']').attr('value', json['file']);
		}
		
		if (json['error']) {
			$('#option-<?php echo $option['product_option_id']; ?>').after('<span class="error">' + json['error'] + '</span>');
		}
		
		$('.loading').remove();	
	}
});
//--></script>
<?php } ?>
<?php } ?>
<?php } ?>
<script type="text/javascript"><!--
$('#review .pagination a').live('click', function() {
	$('#review').fadeOut('slow');
		
	$('#review').load(this.href);
	
	$('#review').fadeIn('slow');
	
	return false;
});			

$('#review').load('index.php?route=product/product/review&product_id=<?php echo $product_id; ?>');

$('#button-review').bind('click', function() {
	$.ajax({
		url: 'index.php?route=product/product/write&product_id=<?php echo $product_id; ?>',
		type: 'post',
		dataType: 'json',
		data: 'name=' + encodeURIComponent($('input[name=\'name\']').val()) + '&text=' + encodeURIComponent($('textarea[name=\'text\']').val()) + '&rating=' + encodeURIComponent($('input[name=\'rating\']:checked').val() ? $('input[name=\'rating\']:checked').val() : '') + '&captcha=' + encodeURIComponent($('input[name=\'captcha\']').val()),
		beforeSend: function() {
			$('.success, .warning').remove();
			$('#button-review').attr('disabled', true);
			$('#review-title').after('<div class="attention"><img src="catalog/view/theme/default/image/loading.gif" alt="" /> <?php echo $text_wait; ?></div>');
		},
		complete: function() {
			$('#button-review').attr('disabled', false);
			$('.attention').remove();
		},
		success: function(data) {
			if (data['error']) {
				$('#review-title').after('<div class="warning">' + data['error'] + '</div>');
			}
			
			if (data['success']) {
				$('#review-title').after('<div class="success">' + data['success'] + '</div>');
								
				$('input[name=\'name\']').val('');
				$('textarea[name=\'text\']').val('');
				$('input[name=\'rating\']:checked').attr('checked', '');
				$('input[name=\'captcha\']').val('');
			}
		}
	});
});
//--></script> 
<script type="text/javascript"><!--
$('#tabs a').tabs();
//--></script> 
<script type="text/javascript" src="catalog/view/javascript/jquery/ui/jquery-ui-timepicker-addon.js"></script> 
<script type="text/javascript"><!--
if ($.browser.msie && $.browser.version == 6) {
	$('.date, .datetime, .time').bgIframe();
}

$('.date').datepicker({dateFormat: 'yy-mm-dd'});
$('.datetime').datetimepicker({
	dateFormat: 'yy-mm-dd',
	timeFormat: 'h:m'
});
$('.time').timepicker({timeFormat: 'h:m'});
//--></script> 

<script type="text/javascript"><!--
$('.optionChoice, .grade input').bind("change blur",function(){
    var optionStr = '';
    var i = parseInt(0);
    var optionNumbers = $('#optionNumbers').val();
    var imgThumbOriginal = '<?php echo $thumb; ?>';
    var imgPopOriginal = '<?php echo $popup; ?>';
    var stringPrice = ''; var stringDiscount = '';
    var input = $(this);
    var quantity_now = parseFloat($(this).val());
    var grid = false;

    
    if($(this).attr("data-id")){
        grid = true;
        if(parseInt($(this).val()) > 0){
            optionStr = $(this).attr("data-id");
        }
    
    }else{

        $(".optionChoice option:selected, input:radio[class=optionChoice]:checked").each(function(){

            if($(this).val() != '')
            {
                if(i != 0){optionStr = optionStr +':'+ $(this).val();}else{optionStr = $(this).val();}
                i++;
            }

        });
    }
    
    
    
    
    
    if(i == optionNumbers || grid)
    {
	$.ajax({
            type: 'POST',
            url: 'index.php?route=openstock/openstock/optionStatus',
            dataType: 'json',
            data: 'var=' + optionStr + '&product_id=<?php echo $product_id; ?>',
            beforeSend: function() {
                if(grid){
                    $('.success, .warning, .loading').remove();
                    $(".grade").after('<div class="loading"><?php echo $text_checking_options; ?></div>');
                }else{
                    $('.success, .warning').remove();
                    $('.options').after('<div class="loading"><?php echo $text_checking_options; ?></div>');
                    //$('.product-info .price').html('').hide();
                }
            },
            complete: function() {},
            success: function(data) {

               
                if (!data.error) {
                    setTimeout(function(){

                        stringPrice = '<?php echo $text_price; ?> '+data.data.pricetax+'<br /><?php if ($tax) { ?><span class="price-tax"><?php echo $text_tax; ?> '+data.data.price+'</span><?php } ?>';

                        stringDiscount = '';
                        if(data.data.discount){
                            stringDiscount = '<br /><div class="discount">';

                            $.each(data.data.discount, function(discountKey, discountAmt) { 
                                stringDiscount += discountAmt+'<br />';
                            });

                            stringDiscount += '</div>';
                        }

                        if(data.data.nodiscount){
                            stringDiscount = '<br /><div class="discount">'+data.data.nodiscount+'</div>';
                        }

                        if (data.error) {
                            $('.loading').removeClass('loading').addClass('warning').empty().text(data.error);
                            //$('#product-cart').hide();
                        }

                        if (data.success) {
                            var mensagem = $('.loading');
                            
                            console.log(quantity_now)
                            
                            if(quantity_now > parseInt(data.data.stock)){
                                mensagem.removeClass("loading").addClass('success').empty().text(data.success);
                                updatePrice(stringPrice,stringDiscount);
                                
                                //$('#product-cart').show();
                                                        
                                input.val(data.data.stock);
                            }else{
                                mensagem.remove();
                            }
                        }

                        if (data.nostock) {
                            $('.loading').removeClass('loading').addClass('warning').empty().text(data.nostock);
                            updatePrice(stringPrice,stringDiscount);

                            if(data.nostockcheckout == 1)
                            {
                               // $('#product-cart').show();
                            }else{
                                //$('#product-cart').hide();
                            }
                        }

                        if (data.notactive) {
                            $('.loading').removeClass('loading').addClass('warning').empty().text(data.notactive);
                            updatePrice(stringPrice,stringDiscount);
                            $('#product-cart').hide();
                        }

                        /* Image swapping for variant */
                        if(data.data.image !='')
                        {
                            $('#image').attr('src', data.data.thumb);
                            $('.image a').attr('href', data.data.pop);
                        }else{
                            $('#image').attr('src', imgThumbOriginal);
                            $('.image a').attr('href', imgPopOriginal);
                        }
                        
                        
                        function updatePrice(stringPrice,stringDiscount){
                            if(!grid)
                                $('.product-info .price').html(stringPrice).append(stringDiscount).show();
                        }
                        
                    }, 500);
                }else{
                    $('.success, .warning, .loading').remove();
                }
            }
	});
    }
});
//--></script>
<?php echo $footer; ?>