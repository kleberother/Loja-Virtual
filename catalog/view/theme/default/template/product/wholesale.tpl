<?php echo $header; ?><?php echo $column_left; ?><?php echo $column_right; ?>
<section id="content"><?php echo $content_top; ?>
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
 
  <h1><span><?php echo $heading_title; ?></span></h1>

  
  <?php if ($products) { ?>
  <div class="product-compare"><a href="<?php echo $compare; ?>" id="compare-total"><?php echo $text_compare; ?></a></div>
  
  <div class="product-list wholesale">
  
  	
    <?php foreach ($products as $product) { ?>
	<div>
        <div class="right">
            <div class="cart">        
                <?php if($product['option']){ 
                    
                    foreach ($product['option'] as $option){
                        switch(strtoupper($option["name"])){
                            case "CORES":
                                $cores = $option;
                                break;
                            case "TAMANHOS":
                                $tamanhos = $option;
                                break;
                        }
                    }
                    
                    
                    ?>
                    
                    <div>
                        <table class="grade" cellpadding="2" cellspacing="0" border="0" data-product-id="<?php echo $product['product_id']; ?>">
                            <tr>
	                            <td></td>
    	                        <td></td>
        	                    <?php foreach ($tamanhos["option_value"] as $tamanho){ ?>
            	                <td align="center"><?php echo $tamanho["name"]; ?></td>
                	            <?php } ?>
                            </tr>
                            <?php foreach ($cores["option_value"] as $cor){ ?>                
                            <tr>
                    	        <td></td>
	                            <td align="right">
    		                        <?php echo $cor["name"]; ?>
            	                </td>
                	            <?php foreach ($tamanhos["option_value"] as $tamanho){ ?>
                    	        <td>
                        	        <input type="text" name="cor_<?php echo $cores['product_option_id']; ?>_<?php echo $cor['product_option_value_id']; ?>xtamanho_<?php echo $tamanhos['product_option_id']; ?>_<?php echo $tamanho['product_option_value_id']; ?>" size="2" value="0" style="width:20px" />
                            	</td>
	                            <?php } ?>                    
    	                    </tr>
                            <?php } ?>
                        </table>
                    </div>
                    
                <?php } ?>
                <div class="wishlist"></div>
                <div class="compare"></div>            
            </div>

        </div>


    
        <div class="left">	
        
          <?php if ($product['thumb'] && !$product['images'] ) { ?>
          <div class="image" style="">
			<a href="<?php echo $product['thumb']['image']; ?>" class="cloud-zoom" rel="position:'right', showTitle: false, adjustY: -120"  title="<?php echo $product['name']; ?>>" ><img src="<?php echo $product['thumb']['thumb']; ?>" title="<?php echo $product['name']; ?>>" alt="<?php echo $product['name']; ?>" /></a>          
          </div>
          <?php } ?>
          
          <?php
          
            if ($product['images']) { 
            
            	foreach($product['images'] as $image){
          ?>
          <div class="image" style="">
			<a href="<?php echo $image['image']; ?>" class="cloud-zoom" rel="position:'right', showTitle: false, adjustY: -120"  title="<?php echo $product['name']; ?>>" ><img src="<?php echo $image['thumb']; ?>" title="<?php echo $product['name']; ?>>" alt="<?php echo $product['name']; ?>" /></a>          
          </div>
          <?php
          		}
			} 
            
		  ?>          
          
          <div class="name"><a href="<?php echo $product['href']; ?>"><?php echo $product['name']; ?><sup><?php echo $product['model']; ?></sup></a></div>
          <div class="description"><?php echo $product['description']; ?></div>
          
          <?php if ($product['price']) { ?>
          <div class="price">
            <?php if (!$product['special']) { ?>
            <?php echo $product['price']; ?>
            <?php } else { ?>
            <span class="price-old"><?php echo $product['price']; ?></span> <span class="price-new"><?php echo $product['special']; ?></span>
            <?php } ?>
            <?php if ($product['tax']) { ?>
            <br />
            <span class="price-tax"><?php echo $text_tax; ?> <?php echo $product['tax']; ?></span>
            <?php } ?>
          </div>
          <?php } ?>
          <?php if ($product['rating']) { ?>
          <div class="rating"><img src="catalog/view/theme/ustore-color1/image/stars-<?php echo $product['rating']; ?>.png" alt="<?php echo $product['reviews']; ?>" /></div>
          <?php } ?>
        
        </div>
        <br clear="all" />      
	</div>    
    <?php } ?>
    
    
    
  </div>
  
  
  
  <div class="pagination"><?php echo $pagination; ?></div>
  <?php } ?>
  
  <?php if (!$categories && !$products) { ?>
  <div class="content"><?php echo $text_empty; ?></div>
  <div class="buttons">
    <div class="right"><a href="<?php echo $continue; ?>" class="button"><?php echo $button_continue; ?></a></div>
  </div>
  <?php } ?>
  
  
  <div>
  
  <?php echo $content_bottom; ?></section>
  
  <div class="wholesale_cart">
  	<div class="wholesale_box">
    
      <div class="heading">
        <a><span class="wholesale-total"><?php echo $text_items; ?></span></a>
        <a class="button" href="<?php echo $cart; ?>"><span><?php echo $text_cart; ?></span></a>
      </div>
	</div>
  </div>
<link rel="stylesheet" type="text/css" href="catalog/view/javascript/jquery/cloud-zoom/cloud-zoom.css" />
<style type="text/css">
    
.wholesale > div { overflow:visible !important; }
.wholesale_cart { position: fixed; 	z-index: 999999; 	left: 0px; 	width: 100%;	bottom: 0; }
.wholesale_cart a { text-decoration:none; }
.wholesale_cart .wholesale_box { max-width:964px; margin:0 auto; background: none repeat scroll 0 0 #585858; padding:10px; text-align:right; }
.wholesale_cart .wholesale_box .wholesale-total { color: white; font-size: 17px; padding: 5px 20px; display: inline; }

</style>
<script type="text/javascript" src="catalog/view/javascript/jquery/cloud-zoom/cloud-zoom.1.0.2.min.js"></script>
<script type="text/javascript">

$(function(){
        
		$(".grade input").live("keyup keydown",function(){			


			var objeto = $(this);
			var opcoes = $(this).attr("name").split("x");
							
			var cores = opcoes[0].split("_");
			var tamanhos = opcoes[1].split("_");         
			
			title_tamanho = "option[" + tamanhos[1] + "][]";
			title_cor = "option[" + cores[1] + "][]";			
			
			var product_id = $(this).parents("table").eq(0).attr("data-product-id");
			var options =  title_tamanho +"="+ tamanhos[2] +"&"+ title_cor +"="+ cores[2] +"&"+ "quantity" +"="+ $(this).val() +"&"+ "product_id" +"="+ product_id;
			
			$.ajax({
				url: 'index.php?route=checkout/cart/update',
				type: 'post',
				data: options,
				dataType: 'json',
				success: function(json) {
					
					$('.success, .warning, .attention, information, .error').remove();
					objeto.css({"background":"#89b403"});
					setTimeout(function(){
						objeto.css({"background":"#FFF"});
					},1000);
					
					if (json['success']) {
						
						$('#cart-total, .wholesale-total').html(json['total']);
					}	
				}
			});
			 		
			
			
			
		});
		
		$('.product-list').infinitescroll({
			
			navSelector  : "div.links",            
			nextSelector : "div.pagination a:first",    
			itemSelector : ".product-list > div",
			msgText		 : "Carregando produtos", 
			finishedMsg  : "Todos os produtos carregados"

		},function(){
			
			$(".pagination .results").hide();			
	        $('.cloud-zoom, .cloud-zoom-gallery').CloudZoom();
			
		});
	            
});
       


</script> 
<?php echo $footer; ?>